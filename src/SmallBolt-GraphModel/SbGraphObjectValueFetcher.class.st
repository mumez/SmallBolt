Class {
	#name : #SbGraphObjectValueFetcher,
	#superclass : #SbValueFetcher,
	#category : #'SmallBolt-GraphModel'
}

{ #category : #converting }
SbGraphObjectValueFetcher >> asStructureSized: size from: aBoltValue [
	| structure typeCode |
	structure := super asStructureSized: size from: aBoltValue.
	typeCode := structure typeCode.
	typeCode = 78 "$N" ifTrue: [ ^SbNode from: structure ].
	typeCode = 82 "$R" ifTrue: [ ^SbRelationship from: structure ].
	typeCode = 80 "$P" ifTrue: [ ^SbPath from: structure ].
	typeCode = 114 "$r" ifTrue: [ ^SbUnboundRelationship from: structure ].
	^ structure
]
