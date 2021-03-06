Class {
	#name : #SbBoltConnection,
	#superclass : #SbExternalObject,
	#instVars : [
		'connectionStateSymbol'
	],
	#category : #'SmallBolt-FFI'
}

{ #category : #actions }
SbBoltConnection >> address [
	^self ffi getAddressOnConnection: self
]

{ #category : #requesting }
SbBoltConnection >> checkSummaryRequestIsSuccessful [
	^ (self ffi getSummarySuccessOnConnection: self) = 1
]

{ #category : #actions }
SbBoltConnection >> clearBegin [
	^self ffi clearBeginOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> clearRun [
	^self ffi clearRunOnConnection: self
]

{ #category : #accessing }
SbBoltConnection >> connectionStateSymbol [
	^ connectionStateSymbol
]

{ #category : #accessing }
SbBoltConnection >> connectionStateSymbol: anObject [
	connectionStateSymbol := anObject
]

{ #category : #actions }
SbBoltConnection >> failureDetails [
	^self ffi getFailureDetailsOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> fieldNames [
	^self ffi getFieldNamesOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> fieldValues [
	^self ffi getFieldValuesOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> getLastRequest [
	^self ffi getLastRequestOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> id [
	^self ffi getIdOnConnection: self
]

{ #category : #testing }
SbBoltConnection >> isReady [
	^self connectionStateSymbol == #ready
]

{ #category : #actions }
SbBoltConnection >> loadBeginRequest [
	^self ffi loadBeginRequestOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> loadCommitRequest [
	^self ffi loadCommitRequestOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> loadDiscardRequest [
	^self ffi loadDiscardRequestOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> loadPullRequest [
	^self ffi loadPullRequestOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> loadResetRequest [
	^self ffi loadResetRequestOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> loadRollbackRequest [
	^self ffi loadRollbackRequestOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> loadRunRequest [
	^self ffi loadRunRequestOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> metadata [
	^self ffi getMetadataOnConnection: self
]

{ #category : #printing }
SbBoltConnection >> printOn: aStream [
	aStream nextPutAll: self className.
	aStream nextPutAll: ' ('.
	aStream nextPutAll: self connectionStateSymbol.
	aStream nextPutAll: ')'.
]

{ #category : #requesting }
SbBoltConnection >> requestBeginTransaction [
	self loadBeginRequest.
	^ self getLastRequest
]

{ #category : #requesting }
SbBoltConnection >> requestCommitTransaction [
	self loadCommitRequest.
	^ self getLastRequest
]

{ #category : #requesting }
SbBoltConnection >> requestDiscard [
	self loadDiscardRequest.
	^ self getLastRequest
]

{ #category : #requesting }
SbBoltConnection >> requestPull [
	self loadPullRequest.
	^ self getLastRequest
]

{ #category : #requesting }
SbBoltConnection >> requestReset [
	self loadResetRequest.
	^ self getLastRequest
]

{ #category : #requesting }
SbBoltConnection >> requestRollbackTransaction [
	self loadRollbackRequest.
	^ self getLastRequest
]

{ #category : #requesting }
SbBoltConnection >> requestRunCypher: cypherString [
	self setRunCypher: cypherString.
	self loadRunRequest.
	^ self getLastRequest
]

{ #category : #requesting }
SbBoltConnection >> requestRunCypher: cypherString parameters: paramsDict [
	self setRunCypher: cypherString parameters: paramsDict.
	self loadRunRequest.
	^ self getLastRequest
]

{ #category : #requesting }
SbBoltConnection >> requestRunTransactionTimeout: timeout [
	self setRunTransactionTimeout: timeout.
	self loadRunRequest.
	^ self getLastRequest
]

{ #category : #actions }
SbBoltConnection >> send [
	^self ffi sendOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> server [
	^self ffi getServerOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> setRunCypher: cypherString [
	^self ffi setRunCypher: cypherString asString onConnection: self
]

{ #category : #actions }
SbBoltConnection >> setRunCypher: cypherString numberOfParameters: numberOfParameters [
	^self ffi setRunCypher: cypherString asString numberOfParameters: numberOfParameters onConnection: self
]

{ #category : #actions }
SbBoltConnection >> setRunCypher: cypherString parameters: paramsDict [
	| index |
	self ffi setRunCypher: cypherString asString numberOfParameters: paramsDict size onConnection: self.
	index := 0.
	paramsDict keysAndValuesDo: [ :key :stValue | | sbValue |
		sbValue := self setRunCypherParameterName: key at: index.
		sbValue value: stValue.
		index := index + 1. 
	]
]

{ #category : #actions }
SbBoltConnection >> setRunCypherParameterName: paramNameString at: index [ 
	^self ffi setRunCypherParameter: paramNameString asString at: index onConnection: self
]

{ #category : #actions }
SbBoltConnection >> setRunTransactionMetadata: cypherString [
	^self ffi setRunTransactionMetadata: cypherString asString onConnection: self
]

{ #category : #actions }
SbBoltConnection >> setRunTransactionTimeout: metadata [
	^self ffi setRunTransactionTimeout: metadata asString onConnection: self
]

{ #category : #actions }
SbBoltConnection >> status [
	^self ffi getStatusOnConnection: self
]

{ #category : #requesting }
SbBoltConnection >> statusAfterRequest: aSbBoltRequest [
	aSbBoltRequest summaryOn: self.
	^ self status
]
