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
	^'node'
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
