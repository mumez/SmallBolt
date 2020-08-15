Class {
	#name : #SmFixedSessionManager,
	#superclass : #SmClientSessionManager,
	#category : #'SmallBolt-Session'
}

{ #category : #private }
SmFixedSessionManager >> getClientAt: clientKindKey [
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
SmFixedSessionManager >> returnClient: client at: clientKindKey [
	| clients |
	clients := lock critical: [ clientsMap at: clientKindKey ].
	clients nextPut: client
]

{ #category : #private }
SmFixedSessionManager >> standbyClientAt: clientKindKey [
	| clients |
	clients := lock
		critical:
			[ clientsMap at: clientKindKey ifAbsentPut: [ SharedQueue new ] ].
	clients size < self maxClientsPerKey
		ifTrue: [ clients nextPut: (self newClientAt: clientKindKey) ]
]
