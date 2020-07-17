Class {
	#name : #SbObject,
	#superclass : #Object,
	#instVars : [
		'client'
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

{ #category : #'instance creation' }
SbObject class >> for: aSbClient [
	^self new client: aSbClient; yourself
]

{ #category : #'class initialization' }
SbObject class >> initialize [
	ffi := nil
]

{ #category : #releasing }
SbObject class >> release [
	<script>
	ffi ifNotNil: [ ffi shutdown ].
	ffi := nil
]

{ #category : #accessing }
SbObject >> client [
	^ client
]

{ #category : #accessing }
SbObject >> client: anObject [
	client := anObject
]

{ #category : #accessing }
SbObject >> factory [
	^ self client factory
]

{ #category : #accessing }
SbObject >> ffi [
	^self class ffi
]

{ #category : #accessing }
SbObject >> settings [
	^ self client settings
]
