Class {
	#name : #SbGraphObject,
	#superclass : #Object,
	#instVars : [
		'id',
		'properties',
		'structure'
	],
	#category : #'SmallBolt-GraphModel'
}

{ #category : #'instance creation' }
SbGraphObject class >> from: anSbStructure [
	^self new initByStructure: anSbStructure; yourself
]

{ #category : #comparing }
SbGraphObject >> = other [
	^ self class = other class and: [self id = other id]
]

{ #category : #properties }
SbGraphObject >> at: propName [ 
	"shortcut"
	^self propertyAt: propName
]

{ #category : #printing }
SbGraphObject >> elementName [
	^self class name
]

{ #category : #comparing }
SbGraphObject >> hash [
	^self id hash
]

{ #category : #accessing }
SbGraphObject >> id [
	"Answer the value of id"

	^ id
]

{ #category : #accessing }
SbGraphObject >> id: anObject [
	"Set the value of id"

	id := anObject
]

{ #category : #'initialize - release' }
SbGraphObject >> initByStructure: aSbStructure [
	structure := aSbStructure.
	self initByStructureFields: aSbStructure fields.
]

{ #category : #'initialize - release' }
SbGraphObject >> initByStructureFields: fieldsArray [
	self id: (fieldsArray at: 1).
]

{ #category : #testing }
SbGraphObject >> isNode [
	^false
]

{ #category : #testing }
SbGraphObject >> isPath [
	^false
]

{ #category : #testing }
SbGraphObject >> isRelationship [
	^false
]

{ #category : #accessing }
SbGraphObject >> name [
	^ self propertyAt: 'name' 
]

{ #category : #accessing }
SbGraphObject >> name: aString [
	self propertyAt: 'name' put: aString 
]

{ #category : #printing }
SbGraphObject >> printElementHeaderOn: aStream [
	aStream nextPutAll: self elementName.
	aStream nextPut: $:.
	aStream nextPutAll: self id printString
]

{ #category : #printing }
SbGraphObject >> printOn: aStream [
	self printElementHeaderOn: aStream
]

{ #category : #properties }
SbGraphObject >> properties [
	^ properties ifNil: [ properties := Dictionary new ]
]

{ #category : #properties }
SbGraphObject >> properties: props [
	properties := props
]

{ #category : #properties }
SbGraphObject >> propertyAt: propName [
	^ self properties at: propName ifAbsent: [  ]
]

{ #category : #accessing }
SbGraphObject >> structure [
	^ structure
]

{ #category : #accessing }
SbGraphObject >> structure: anObject [
	structure := anObject
]
