Class {
	#name : #SbBasicRequester,
	#superclass : #SbObject,
	#instVars : [
		'connection',
		'valueFetcher'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #'instance creation' }
SbBasicRequester class >> for: aSbBoltClient [
	^ (super for: aSbBoltClient)
		initByClient: aSbBoltClient;
		yourself
]

{ #category : #transactions }
SbBasicRequester >> basicTransactionDo: aBlock ifFailed: failureBlock [
	| status ret |
	status := self beginTransaction.
	status isSuccess ifFalse: [ ^ failureBlock value: status value: nil].
	ret := [aBlock cull: self] on: Error do: [:ex | ^ failureBlock value: self rollbackTransaction value: ex ].
	status := self commitTransaction.
	status isSuccess ifFalse: [ ^ failureBlock value: status value: nil].
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

{ #category : #actions }
SbBasicRequester >> discard [
	| request |
	request := self connection requestDiscard.
	self connection send.
	^ self connection statusAfterRequest: request
	
]

{ #category : #private }
SbBasicRequester >> flush [
	self connection send
]

{ #category : #'initialize - release' }
SbBasicRequester >> initByClient: aSbBoltClient [
	self
		connection: aSbBoltClient connection;
		valueFetcher: aSbBoltClient valueFetcher
]

{ #category : #'error handling' }
SbBasicRequester >> notifyTransactionFailed: anError [
	self logger error: anError.
	self settings shouldRaiseErrorOnTransactionFailed ifTrue: [ 
		anError pass	
	]
]

{ #category : #actions }
SbBasicRequester >> reset [
	| request |
	request := self connection requestReset.
	self connection send.
	^ self connection statusAfterRequest: request
	
]

{ #category : #transactions }
SbBasicRequester >> rollbackTransaction [
	| request |
	request := self connection requestRollbackTransaction.
	self connection send.
	^ self connection statusAfterRequest: request
]

{ #category : #'running-cypher' }
SbBasicRequester >> runCypher: cypherStatement [
	^(self runCyphers: (Array with: cypherStatement)) at: 1
]

{ #category : #'running-cypher' }
SbBasicRequester >> runCyphers: cypherStatements [
	| calls |
	calls := cypherStatements collect: [ :each | (SbCypherQueuedCall on: self) pushRequestsFor: each ].
	self flush.
	^ self safePullRequestsFrom: calls
]

{ #category : #'running-cypher' }
SbBasicRequester >> runCyphers: cypherStrings flushIf: aBlock [
	| lastIndex calls |
	lastIndex := cypherStrings size.
	calls := OrderedCollection new.
	cypherStrings withIndexDo: [ :idx :eachCypherStatement |
		calls add: ((SbCypherQueuedCall on: self) pushRequestsFor: eachCypherStatement).
		[(aBlock value: idx) and: [lastIndex ~= idx ]] ifTrue: [ self flush ]. 
	].
	self flush.
	^ self safePullRequestsFrom: calls
]

{ #category : #private }
SbBasicRequester >> safePullRequestsFrom: calls [
	^ [calls collect: [ :each | each pullResult ]] on: SbBoltError do: [ :ex |
		self reset.
		ex pass
	]
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
	^ self basicTransactionDo: aBlock ifFailed: [ :status :error | 
		error ifNotNil: [ 
			self notifyTransactionFailed: error
		]
		error
	].
	
]

{ #category : #accessing }
SbBasicRequester >> valueFetcher [
	^valueFetcher
]

{ #category : #accessing }
SbBasicRequester >> valueFetcher: anObject [
	valueFetcher := anObject
]
