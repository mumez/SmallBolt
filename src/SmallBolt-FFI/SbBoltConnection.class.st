Class {
	#name : #SbBoltConnection,
	#superclass : #SbExternalObject,
	#category : #'SmallBolt-FFI'
}

{ #category : #actions }
SbBoltConnection >> getLastRequest [
	^self ffi getLastRequestOnConnection: self
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
SbBoltConnection >> loadPullRequest [
	^self ffi loadPullRequestOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> loadRunRequest [
	^self ffi loadRunRequestOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> send [
	^self ffi sendOnConnection: self
]

{ #category : #actions }
SbBoltConnection >> setRunCypher: cypherString [
	^self ffi setRunCypher: cypherString asString onConnection: self
]

{ #category : #actions }
SbBoltConnection >> setRunCypher: cypherString numberOfParameters: numberOfParameters [
	^self ffi setRunCypher: cypherString asString numberOfParameters: numberOfParameters onConnection: self
]
