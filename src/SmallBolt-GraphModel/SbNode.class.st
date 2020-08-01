Class {
	#name : #SbNode,
	#superclass : #SbGraphObject,
	#instVars : [
		'labels'
	],
	#category : #'SmallBolt-GraphModel'
}

{ #category : #'instance creation' }
SbNode class >> json: jsonObject [
	| inst |
	inst := self new.
	inst id: (self portableUtil pickIdFrom: (jsonObject at: 'self')).
	inst properties: (jsonObject at: 'data').
	^inst
]

{ #category : #printing }
SbNode >> elementName [
	^'N'
]

{ #category : #'initialize - release' }
SbNode >> initByStructureFields: fieldsArray [
	super initByStructureFields: fieldsArray.
	self labels: (fieldsArray at: 2).
	self properties: (fieldsArray at: 3).
	
]

{ #category : #accessing }
SbNode >> label [
	^ (self labels ifEmpty: [#(nil)]) at: 1.
	
]

{ #category : #accessing }
SbNode >> labels [
	^ labels
]

{ #category : #accessing }
SbNode >> labels: aCollection [
	labels := aCollection
]

{ #category : #printing }
SbNode >> printElementHeaderOn: aStream [
	super printElementHeaderOn: aStream
]

{ #category : #printing }
SbNode >> printOn: aStream [
	self printElementHeaderOn: aStream.
	self labels ifEmpty: [ ^self ].
	aStream nextPutAll: self labels printString.
	
]
