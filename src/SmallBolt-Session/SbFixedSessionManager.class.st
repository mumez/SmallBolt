Class {
	#name : #SbFixedSessionManager,
	#superclass : #SbClientSessionManager,
	#category : #'SmallBolt-Session'
}

{ #category : #private }
SbFixedSessionManager >> getClientAt: aClientKindKey [
	| clients |
	clients := lock
		critical: [ clientsMap
				at: aClientKindKey
				ifAbsentPut: [ | queue |
					queue := SharedQueue new.
					queue nextPut: (self newClientAt: aClientKindKey).
					queue ] ].
	^ clients next
]

{ #category : #private }
SbFixedSessionManager >> returnClient: client at: aClientKindKey [
	| clients |
	clients := lock critical: [ clientsMap at: aClientKindKey ].
	clients nextPut: client
]

{ #category : #private }
SbFixedSessionManager >> standbyClientAt: aClientKindKey [
	| clients |
	clients := lock
		critical:
			[ clientsMap at: aClientKindKey ifAbsentPut: [ SharedQueue new ] ].
	clients size < self maxClientsPerKey
		ifTrue: [ clients nextPut: (self newClientAt: aClientKindKey) ]
]
