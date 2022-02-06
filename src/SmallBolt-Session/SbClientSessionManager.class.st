Class {
	#name : #SbClientSessionManager,
	#superclass : #Object,
	#instVars : [
		'lock',
		'clientsMap',
		'settings',
		'clientSettingsMap',
		'clientKindKey'
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

{ #category : #releasing }
SbClientSessionManager class >> releaseAll [
	<script>
	^self allSubInstancesDo: [ :each | each release ]
]

{ #category : #private }
SbClientSessionManager >> applySettingsTo: newClient at: aClientKindKey [
	| settingsBlock |
	settingsBlock := self clientSettingsMap at: aClientKindKey ifAbsent: [].
	settingsBlock ifNotNil: [ 
		settingsBlock value: newClient settings.
	]
]

{ #category : #actions }
SbClientSessionManager >> clientDo: aBlock [
	^ self clientDo: aBlock at: self clientKindKey
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
SbClientSessionManager >> clientKindKey [
	^ clientKindKey ifNil: [ clientKindKey := self defaultClientKindKey ]
]

{ #category : #accessing }
SbClientSessionManager >> clientKindKey: aSymbol [
	clientKindKey := aSymbol 
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
	^self settings clientKindKey
]

{ #category : #private }
SbClientSessionManager >> getClientAt: aClientKindKey [
	| clients |
	^ lock
		critical: [ clients := clientsMap at: clientKindKey ifAbsentPut: [ OrderedCollection new ].
			clients ifEmpty: [ clients add: (self newClientAt: aClientKindKey) ].
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
SbClientSessionManager >> newClientAt: aClientKindKey [
	| newClient |
	newClient := self smallBoltClientClass new.
	self applySettingsTo: newClient at: aClientKindKey.
	newClient connect.
	^newClient
]

{ #category : #'startup-shutdown' }
SbClientSessionManager >> onImageQuit [
	self release
]

{ #category : #'startup-shutdown' }
SbClientSessionManager >> onImageResume [
]

{ #category : #actions }
SbClientSessionManager >> registerSetting: settingsBlock [
	self registerSetting: settingsBlock at: self clientKindKey  
]

{ #category : #actions }
SbClientSessionManager >> registerSetting: settingsBlock at: aClientKindKey [ 
	self clientSettingsMap at: aClientKindKey put: settingsBlock
]

{ #category : #'initialize-release' }
SbClientSessionManager >> release [
	clientsMap keysAndValuesDo: [ :key :eachCol | eachCol do: [:each | each release]].
	clientsMap := Dictionary new.
	settings := nil.
]

{ #category : #private }
SbClientSessionManager >> returnClient: client at: aClientKindKey [
	lock
		critical: [
			clientsMap at: aClientKindKey ifPresent: [:clients |
				clients size >= self maxClientsPerKey
					ifTrue: [ client release ]
					ifFalse: [ clients add: client ]
			]]
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
	self standBy: clientNumber setting: [:se |
		se extractFrom: self settings
	]
]

{ #category : #actions }
SbClientSessionManager >> standBy: clientNumber setting: settingsBlock [
	self standBy: clientNumber setting: settingsBlock at: self clientKindKey
]

{ #category : #actions }
SbClientSessionManager >> standBy: clientNumber setting: settingsBlock at: aClientKindKey [
	self registerSetting: settingsBlock at: aClientKindKey.
	[ clientNumber timesRepeat: [ self standbyClientAt: aClientKindKey ] ] fork.
]

{ #category : #private }
SbClientSessionManager >> standbyClientAt: aClientKindKey [
	| clients |
	^ lock
		critical: [ clients := clientsMap
				at: aClientKindKey
				ifAbsentPut: [ OrderedCollection new ].
			clients size < self maxClientsPerKey
				ifTrue: [ clients add: (self newClientAt: aClientKindKey) ] ]
]
