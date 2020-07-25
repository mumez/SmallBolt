Class {
	#name : #SbBasicRequester,
	#superclass : #Object,
	#instVars : [
		'connection'
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
SbBasicRequester >> cypherResult: status fieldNames: fieldNames records: records from: cypherString [
	^ SbCypherResult
		status: status fieldNames: fieldNames records: records cypher: cypherString
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
	^ self runCyphers: (Array with: cypherString) 
]

{ #category : #'running-cypher' }
SbBasicRequester >> runCyphers: cypherStrings [
	| calls |
	calls := cypherStrings collect: [ :each | (SbCypherQueuedCall on: self connection) pushRequestsFor: each ].
	self connection send.
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
	^ self basicTransactionDo: aBlock ifFailed: [ :status | status raiseIfError].
	
]
