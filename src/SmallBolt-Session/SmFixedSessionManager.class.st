Class {
	#name : #SmFixedSessionManager,
	#superclass : #SmClientSessionManager,
	#category : #'SmallBolt-Session'
}

{ #category : #private }
SmFixedSessionManager >> getClientAt: clientKindKey [
	^ lock
		critical: [ | clients |
			clients := clientsMap
				at: clientKindKey
				ifAbsentPut: [ | queue |
					queue := SharedQueue new.
					queue nextPut: (self newClientAt: clientKindKey).
					queue ].
			clients next ]
]

{ #category : #private }
SmFixedSessionManager >> returnClient: client at: clientKindKey [
	lock
		critical: [ | clients |
			clients := clientsMap at: clientKindKey.
			clients size >= self maxClientsPerKey
				ifTrue: [ client release ]
				ifFalse: [ clients nextPut: client ] ]
]

{ #category : #private }
SmFixedSessionManager >> standbyClientAt: clientKindKey [
	lock
		critical: [ | clients |
			clients := clientsMap
				at: clientKindKey
				ifAbsentPut: [ SharedQueue new ].
			clients size < self maxClientsPerKey
				ifTrue: [ clients nextPut: (self newClientAt: clientKindKey) ] ]
]
