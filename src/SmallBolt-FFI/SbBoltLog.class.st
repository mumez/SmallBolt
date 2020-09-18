Class {
	#name : #SbBoltLog,
	#superclass : #SbExternalObject,
	#instVars : [
		'warningCallback',
		'infoCallback',
		'errorCallback',
		'debugCallback'
	],
	#category : #'SmallBolt-FFI'
}

{ #category : #'instance creation' }
SbBoltLog class >> create [
	^self createWith: ''
]

{ #category : #'instance creation' }
SbBoltLog class >> createWith: aState [
	^self ffi createLog: aState
]

{ #category : #convenience }
SbBoltLog >> allToTranscript [
	| cb |
	cb := self createTranscriptLogCallback.
	self infoCallback: cb.
	self debugCallback: cb.
	self warningCallback: cb.
	self errorCallback: cb.
]

{ #category : #factory }
SbBoltLog >> createLogCallbackUsing: aBlock [
	^ SbBoltLogCallback on: aBlock 
]

{ #category : #factory }
SbBoltLog >> createTranscriptLogCallback [
	^ SbBoltLogCallback toTranscript
]

{ #category : #actions }
SbBoltLog >> debugBy: aBlock [
	self debugCallback: (self createLogCallbackUsing: aBlock)
]

{ #category : #accessing }
SbBoltLog >> debugCallback [
	^ debugCallback
]

{ #category : #accessing }
SbBoltLog >> debugCallback: aSbBoltLogCallback [
	self ffi	setDebugCallback: aSbBoltLogCallback onLog: self.
	debugCallback := aSbBoltLogCallback
]

{ #category : #convenience }
SbBoltLog >> debugToTranscript [
	^ self debugCallback: self createTranscriptLogCallback
]

{ #category : #releasing }
SbBoltLog >> destroy [
	self ffi destroyLog: self
]

{ #category : #actions }
SbBoltLog >> errorBy: aBlock [
	self errorCallback: (self createLogCallbackUsing: aBlock)
]

{ #category : #accessing }
SbBoltLog >> errorCallback [
	^ errorCallback
]

{ #category : #accessing }
SbBoltLog >> errorCallback: aSbBoltLogCallback [
	self ffi	setErrorCallback: aSbBoltLogCallback onLog: self.
	errorCallback := aSbBoltLogCallback
]

{ #category : #convenience }
SbBoltLog >> errorToTranscript [
	^ self errorCallback: self createTranscriptLogCallback
]

{ #category : #actions }
SbBoltLog >> infoBy: aBlock [
	self infoCallback: (self createLogCallbackUsing: aBlock)
]

{ #category : #accessing }
SbBoltLog >> infoCallback [
	^ infoCallback
]

{ #category : #accessing }
SbBoltLog >> infoCallback: aSbBoltLogCallback [
	self ffi	setInfoCallback: aSbBoltLogCallback onLog: self.
	infoCallback := aSbBoltLogCallback
]

{ #category : #convenience }
SbBoltLog >> infoToTranscript [
	^ self infoCallback: self createTranscriptLogCallback
]

{ #category : #actions }
SbBoltLog >> warnBy: aBlock [
	self warningCallback: (self createLogCallbackUsing: aBlock)
]

{ #category : #convenience }
SbBoltLog >> warnToTranscript [
	^ self warningCallback: self createTranscriptLogCallback
]

{ #category : #accessing }
SbBoltLog >> warningCallback [
	^ warningCallback
]

{ #category : #accessing }
SbBoltLog >> warningCallback: aSbBoltLogCallback [
	self ffi	setWarningCallback: aSbBoltLogCallback onLog: self.
	warningCallback := aSbBoltLogCallback
]
