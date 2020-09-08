Class {
	#name : #SbPortableUtil,
	#superclass : #Object,
	#classVars : [
		'Default',
		'DialectSpecificClass'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #actions }
SbPortableUtil class >> activate [
	"For subclass"
	self dialectSpecificClass: self
]

{ #category : #'instance creation' }
SbPortableUtil class >> default [
	^Default ifNil: [Default := self dialectSpecificClass new]
]

{ #category : #factory }
SbPortableUtil class >> dialectSpecificClass [
	^DialectSpecificClass ifNil: [DialectSpecificClass := self subclasses at: 1]
]

{ #category : #factory }
SbPortableUtil class >> dialectSpecificClass: aClass [
	DialectSpecificClass := aClass
]

{ #category : #'class initialization' }
SbPortableUtil class >> initialize [
	Default := nil.
	DialectSpecificClass := nil
]

{ #category : #'startup-shutdown' }
SbPortableUtil class >> shutDown: isImageQuitting [
	^self default shutDown: isImageQuitting
]

{ #category : #'startup-shutdown' }
SbPortableUtil class >> startUp: isImageResuming [
	^self default startUp: isImageResuming
]

{ #category : #accessing }
SbPortableUtil >> allSessionManagerInstances [
	| sessionManagerBaseClass |
	sessionManagerBaseClass := Smalltalk at: #SbClientSessionManager ifAbsent: [^self].
	^ sessionManagerBaseClass allSubInstances
]

{ #category : #'initialize-release' }
SbPortableUtil >> initialize [
	super initialize.
	self registerAsStartupAndShutdownHandler: self class
]

{ #category : #actions }
SbPortableUtil >> parseUri: targetUrl [
	^Dictionary new
]

{ #category : #actions }
SbPortableUtil >> parseUriScheme: usiScheme [
	"neo4j
	neo4j+s
	neo4j+ssc
	bolt
	bolt+s
	bolt+ssc
	"
	^ Array with: 'bolt' with: ''
]

{ #category : #'startup-shutdown' }
SbPortableUtil >> registerAsStartupAndShutdownHandler: aClass [
	"override"
]

{ #category : #'startup-shutdown' }
SbPortableUtil >> shutDown: isImageQuitting [
	SbSeaboltFFIFactory release.
	self allSessionManagerInstances do: [ :each |  
		isImageQuitting ifTrue: [ each onImageQuit]
	]
]

{ #category : #'startup-shutdown' }
SbPortableUtil >> startUp: isImageResuming [
	^self allSessionManagerInstances do: [ :each |  
		isImageResuming ifTrue: [ each onImageResume]
	]
]

{ #category : #'startup-shutdown' }
SbPortableUtil >> unregisterAsStartupAndShutdownHandler: aClass [
	"override"
]
