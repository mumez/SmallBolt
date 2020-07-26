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
SbRelationship class >> json: jsonObject [
	| inst |
	inst := self new.
	inst id: (self portableUtil pickIdFrom: (jsonObject at: 'self')).
	inst type: (jsonObject at: 'type').
	inst startNodeId: (self portableUtil pickIdFrom: (jsonObject at: 'start')). 
	inst endNodeId: (self portableUtil pickIdFrom: (jsonObject at: 'end')). 
	
	^inst
]

{ #category : #'instance creation' }
SbRelationship class >> json: jsonObject for: startNode [
	| inst |
	inst := self new.
	inst id: (self portableUtil pickIdFrom: (jsonObject at: 'self')).
	inst type: (jsonObject at: 'type').
	inst startNodeId: (self portableUtil pickIdFrom: (jsonObject at: 'start')). 
	inst endNodeId: (self portableUtil pickIdFrom: (jsonObject at: 'end')). 
	inst direction: ((inst startNodeId = startNode id) ifTrue: [#out] ifFalse: [#in]). 
	inst db: startNode db.
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
	^'rel'
]

{ #category : #accessing }
SbRelationship >> endNode [
	^ self db nodeAt: self endNodeId
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
SbRelationship >> startNode [
	^ self db nodeAt: self startNodeId
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
