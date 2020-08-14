Class {
	#name : #SmClientSessionManager,
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
SmClientSessionManager class >> default [
	^default ifNil: [ default := self new ]
]

{ #category : #'class initialization' }
SmClientSessionManager class >> initialize [
	default := nil.
	logger := nil.
]

{ #category : #accessing }
SmClientSessionManager class >> logger [
	^logger ifNil: [ logger := SmLocalLogger new ]
]

{ #category : #accessing }
SmClientSessionManager class >> logger: anLogger [
	^logger := anLogger
]

{ #category : #private }
SmClientSessionManager >> applySettingsTo: newClient at: clientKindKey [
	| settingsBlock |
	settingsBlock := self clientSettingsMap at: clientKindKey ifAbsent: [].
	settingsBlock ifNotNil: [ 
		settingsBlock value: newClient settings.
	]
]

{ #category : #actions }
SmClientSessionManager >> clientDo: aBlock [
	^ self clientDo: aBlock at: self defaultClientKindKey
]

{ #category : #actions }
SmClientSessionManager >> clientDo: aBlock at: key [
	| client result |
	client := self getClientAt: key.
	client connect.
	result := [ aBlock value: client ]
		ensure: [ self returnClient: client at: key ].
	^ result
]

{ #category : #accessing }
SmClientSessionManager >> clientSettingsMap [
	^clientSettingsMap ifNil: [ clientSettingsMap := Dictionary new ]
]

{ #category : #accessing }
SmClientSessionManager >> clientSettingsMap: aDictionary [
	clientSettingsMap := aDictionary 
]

{ #category : #defaults }
SmClientSessionManager >> defaultClientKindKey [
	^#default
]

{ #category : #defaults }
SmClientSessionManager >> defaultMaxClientsPerKey [
	^ 10
]

{ #category : #private }
SmClientSessionManager >> getClientAt: clientKindKey [
	| clients |
	^ lock
		critical: [ clients := clientsMap at: clientKindKey ifAbsentPut: [ OrderedCollection new ].
			clients ifEmpty: [ clients add: (self newClientAt: clientKindKey) ].
			clients removeFirst ]
]

{ #category : #'initialize-release' }
SmClientSessionManager >> initialize [
	super initialize.
	lock := Monitor new.
	clientsMap := Dictionary new.
	clientSettingsMap := Dictionary new
]

{ #category : #accessing }
SmClientSessionManager >> maxClientsPerKey [
	^ self settings maxClientsPerKey 
]

{ #category : #private }
SmClientSessionManager >> newClientAt: clientKindKey [
	| newClient |
	newClient := self smallBoltClientClass new.
	self applySettingsTo: newClient at: clientKindKey.
	newClient connect.
	^newClient
]

{ #category : #actions }
SmClientSessionManager >> registerSetting: settingsBlock [
	self registerSetting: settingsBlock at: self defaultClientKindKey  
]

{ #category : #actions }
SmClientSessionManager >> registerSetting: settingsBlock at: clientKindKey [ 
	self clientSettingsMap at: clientKindKey put: settingsBlock
]

{ #category : #'initialize-release' }
SmClientSessionManager >> release [
	clientsMap keysAndValuesDo: [ :key :eachCol | eachCol do: [:each | each release]].
	clientsMap := Dictionary new.
]

{ #category : #private }
SmClientSessionManager >> returnClient: client at: clientKindKey [
	lock
		critical: [ | clients |
			clients := clientsMap at: clientKindKey.
			clients size >= self maxClientsPerKey
				ifTrue: [ client release ]
				ifFalse: [ clients add: client ] ]
]

{ #category : #accessing }
SmClientSessionManager >> settings [
	^settings ifNil: [ settings := SbSettings default ]
]

{ #category : #accessing }
SmClientSessionManager >> settings: aSbSettings [
	settings := aSbSettings
]

{ #category : #factory }
SmClientSessionManager >> smallBoltClientClass [
	^ SbClient
]

{ #category : #actions }
SmClientSessionManager >> standBy: clientNumber [
	self standBy: clientNumber setting: [:se |]
]

{ #category : #actions }
SmClientSessionManager >> standBy: clientNumber setting: settingsBlock [
	self standBy: clientNumber setting: settingsBlock at: self defaultClientKindKey
]

{ #category : #actions }
SmClientSessionManager >> standBy: clientNumber setting: settingsBlock at: clientKindKey [
	self registerSetting: settingsBlock at: clientKindKey.
	[ clientNumber timesRepeat: [ self standbyClientAt: clientKindKey ] ] fork.
]

{ #category : #private }
SmClientSessionManager >> standbyClientAt: clientKindKey [
	| clients |
	^ lock
		critical: [ clients := clientsMap
				at: clientKindKey
				ifAbsentPut: [ OrderedCollection new ].
			clients size < self maxClientsPerKey
				ifTrue: [ clients add: (self newClientAt: clientKindKey) ] ]
]
