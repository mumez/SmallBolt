Class {
	#name : #SbStructure,
	#superclass : #Object,
	#instVars : [
		'typeCode',
		'fields'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #'instance creation' }
SbStructure class >> typeCode: typeCode fields: fields [
	^ self new typeCode: typeCode; fields: fields; yourself
]

{ #category : #accessing }
SbStructure >> fields [
	^ fields
]

{ #category : #accessing }
SbStructure >> fields: anObject [
	fields := anObject
]

{ #category : #accessing }
SbStructure >> typeCode [
	^ typeCode
]

{ #category : #accessing }
SbStructure >> typeCode: anObject [
	typeCode := anObject
]
