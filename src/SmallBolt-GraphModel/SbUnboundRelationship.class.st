Class {
	#name : #SbUnboundRelationship,
	#superclass : #SbGraphObject,
	#instVars : [
		'type'
	],
	#category : #'SmallBolt-GraphModel'
}

{ #category : #actions }
SbUnboundRelationship >> bindNode: nodeA andNode: nodeB directed: direction [
]

{ #category : #'initialize-release' }
SbUnboundRelationship >> initByStructureFields: fieldsArray [
	super initByStructureFields: fieldsArray.
	self type: (fieldsArray at: 2).
	self properties: (fieldsArray at: 3).
	
]

{ #category : #testing }
SbUnboundRelationship >> isRelationship [
	^true
]

{ #category : #testing }
SbUnboundRelationship >> isUnbound [
	^true
]

{ #category : #accessing }
SbUnboundRelationship >> type [
	^ type
]

{ #category : #accessing }
SbUnboundRelationship >> type: anObject [
	type := anObject
]
