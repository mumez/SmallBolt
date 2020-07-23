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

{ #category : #'running-cypher' }
SbBoltRequester >> runCypher: cypherString [
	| runRequest pullRequest status fieldNames records |
	runRequest := self connection requestRunCypher: cypherString.
	pullRequest := self connection requestPull.
	self connection send.
	
	records := fieldNames := #().
	status := self connection statusAfterRequest: runRequest.
	
	status isSuccess ifTrue: [ 
		fieldNames := self connection fieldNames.
		records := pullRequest recordsOn: self connection.
	].
	
	^ { status. fieldNames. records }
]
