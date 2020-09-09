Class {
	#name : #SbSeaboltFFIFactory,
	#superclass : #Object,
	#classInstVars : [
		'defaultFfiClass',
		'ffi',
		'isStartupCompleted'
	],
	#category : #'SmallBolt-FFI'
}

{ #category : #actions }
SbSeaboltFFIFactory class >> create [
	| inst |
	inst := self defaultFfiClass new.
	self isStartupCompleted
		ifFalse: [ inst startup.
			self isStartupCompleted: true ].
	^ inst
]

{ #category : #defaults }
SbSeaboltFFIFactory class >> defaultFfiClass [
	^ defaultFfiClass ifNil: [defaultFfiClass := SbSeaboltFFI] 
]

{ #category : #defaults }
SbSeaboltFFIFactory class >> defaultFfiClass: anObject [
	defaultFfiClass := anObject
]

{ #category : #'class initialization' }
SbSeaboltFFIFactory class >> initialize [
	defaultFfiClass := nil.
	isStartupCompleted := nil
]

{ #category : #accessing }
SbSeaboltFFIFactory class >> isStartupCompleted [
	^ isStartupCompleted ifNil: [ isStartupCompleted := false ]
]

{ #category : #accessing }
SbSeaboltFFIFactory class >> isStartupCompleted: aBoolean [
	isStartupCompleted := aBoolean 
]

{ #category : #releasing }
SbSeaboltFFIFactory class >> release [
	<script>
	self isStartupCompleted ifFalse: [ ^ self ].
	SbSeaboltFFI shutdown.
	self isStartupCompleted: false
]
