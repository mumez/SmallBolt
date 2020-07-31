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

{ #category : #enumeration }
SbCypherResult >> collect: aBlock [
	| col |
	col := OrderedCollection new.
	self do: [ :val | col add: (aBlock value: val) ].
	^col
]

{ #category : #accessing }
SbCypherResult >> cypher [
	^ cypher
]

{ #category : #accessing }
SbCypherResult >> cypher: anObject [
	cypher := anObject
]

{ #category : #enumeration }
SbCypherResult >> do: aBlock [
	self fieldsDo: [ :nm :val | aBlock value: val ]
]

{ #category : #accessing }
SbCypherResult >> fieldNames [
	^ fieldNames
]

{ #category : #accessing }
SbCypherResult >> fieldNames: anObject [
	fieldNames := anObject
]

{ #category : #enumeration }
SbCypherResult >> fieldsDo: aBlock [
	| names |
	names := self fieldNames.
	self records do: [:eachRow |
		1 to: names size do: [:idx |
			aBlock value: (names at: idx) value: (eachRow at: idx).	
		]
	]
]

{ #category : #accessing }
SbCypherResult >> record [
	self records ifEmpty: [ ^nil ].
	^ self records first
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
