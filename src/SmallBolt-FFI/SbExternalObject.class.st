Class {
	#name : #SbExternalObject,
	#superclass : #FFIExternalObject,
	#instVars : [
		'settings'
	],
	#pools : [
		'SbBoltConstants'
	],
	#classInstVars : [
		'ffi'
	],
	#category : #'SmallBolt-FFI'
}

{ #category : #'instance creation' }
SbExternalObject class >> create [
	"override"
	^self new
]

{ #category : #accessing }
SbExternalObject class >> ffi [
	^ffi ifNil: [ffi := SbSeaboltFFIFactory create]
]

{ #category : #accessing }
SbExternalObject class >> ffi: anObject [
	ffi := anObject
]

{ #category : #'class initialization' }
SbExternalObject class >> initialize [
	super initialize.
	ffi := nil
]

{ #category : #'instance creation' }
SbExternalObject class >> on: aSbSettings [ 
	| inst |
	inst := self create.
	inst initWithSettings: aSbSettings.
	^inst
]

{ #category : #accessing }
SbExternalObject >> ffi [
	^self class ffi
]

{ #category : #accessing }
SbExternalObject >> ffiLibraryName [
	^ SbSeaboltLibrary
]

{ #category : #'initailize-release' }
SbExternalObject >> initWithSettings: aSbSettings [ 
	self settings: aSbSettings.
	self setup
]

{ #category : #accessing }
SbExternalObject >> portableUtil [
	^SbPortableUtil default
]

{ #category : #accessing }
SbExternalObject >> settings [
	^ settings
]

{ #category : #accessing }
SbExternalObject >> settings: anObject [
	settings := anObject
]

{ #category : #'initailize-release' }
SbExternalObject >> setup [
	"override if you wish"
]
