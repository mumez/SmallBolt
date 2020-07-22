Class {
	#name : #SbBoltRequester,
	#superclass : #Object,
	#instVars : [
		'connection'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #'instance creation' }
SbBoltRequester class >> on: aSbBoldConnection [
	^ self new connection: aSbBoldConnection
]

{ #category : #accessing }
SbBoltRequester >> connection [
	^ connection
]

{ #category : #accessing }
SbBoltRequester >> connection: anObject [
	connection := anObject
]
