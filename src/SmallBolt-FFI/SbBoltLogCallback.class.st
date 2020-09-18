Class {
	#name : #SbBoltLogCallback,
	#superclass : #FFICallback,
	#category : #'SmallBolt-FFI'
}

{ #category : #'callback spec' }
SbBoltLogCallback class >> fnSpec [

	^'void ( void* state, String message )'
]

{ #category : #'instance creation' }
SbBoltLogCallback class >> on: aBlock [
	^ self 
		signature: self fnSpec
		block: aBlock
]

{ #category : #utilities }
SbBoltLogCallback class >> toTranscript [
	^ self on: [ :state :message | Transcript cr; show: 'SB:', message ]
]
