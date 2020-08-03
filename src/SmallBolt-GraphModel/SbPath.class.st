Class {
	#name : #SbPath,
	#superclass : #SbGraphObject,
	#instVars : [
		'nodes',
		'sequence',
		'relationships',
		'unboundRelationships'
	],
	#category : #'SmallBolt-GraphModel'
}

{ #category : #private }
SbPath >> addRelationship: newRelationship [
	self relationships add: newRelationship
]

{ #category : #printing }
SbPath >> elementName [
	^'P'
]

{ #category : #accessing }
SbPath >> firstNode [
	^ self nodes at: 1
]

{ #category : #'initialization-release' }
SbPath >> initByStructureFields: fieldsArray [
	self nodes: (fieldsArray at: 1).
	self unboundRelationships: (fieldsArray at: 2).
	self sequence: (fieldsArray at: 3).
	
	self transmit 
]

{ #category : #accessing }
SbPath >> nodeAtId: nodeId [
	^self nodes detect: [ :each | each id = nodeId ] ifNone: [  ]
]

{ #category : #accessing }
SbPath >> nodes [
	^ nodes
]

{ #category : #accessing }
SbPath >> nodes: anObject [
	nodes := anObject
]

{ #category : #printing }
SbPath >> printElementHeaderOn: aStream [
	aStream nextPutAll: self elementName.
]

{ #category : #printing }
SbPath >> printOn: aStream [
	super printOn: aStream.
	self printPathOn: aStream
]

{ #category : #printing }
SbPath >> printPathOn: aStream [
	self relationships asArray printOn: aStream
]

{ #category : #accessing }
SbPath >> relationships [
	^ relationships ifNil: [ relationships := OrderedCollection new ]
]

{ #category : #accessing }
SbPath >> relationships: anObject [
	relationships := anObject
]

{ #category : #accessing }
SbPath >> sequence [
	^ sequence
]

{ #category : #accessing }
SbPath >> sequence: anObject [
	sequence := anObject
]

{ #category : #private }
SbPath >> transmit [
	| currentNode |
	currentNode := self firstNode.
	self sequence pairsDo: [ :relId :nodeId | | unboundRel direction nextNode rel |
		unboundRel := self unboundRelationships at: relId abs.
		direction := relId > 0 ifTrue: [ #out ] ifFalse: [ #in ].
		nextNode := self nodes at: nodeId + 1.
		rel := SbRelationship fromUnbound: unboundRel.
		rel startNodeId: currentNode id endNodeId: nextNode id direction: direction.
		self addRelationship: rel.
		currentNode := nextNode.
	]
]

{ #category : #accessing }
SbPath >> unboundRelationships [
	^ unboundRelationships
]

{ #category : #accessing }
SbPath >> unboundRelationships: anObject [
	unboundRelationships := anObject
]
