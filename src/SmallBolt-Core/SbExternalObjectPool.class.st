Class {
	#name : #SbExternalObjectPool,
	#superclass : #Object,
	#instVars : [
		'objects'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #finalization }
SbExternalObjectPool class >> finalizeResourceData: externalObjects [
	externalObjects do: [ :each | each destroy ]
]

{ #category : #'initailize-release' }
SbExternalObjectPool >> autoRelease [
	FFIExternalResourceManager addResource: self
]

{ #category : #'initailize-release' }
SbExternalObjectPool >> initialize [
	super initialize.
	objects := OrderedCollection new.
	
]

{ #category : #actions }
SbExternalObjectPool >> register: anSbExternalObject [
	objects add: anSbExternalObject
]

{ #category : #'initailize-release' }
SbExternalObjectPool >> resourceData [
	^objects asArray
]
