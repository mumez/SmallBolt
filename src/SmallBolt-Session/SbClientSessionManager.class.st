Class {
	#name : #SbClientSessionManager,
	#superclass : #Object,
	#instVars : [
		'lock',
		'clientsMap',
		'settings',
		'clientSettingsMap'
	],
	#classInstVars : [
		'default',
		'maxRedisConnectionsPerKey',
		'logger'
	],
	#category : #'SmallBolt-Session'
}

{ #category : #'instance creation' }
SbClientSessionManager class >> default [
	^default ifNil: [ default := self new ]
]

{ #category : #'class initialization' }
SbClientSessionManager class >> initialize [
	default := nil.
	logger := nil.
]

{ #category : #accessing }
SbClientSessionManager class >> logger [
	^logger ifNil: [ logger := SbLocalLogger new ]
]

{ #category : #accessing }
SbClientSessionManager class >> logger: anLogger [
	^logger := anLogger
]

{ #category : #private }
SbClientSessionManager >> applySettingsTo: newClient at: clientKindKey [
	| settingsBlock |
	settingsBlock := self clientSettingsMap at: clientKindKey ifAbsent: [].
	settingsBlock ifNotNil: [ 
		settingsBlock value: newClient settings.
	]
]

{ #category : #actions }
SbClientSessionManager >> clientDo: aBlock [
	^ self clientDo: aBlock at: self defaultClientKindKey
]

{ #category : #actions }
SbClientSessionManager >> clientDo: aBlock at: key [
	| client result |
	client := self getClientAt: key.
	client connect.
	result := [ aBlock value: client ]
		ensure: [ self returnClient: client at: key ].
	^ result
]

{ #category : #accessing }
SbClientSessionManager >> clientSettingsMap [
	^clientSettingsMap ifNil: [ clientSettingsMap := Dictionary new ]
]

{ #category : #accessing }
SbClientSessionManager >> clientSettingsMap: aDictionary [
	clientSettingsMap := aDictionary 
]

{ #category : #defaults }
SbClientSessionManager >> defaultClientKindKey [
	^#default
]

{ #category : #defaults }
SbClientSessionManager >> defaultMaxClientsPerKey [
	^ 10
]

{ #category : #private }
SbClientSessionManager >> getClientAt: clientKindKey [
	| clients |
	^ lock
		critical: [ clients := clientsMap at: clientKindKey ifAbsentPut: [ OrderedCollection new ].
			clients ifEmpty: [ clients add: (self newClientAt: clientKindKey) ].
			clients removeFirst ]
]

{ #category : #'initialize-release' }
SbClientSessionManager >> initialize [
	super initialize.
	lock := Monitor new.
	clientsMap := Dictionary new.
	clientSettingsMap := Dictionary new
]

{ #category : #accessing }
SbClientSessionManager >> maxClientsPerKey [
	^ self settings maxClientsPerKey 
]

{ #category : #private }
SbClientSessionManager >> newClientAt: clientKindKey [
	| newClient |
	newClient := self smallBoltClientClass new.
	self applySettingsTo: newClient at: clientKindKey.
	newClient connect.
	^newClient
]

{ #category : #actions }
SbClientSessionManager >> registerSetting: settingsBlock [
	self registerSetting: settingsBlock at: self defaultClientKindKey  
]

{ #category : #actions }
SbClientSessionManager >> registerSetting: settingsBlock at: clientKindKey [ 
	self clientSettingsMap at: clientKindKey put: settingsBlock
]

{ #category : #'initialize-release' }
SbClientSessionManager >> release [
	clientsMap keysAndValuesDo: [ :key :eachCol | eachCol do: [:each | each release]].
	clientsMap := Dictionary new.
]

{ #category : #private }
SbClientSessionManager >> returnClient: client at: clientKindKey [
	lock
		critical: [ | clients |
			clients := clientsMap at: clientKindKey.
			clients size >= self maxClientsPerKey
				ifTrue: [ client release ]
				ifFalse: [ clients add: client ] ]
]

{ #category : #accessing }
SbClientSessionManager >> settings [
	^settings ifNil: [ settings := SbSettings default ]
]

{ #category : #accessing }
SbClientSessionManager >> settings: aSbSettings [
	settings := aSbSettings
]

{ #category : #factory }
SbClientSessionManager >> smallBoltClientClass [
	^ SbClient
]

{ #category : #actions }
SbClientSessionManager >> standBy: clientNumber [
	self standBy: clientNumber setting: [:se |]
]

{ #category : #actions }
SbClientSessionManager >> standBy: clientNumber setting: settingsBlock [
	self standBy: clientNumber setting: settingsBlock at: self defaultClientKindKey
]

{ #category : #actions }
SbClientSessionManager >> standBy: clientNumber setting: settingsBlock at: clientKindKey [
	self registerSetting: settingsBlock at: clientKindKey.
	[ clientNumber timesRepeat: [ self standbyClientAt: clientKindKey ] ] fork.
]

{ #category : #private }
SbClientSessionManager >> standbyClientAt: clientKindKey [
	| clients |
	^ lock
		critical: [ clients := clientsMap
				at: clientKindKey
				ifAbsentPut: [ OrderedCollection new ].
			clients size < self maxClientsPerKey
				ifTrue: [ clients add: (self newClientAt: clientKindKey) ] ]
]
