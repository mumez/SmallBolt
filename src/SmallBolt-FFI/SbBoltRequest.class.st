Class {
	#name : #SbBoltRequest,
	#superclass : #SbExternalObject,
	#category : #'SmallBolt-FFI'
}

{ #category : #actions }
SbBoltRequest >> detailsOn: aSbBoltConnection [
	^self ffi fetchOnConnection: aSbBoltConnection request: self
]

{ #category : #actions }
SbBoltRequest >> summaryOn: aSbBoltConnection [
	^self ffi fetchSummaryOnConnection: aSbBoltConnection request: self
]
