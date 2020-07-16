Class {
	#name : #SbExternalObjectFactory,
	#superclass : #Object,
	#instVars : [
		'pool',
		'settings'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #'initailize-release' }
SbExternalObjectFactory >> autoRelease [
	self pool autoRelease.
	self initPool
]

{ #category : #actions }
SbExternalObjectFactory >> create: aSbExternalObjectClass [
	| inst |
	inst := aSbExternalObjectClass on: self settings.
	self pool register: inst.
	^inst 
]

{ #category : #actions }
SbExternalObjectFactory >> createConnector: address token: token config: config [
	| inst |
	inst := SbBoltConnector address: address token: token config: config.
	inst initWithSettings: self settings.
	self pool register: inst.
	^inst
]

{ #category : #'initailize-release' }
SbExternalObjectFactory >> initPool [
	pool := SbExternalObjectPool new.
	
]

{ #category : #'initailize-release' }
SbExternalObjectFactory >> initialize [
	super initialize.
	self initPool
]

{ #category : #accessing }
SbExternalObjectFactory >> pool [
	^ pool
]

{ #category : #accessing }
SbExternalObjectFactory >> pool: anObject [
	pool := anObject
]

{ #category : #accessing }
SbExternalObjectFactory >> settings [
	^ settings ifNil: [ settings := SbSettings default ]
]

{ #category : #accessing }
SbExternalObjectFactory >> settings: anObject [
	settings := anObject
]
