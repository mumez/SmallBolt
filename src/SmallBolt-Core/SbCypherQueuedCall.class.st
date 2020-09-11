Class {
	#name : #SbCypherQueuedCall,
	#superclass : #Object,
	#instVars : [
		'requester',
		'cypherString',
		'runRequest',
		'pullRequest'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #'instance creation' }
SbCypherQueuedCall class >> on: aSbRequester [
	^ self new requester: aSbRequester
]

{ #category : #accessing }
SbCypherQueuedCall >> connection [
	^ self requester connection
]

{ #category : #private }
SbCypherQueuedCall >> cypherResult: status fieldNames: fieldNames fieldValues: fieldValues from: aCypherString [
	^ SbCypherResult
		status: status fieldNames: fieldNames fieldValues: fieldValues cypher: aCypherString
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
	pullRequest := anObject.
	pullRequest valueFetcher: self valueFetcher.
]

{ #category : #actions }
SbCypherQueuedCall >> pullResult [
	| fieldNames fieldValues status |
	fieldValues := fieldNames := #().
	status := self connection statusAfterRequest: self runRequest.
	
	status isSuccess ifTrue: [ 
		fieldNames := self connection fieldNames value.
		fieldValues := self pullRequest fieldValuesOn: self connection.
	] ifFalse: [
		status raiseIfErrorOn: self connection
	].
	
	^ self cypherResult: status fieldNames: fieldNames fieldValues: fieldValues from: self cypherString
]

{ #category : #actions }
SbCypherQueuedCall >> pushRequestsFor: aCypherString [
	self cypherString: aCypherString.
	self runRequest: (self connection requestRunCypher: aCypherString).
	self pullRequest:  (self connection requestPull).
]

{ #category : #actions }
SbCypherQueuedCall >> pushRequestsFor: aCypherString parameters: paramsDict [
	self cypherString: aCypherString.
	self runRequest: (self connection requestRunCypher: aCypherString parameters: paramsDict).
	self pullRequest:  (self connection requestPull).
]

{ #category : #accessing }
SbCypherQueuedCall >> requester [
	^ requester
]

{ #category : #accessing }
SbCypherQueuedCall >> requester: anObject [
	requester := anObject
]

{ #category : #accessing }
SbCypherQueuedCall >> runRequest [
	^ runRequest
]

{ #category : #accessing }
SbCypherQueuedCall >> runRequest: anObject [
	runRequest := anObject
]

{ #category : #accessing }
SbCypherQueuedCall >> valueFetcher [
	^ self requester valueFetcher
]
