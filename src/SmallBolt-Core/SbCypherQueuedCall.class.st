Class {
	#name : #SbCypherQueuedCall,
	#superclass : #Object,
	#instVars : [
		'connection',
		'cypherString',
		'runRequest',
		'pullRequest'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #'instance creation' }
SbCypherQueuedCall class >> on: aSbBoldConnection [
	^ self new connection: aSbBoldConnection
]

{ #category : #accessing }
SbCypherQueuedCall >> connection [
	^ connection
]

{ #category : #accessing }
SbCypherQueuedCall >> connection: anObject [
	connection := anObject
]

{ #category : #private }
SbCypherQueuedCall >> cypherResult: status fieldNames: fieldNames records: records from: aCypherString [
	^ SbCypherResult
		status: status fieldNames: fieldNames records: records cypher: aCypherString
]

{ #category : #accessing }
SbCypherQueuedCall >> cypherString [
	^ cypherString
]

{ #category : #accessing }
SbCypherQueuedCall >> cypherString: anObject [
	cypherString := anObject
]

{ #category : #accessing }
SbCypherQueuedCall >> pullRequest [
	^ pullRequest
]

{ #category : #accessing }
SbCypherQueuedCall >> pullRequest: anObject [
	pullRequest := anObject
]

{ #category : #actions }
SbCypherQueuedCall >> pullResult [
	| fieldNames records status |
	records := fieldNames := #().
	status := self connection statusAfterRequest: self runRequest.
	
	status isSuccess ifTrue: [ 
		fieldNames := self connection fieldNames value.
		records := self pullRequest recordsOn: self connection.
	].
	
	^ self
		cypherResult: status fieldNames: fieldNames records: records from: self cypherString
]

{ #category : #actions }
SbCypherQueuedCall >> pushRequestsFor: aCypherString [
	self cypherString: aCypherString.
	self runRequest: (self connection requestRunCypher: aCypherString).
	self pullRequest:  (self connection requestPull).
]

{ #category : #accessing }
SbCypherQueuedCall >> runRequest [
	^ runRequest
]

{ #category : #accessing }
SbCypherQueuedCall >> runRequest: anObject [
	runRequest := anObject
]
