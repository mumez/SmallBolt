Class {
	#name : #SbBoltAddress,
	#superclass : #SbExternalObject,
	#category : #'SmallBolt-FFI'
}

{ #category : #'instance creation' }
SbBoltAddress class >> host: host port: port [
	^self ffi createAddress: host port: port asString
]

{ #category : #'instance creation' }
SbBoltAddress class >> on: aSbSettings [ 
	| inst |
	inst := self host: aSbSettings host port: aSbSettings port.
	inst initWithSettings: aSbSettings.
	^inst
]

{ #category : #releasing }
SbBoltAddress >> destroy [
	self ffi destroyAddress: self
]

{ #category : #accessing }
SbBoltAddress >> host [
	^ self ffi getHostOnAddress: self
]

{ #category : #accessing }
SbBoltAddress >> port [
	^ self ffi getPortOnAddress: self
]
