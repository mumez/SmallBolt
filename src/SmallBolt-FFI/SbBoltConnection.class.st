Class {
	#name : #SbBoltConnection,
	#superclass : #SbExternalObject,
	#category : #'SmallBolt-FFI'
}

{ #category : #'actions-basic' }
SbBoltConnection >> getLastRequest [
	^self ffi getLastRequestOnConnection: self
]

{ #category : #'actions-basic' }
SbBoltConnection >> loadBeginRequest [
	^self ffi loadBeginRequestOnConnection: self
]

{ #category : #'actions-basic' }
SbBoltConnection >> loadCommitRequest [
	^self ffi loadCommitRequestOnConnection: self
]

{ #category : #'actions-basic' }
SbBoltConnection >> loadPullRequest [
	^self ffi loadPullRequestOnConnection: self
]

{ #category : #'actions-basic' }
SbBoltConnection >> loadRollbackRequest [
	^self ffi loadRollbackRequestOnConnection: self
]

{ #category : #'actions-basic' }
SbBoltConnection >> loadRunRequest [
	^self ffi loadRunRequestOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> requestBeginTransaction [
	self loadBeginRequest.
	^ self getLastRequest
]

{ #category : #actions }
SbBoltConnection >> requestCommitTransaction [
	self loadCommitRequest.
	^ self getLastRequest
]

{ #category : #actions }
SbBoltConnection >> requestRollbackTransaction [
	self loadRollbackRequest.
	^ self getLastRequest
]

{ #category : #actions }
SbBoltConnection >> requestRunCypher: cypherString [
	self setRunCypher: cypherString.
	self loadRunRequest.
	^ self getLastRequest
]

{ #category : #'actions-basic' }
SbBoltConnection >> send [
	^self ffi sendOnConnection: self
]

{ #category : #'actions-basic' }
SbBoltConnection >> setRunCypher: cypherString [
	^self ffi setRunCypher: cypherString asString onConnection: self
]

{ #category : #'actions-basic' }
SbBoltConnection >> setRunCypher: cypherString numberOfParameters: numberOfParameters [
	^self ffi setRunCypher: cypherString asString numberOfParameters: numberOfParameters onConnection: self
]

{ #category : #'actions-basic' }
SbBoltConnection >> status [
	^self ffi getStatusOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> statusAfterRequest: aSbBoltRequest [
	aSbBoltRequest summaryOn: self.
	^ self status
]
