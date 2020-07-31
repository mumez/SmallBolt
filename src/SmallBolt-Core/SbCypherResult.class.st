Class {
	#name : #SbCypherResult,
	#superclass : #Object,
	#instVars : [
		'status',
		'fieldNames',
		'fieldValues',
		'cypher'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #'instance creation' }
SbCypherResult class >> status: status fieldNames: fieldNames fieldValues: fieldValues cypher: cypherString [
	^ self new
		status: status;
		fieldNames: fieldNames;
		fieldValues: fieldValues;
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

{ #category : #accessing }
SbCypherResult >> fieldValues [
	^ fieldValues
]

{ #category : #accessing }
SbCypherResult >> fieldValues: anObject [
	fieldValues := anObject
]

{ #category : #enumeration }
SbCypherResult >> fieldsDo: aBlock [
	| names |
	names := self fieldNames.
	self fieldValues do: [:eachRow |
		1 to: names size do: [:idx |
			aBlock value: (names at: idx) value: (eachRow at: idx).	
		]
	]
]

{ #category : #printing }
SbCypherResult >> printOn: aStream [
	aStream nextPutAll: self className.
	aStream nextPutAll: ' ('.
	self fieldNames printOn: aStream.
	aStream nextPutAll: ')'.
	
]

{ #category : #accessing }
SbCypherResult >> status [
	^ status
]

{ #category : #accessing }
SbCypherResult >> status: anObject [
	status := anObject
]
