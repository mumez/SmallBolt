Class {
	#name : #SbBoltRequest,
	#superclass : #SbExternalObject,
	#category : #'SmallBolt-FFI'
}

{ #category : #actions }
SbBoltRequest >> fetchOn: aSbBoltConnection [
	^self ffi fetchOnConnection: aSbBoltConnection request: self
]

{ #category : #actions }
SbBoltRequest >> recordsOn: aSbBoltConnection [
	| values |
	values := OrderedCollection new.
	[(self fetchOn: aSbBoltConnection) > 0] whileTrue: [ 
		values add: (aSbBoltConnection fieldValues value)
	].
	^ values
]

{ #category : #actions }
SbBoltRequest >> summaryOn: aSbBoltConnection [
	^self ffi fetchSummaryOnConnection: aSbBoltConnection request: self
]
