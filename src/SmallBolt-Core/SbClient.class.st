Class {
	#name : #SbClient,
	#superclass : #SbObject,
	#instVars : [
		'settings',
		'factory'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #authentication }
SbClient >> authenticate [
	^(SbAuthenticator for: self) authenticate
]

{ #category : #releasing }
SbClient >> autoReleaseDo: aBlock [
	^ [ aBlock value: self factory ]
		ensure: [ self releaseFactory ]
]

{ #category : #accessing }
SbClient >> client [
	^ self
]

{ #category : #accessing }
SbClient >> factory [
	^factory ifNil: [ factory := SbExternalObjectFactory on: self settings ]
]

{ #category : #accessing }
SbClient >> factory: anObject [
	factory := anObject
]

{ #category : #'initialization-release' }
SbClient >> release [
	self releaseFactory 
]

{ #category : #releasing }
SbClient >> releaseFactory [
	factory ifNotNil: [ factory autoRelease ].
	factory := nil
]

{ #category : #accessing }
SbClient >> settings [
	^settings ifNil: [ settings := SbSettings default ]
]

{ #category : #accessing }
SbClient >> settings: anObject [
	settings := anObject
]
