Class {
	#name : #SbExternalObject,
	#superclass : #FFIExternalObject,
	#instVars : [
		'settings'
	],
	#pools : [
		'SbSeaboltConstants'
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
	inst settings: aSbSettings.
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

{ #category : #accessing }
SbExternalObject >> settings [
	^ settings
]

{ #category : #accessing }
SbExternalObject >> settings: anObject [
	settings := anObject
]
