Class {
	#name : #SbBoltRequester,
	#superclass : #Object,
	#instVars : [
		'connection'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #'instance creation' }
SbBoltRequester class >> on: aSbBoldConnection [
	^ self new connection: aSbBoldConnection
]

{ #category : #transactions }
SbBoltRequester >> basicTransactionDo: aBlock ifFailed: failureBlock [
	| status ret |
	status := self beginTransaction.
	status isSuccess ifFalse: [ ^ failureBlock value: status ].
	ret := [aBlock cull: self] on: Error do: [:ex | ex inspect.  ^ failureBlock value: self rollbackTransaction].
	status := self commitTransaction.
	status isSuccess ifFalse: [ ^ failureBlock value: status ].
	^ ret
	
]

{ #category : #transactions }
SbBoltRequester >> beginTransaction [
	| request |
	request := self connection requestBeginTransaction.
	self connection send.
	^ self connection statusAfterRequest: request
	
]

{ #category : #transactions }
SbBoltRequester >> commitTransaction [
	| request |
	request := self connection requestCommitTransaction.
	self connection send.
	^ self connection statusAfterRequest: request
]

{ #category : #accessing }
SbBoltRequester >> connection [
	^ connection
]

{ #category : #accessing }
SbBoltRequester >> connection: anObject [
	connection := anObject
]

{ #category : #private }
SbBoltRequester >> cypherResult: status fieldNames: fieldNames records: records from: cypherString [
	^ SbCypherResult
		status: status fieldNames: fieldNames records: records cypher: cypherString
]

{ #category : #transactions }
SbBoltRequester >> rollbackTransaction [
	| request |
	request := self connection requestRollbackTransaction.
	self connection send.
	^ self connection statusAfterRequest: request
]

{ #category : #'running-cypher' }
SbBoltRequester >> runCypher: cypherString [
	| runRequest pullRequest status fieldNames records |
	runRequest := self connection requestRunCypher: cypherString.
	pullRequest := self connection requestPull.
	self connection send.
	
	records := fieldNames := #().
	status := self connection statusAfterRequest: runRequest.
	
	status isSuccess ifTrue: [ 
		fieldNames := self connection fieldNames value.
		records := pullRequest recordsOn: self connection.
	].
	
	^ self
		cypherResult: status fieldNames: fieldNames records: records from: cypherString
]

{ #category : #'running-cypher' }
SbBoltRequester >> transactCypher: cypherString [
	^ self transactionDo: [ 
		self runCypher: cypherString
	]
]

{ #category : #transactions }
SbBoltRequester >> transactionDo: aBlock [
	^ self basicTransactionDo: aBlock ifFailed: [ :status | status raiseIfError].
	
]
