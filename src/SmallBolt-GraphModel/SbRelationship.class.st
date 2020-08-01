Class {
	#name : #SbRelationship,
	#superclass : #SbGraphObject,
	#instVars : [
		'type',
		'direction',
		'startNodeId',
		'endNodeId'
	],
	#category : #'SmallBolt-GraphModel'
}

{ #category : #'instance creation' }
SbRelationship class >> fromUnbound: anUnboundRelationships [
	^ self id: anUnboundRelationships id type: anUnboundRelationships type properties: anUnboundRelationships properties 
]

{ #category : #'instance creation' }
SbRelationship class >> id: id type: type properties: properties [
	| inst |
	inst := self new.
	inst id: id.
	inst type: type.
	inst properties: properties.	
	^inst
]

{ #category : #accessing }
SbRelationship >> direction [
	"Answer the value of direction"

	^ direction
]

{ #category : #accessing }
SbRelationship >> direction: anObject [
	"Set the value of direction"

	direction := anObject
]

{ #category : #printing }
SbRelationship >> elementName [
	^'R'
]

{ #category : #accessing }
SbRelationship >> endNodeId [
	"Answer the value of endNodeId"

	^ endNodeId
]

{ #category : #accessing }
SbRelationship >> endNodeId: anObject [
	"Set the value of endNodeId"

	endNodeId := anObject
]

{ #category : #'initailize-release' }
SbRelationship >> initByStructureFields: fieldsArray [
	super initByStructureFields: fieldsArray.
	self startNodeId: (fieldsArray at: 2).
	self endNodeId: (fieldsArray at: 3).
	self type: (fieldsArray at: 4).
	self properties: (fieldsArray at: 5).
	
]

{ #category : #printing }
SbRelationship >> printOn: aStream [
	self printElementHeaderOn: aStream.
	aStream space.
	aStream nextPut: $(.
	aStream nextPutAll: self startNodeId asString.
	aStream nextPut: $).
	aStream space.
	self direction == #in ifTrue: [aStream nextPut: $<].
	aStream nextPut: $-.
	aStream nextPutAll: self type asString.
	aStream nextPut: $-.
	self direction == #out ifTrue: [aStream nextPut: $>].
	aStream space.
	aStream nextPut: $(.
	aStream nextPutAll: self endNodeId asString.
	aStream nextPut: $).
]

{ #category : #accessing }
SbRelationship >> startNodeId [
	"Answer the value of startNodeId"

	^ startNodeId
]

{ #category : #accessing }
SbRelationship >> startNodeId: anObject [
	"Set the value of startNodeId"

	startNodeId := anObject
]

{ #category : #'initailize-release' }
SbRelationship >> startNodeId: startNodeIdInteger endNodeId: encNodeIdInteger direction: outOrInSymbol [
	self startNodeId: startNodeIdInteger.
	self endNodeId: encNodeIdInteger.
	self direction: outOrInSymbol
]

{ #category : #accessing }
SbRelationship >> type [
	"Answer the value of type"

	^ type
]

{ #category : #accessing }
SbRelationship >> type: anObject [
	"Set the value of type"

	type := anObject
]
