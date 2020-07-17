Class {
	#name : #SbObject,
	#superclass : #Object,
	#instVars : [
		'settings',
		'factory'
	],
	#classInstVars : [
		'ffi'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #factory }
SbObject class >> createFfi [
	^SbSeaboltFFIFactory create
]

{ #category : #accessing }
SbObject class >> ffi [
	^ ffi ifNil: [ ffi := self createFfi]
]

{ #category : #accessing }
SbObject class >> ffi: anObject [
	ffi := anObject
]

{ #category : #'class initialization' }
SbObject class >> initialize [
	ffi := nil
]

{ #category : #'instance creation' }
SbObject class >> on: aSbSettings [
	^self new settings: aSbSettings; yourself
]

{ #category : #releasing }
SbObject class >> release [
	<script>
	ffi ifNotNil: [ ffi shutdown ].
	ffi := nil
]

{ #category : #accessing }
SbObject >> factory [
	^ factory ifNil: [ factory := SbExternalObjectFactory on: self settings ]
]

{ #category : #accessing }
SbObject >> factory: anObject [
	factory := anObject
]

{ #category : #accessing }
SbObject >> ffi [
	^self class ffi
]

{ #category : #accessing }
SbObject >> settings [
	^ settings ifNil: [ settings := SbSettings default ]
]

{ #category : #accessing }
SbObject >> settings: anObject [
	settings := anObject
]
