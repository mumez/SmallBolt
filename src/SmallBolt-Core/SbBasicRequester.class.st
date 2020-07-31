Class {
	#name : #SbBasicRequester,
	#superclass : #Object,
	#instVars : [
		'connection',
		'valueFetcher'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #'instance creation' }
SbBasicRequester class >> on: aSbBoldConnection [
	^ self new connection: aSbBoldConnection
]

{ #category : #transactions }
SbBasicRequester >> basicTransactionDo: aBlock ifFailed: failureBlock [
	| status ret |
	status := self beginTransaction.
	status isSuccess ifFalse: [ ^ failureBlock value: status ].
	ret := [aBlock cull: self] on: Error do: [:ex | ex inspect.  ^ failureBlock value: self rollbackTransaction].
	status := self commitTransaction.
	status isSuccess ifFalse: [ ^ failureBlock value: status ].
	^ ret
	
]

{ #category : #transactions }
SbBasicRequester >> beginTransaction [
	| request |
	request := self connection requestBeginTransaction.
	self connection send.
	^ self connection statusAfterRequest: request
	
]

{ #category : #transactions }
SbBasicRequester >> commitTransaction [
	| request |
	request := self connection requestCommitTransaction.
	self connection send.
	^ self connection statusAfterRequest: request
]

{ #category : #accessing }
SbBasicRequester >> connection [
	^ connection
]

{ #category : #accessing }
SbBasicRequester >> connection: anObject [
	connection := anObject
]

{ #category : #private }
SbBasicRequester >> flush [
	self connection send
]

{ #category : #transactions }
SbBasicRequester >> rollbackTransaction [
	| request |
	request := self connection requestRollbackTransaction.
	self connection send.
	^ self connection statusAfterRequest: request
]

{ #category : #'running-cypher' }
SbBasicRequester >> runCypher: cypherString [
	^(self runCyphers: (Array with: cypherString)) at: 1
]

{ #category : #'running-cypher' }
SbBasicRequester >> runCyphers: cypherStrings [
	| calls |
	calls := cypherStrings collect: [ :each | (SbCypherQueuedCall on: self) pushRequestsFor: each ].
	self flush.
	^ calls collect: [ :each | each pullResult ]
]

{ #category : #'running-cypher' }
SbBasicRequester >> runCyphers: cypherStrings flushIf: aBlock [
	| lastIndex calls |
	lastIndex := cypherStrings size.
	calls := OrderedCollection new.
	cypherStrings withIndexDo: [ :idx :eachCypher |
		calls add: (SbCypherQueuedCall on: self).
		[(aBlock value: idx) and: [lastIndex ~= idx ]] ifTrue: [ self flush ]. 
	].
	self flush.
	^ calls collect: [ :each | each pullResult ]
]

{ #category : #'running-cypher' }
SbBasicRequester >> transactCypher: cypherString [
	^ self transactionDo: [ 
		self runCypher: cypherString
	]
]

{ #category : #'running-cypher' }
SbBasicRequester >> transactCyphers: cypherStrings [
	^ self transactionDo: [ 
		self runCyphers: cypherStrings
	]
]

{ #category : #transactions }
SbBasicRequester >> transactionDo: aBlock [
	^ self basicTransactionDo: aBlock ifFailed: [ :status | status raiseIfErrorOn: self connection].
	
]

{ #category : #accessing }
SbBasicRequester >> valueFetcher [
	^valueFetcher
]

{ #category : #accessing }
SbBasicRequester >> valueFetcher: anObject [
	valueFetcher := anObject
]
