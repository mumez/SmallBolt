Class {
	#name : #SbBoltRequest,
	#superclass : #SbExternalObject,
	#category : #'SmallBolt-FFI'
}

{ #category : #actions }
SbBoltRequest >> summaryOn: aSbBoltConnection [
	^self ffi fetchSummaryOnConnection: aSbBoltConnection request: self
]
