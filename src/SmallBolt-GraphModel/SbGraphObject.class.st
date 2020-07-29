Class {
	#name : #SbGraphObject,
	#superclass : #Object,
	#instVars : [
		'id',
		'structure'
	],
	#category : #'SmallBolt-GraphModel'
}

{ #category : #'instance creation' }
SbGraphObject class >> from: anSbStructure [
	^self new structure: anSbStructure; yourself
]

{ #category : #'instance creation' }
SbGraphObject class >> id: anInteger [ 
	| inst |
	inst := self new.
	inst id: anInteger asInteger.
	^inst
]

{ #category : #comparing }
SbGraphObject >> = other [
	^ self class = other class and: [self id = other id]
]

{ #category : #private }
SbGraphObject >> asValueParameter: value [
	^value isString ifTrue: [ '"',value,'"' ] ifFalse: [ value ].
]

{ #category : #properties }
SbGraphObject >> at: propName [ 
	"shortcut"
	^self propertyAt: propName
]

{ #category : #properties }
SbGraphObject >> at: propName put: value [
	"shortcut"
	^self propertyAt: propName put: value
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

{ #category : #accessing }
SbGraphObject >> name [
	^ self propertyAt: 'name' 
]

{ #category : #accessing }
SbGraphObject >> name: aString [
	self propertyAt: 'name' put: aString 
]

{ #category : #factory }
SbGraphObject >> nodeClass [
	^N4Node
]

{ #category : #printing }
SbGraphObject >> printElementHeaderOn: aStream [
	aStream nextPutAll: self elementName.
	aStream nextPut: $[.
	aStream nextPutAll: self id printString.
	aStream nextPut: $]
	
]

{ #category : #printing }
SbGraphObject >> printOn: aStream [
	self printElementHeaderOn: aStream
]

{ #category : #properties }
SbGraphObject >> properties [
]

{ #category : #properties }
SbGraphObject >> properties: propAssocs [
]

{ #category : #properties }
SbGraphObject >> propertyAt: propName [ 
]

{ #category : #properties }
SbGraphObject >> propertyAt: propName put: value [
]

{ #category : #factory }
SbGraphObject >> relationshipClass [
	^N4Relationship
]

{ #category : #properties }
SbGraphObject >> removePropertyAt: propName [
]

{ #category : #accessing }
SbGraphObject >> structure [
	^ structure
]

{ #category : #accessing }
SbGraphObject >> structure: anObject [
	structure := anObject
]
