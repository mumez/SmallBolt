Class {
	#name : #SbClient,
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
SbClient class >> createFfi [
	^SbSeaboltFFIFactory create
]

{ #category : #accessing }
SbClient class >> ffi [
	^ ffi ifNil: [ ffi := self createFfi]
]

{ #category : #accessing }
SbClient class >> ffi: anObject [
	ffi := anObject
]

{ #category : #'class initialization' }
SbClient class >> initialize [
	ffi := nil
]

{ #category : #releasing }
SbClient class >> release [
	<script>
	ffi ifNotNil: [ ffi shutdown ].
	ffi := nil
]

{ #category : #accessing }
SbClient >> factory [
	^ factory ifNil: [ factory := SbExternalObjectFactory on: self settings ]
]

{ #category : #accessing }
SbClient >> factory: anObject [
	factory := anObject
]

{ #category : #accessing }
SbClient >> settings [
	^ settings ifNil: [ settings := SbSettings default ]
]

{ #category : #accessing }
SbClient >> settings: anObject [
	settings := anObject
]
