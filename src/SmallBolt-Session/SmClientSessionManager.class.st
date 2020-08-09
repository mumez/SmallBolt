Class {
	#name : #SmClientSessionManager,
	#superclass : #Object,
	#instVars : [
		'lock',
		'clientsMap',
		'maxClientsPerKey',
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
	settingsBlock := self clientSettingsMap at: newClient ifAbsent: [].
	settingsBlock ifNotNil: [ 
		settingsBlock value: newClient.
	]
]

{ #category : #actions }
SmClientSessionManager >> clientDo: aBlock [
	^ self clientDo: aBlock at: #default 
]

{ #category : #actions }
SmClientSessionManager >> clientDo: aBlock at: key [
	| client result |
	client := self getClientAt: key.
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
	^maxClientsPerKey ifNil: [ maxClientsPerKey := self defaultMaxClientsPerKey ]
]

{ #category : #accessing }
SmClientSessionManager >> maxClientsPerKey: anInteger [
	maxClientsPerKey := anInteger 
]

{ #category : #private }
SmClientSessionManager >> newClientAt: clientKindKey [
	| newClient |
	newClient := self smallBoltClientClass new.
	self applySettingsTo: newClient at: clientKindKey.
	^ newClient connect.
]

{ #category : #settings }
SmClientSessionManager >> registerSettings: settingsBlock at: clientKindKey [ 
	self clientSettingsMap at: clientKindKey put: settingsBlock
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

{ #category : #factory }
SmClientSessionManager >> smallBoltClientClass [
	^ SbClient
]
