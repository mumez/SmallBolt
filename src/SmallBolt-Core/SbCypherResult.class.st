Class {
	#name : #SbCypherResult,
	#superclass : #Object,
	#instVars : [
		'status',
		'fieldNames',
		'records',
		'cypher'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #'instance creation' }
SbCypherResult class >> status: status fieldNames: fieldNames records: records cypher: cypherString [
	^ self new
		status: status;
		fieldNames: fieldNames;
		records: records;
		cypher: cypherString;
		yourself
]

{ #category : #accessing }
SbCypherResult >> cypher [
	^ cypher
]

{ #category : #accessing }
SbCypherResult >> cypher: anObject [
	cypher := anObject
]

{ #category : #accessing }
SbCypherResult >> fieldNames [
	^ fieldNames
]

{ #category : #accessing }
SbCypherResult >> fieldNames: anObject [
	fieldNames := anObject
]

{ #category : #accessing }
SbCypherResult >> records [
	^ records
]

{ #category : #accessing }
SbCypherResult >> records: anObject [
	records := anObject
]

{ #category : #accessing }
SbCypherResult >> status [
	^ status
]

{ #category : #accessing }
SbCypherResult >> status: anObject [
	status := anObject
]
