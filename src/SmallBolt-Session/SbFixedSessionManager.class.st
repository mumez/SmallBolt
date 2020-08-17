Class {
	#name : #SbFixedSessionManager,
	#superclass : #SbClientSessionManager,
	#category : #'SmallBolt-Session'
}

{ #category : #private }
SbFixedSessionManager >> getClientAt: clientKindKey [
	| clients |
	clients := lock
		critical: [ clientsMap
				at: clientKindKey
				ifAbsentPut: [ | queue |
					queue := SharedQueue new.
					queue nextPut: (self newClientAt: clientKindKey).
					queue ] ].
	^ clients next
]

{ #category : #private }
SbFixedSessionManager >> returnClient: client at: clientKindKey [
	| clients |
	clients := lock critical: [ clientsMap at: clientKindKey ].
	clients nextPut: client
]

{ #category : #private }
SbFixedSessionManager >> standbyClientAt: clientKindKey [
	| clients |
	clients := lock
		critical:
			[ clientsMap at: clientKindKey ifAbsentPut: [ SharedQueue new ] ].
	clients size < self maxClientsPerKey
		ifTrue: [ clients nextPut: (self newClientAt: clientKindKey) ]
]
