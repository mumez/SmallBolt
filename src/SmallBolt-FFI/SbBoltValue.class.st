Class {
	#name : #SbBoltValue,
	#superclass : #SbExternalObject,
	#instVars : [
		'value'
	],
	#category : #'SmallBolt-FFI'
}

{ #category : #'instance creation' }
SbBoltValue class >> create [
	^self ffi createValue
]

{ #category : #'private-printing' }
SbBoltValue >> basicPrintStringOnConnection: aBoltConnection bufferLength: bufferLength [
	| strOut actualLength |
	strOut := self ffi class newStringHolder.
	actualLength := self ffi 
		toString: strOut length: bufferLength onConnection: self.
	actualLength > bufferLength ifTrue: [ 
		^self basicPrintStringOnConnection: aBoltConnection bufferLength: actualLength + 1.
	].
	^strOut value readString
]

{ #category : #accessing }
SbBoltValue >> booleanValue [
	^ self ffi getBooleanOnValue: self
]

{ #category : #accessing }
SbBoltValue >> bytesValue [
	^ self ffi getBytesOnValue: self
]

{ #category : #releasing }
SbBoltValue >> destroy [
	self ffi destroyValue: self
]

{ #category : #accessing }
SbBoltValue >> dictionaryKeyAt: index [
	^ self ffi getDictionaryKeyAt: index onValue: self
]

{ #category : #accessing }
SbBoltValue >> dictionaryStringKeyAt: index [
	^ self ffi getDictionaryStringKeyAt: index onValue: self
]

{ #category : #accessing }
SbBoltValue >> dictionaryValueAt: index [
	^ self ffi getDictionaryValueAt: index onValue: self
]

{ #category : #copying }
SbBoltValue >> duplicate [
	^ self ffi duplicateOnValue: self
]

{ #category : #converting }
SbBoltValue >> fetchValue [
	^ SbValueFetcher new fetchFrom: self	
]

{ #category : #accessing }
SbBoltValue >> floatValue [
	^ self ffi getFloatOnValue: self
]

{ #category : #accessing }
SbBoltValue >> integerValue [
	^ self ffi getIntegerOnValue: self
]

{ #category : #accessing }
SbBoltValue >> listValueAt: index [
	^ self ffi getListOnValue: self
]

{ #category : #printing }
SbBoltValue >> printStringLimitedTo: limit onConnection: aBoltConnection [
	| strOut |
	strOut := self ffi class newStringHolder.
	self toString: strOut length: limit onConnection: self.
	^strOut value readString
]

{ #category : #printing }
SbBoltValue >> printStringOnConnection: aBoltConnection [
	^self basicPrintStringOnConnection: aBoltConnection bufferLength: 2048
]

{ #category : #accessing }
SbBoltValue >> size [
	^ self ffi getSizeOnValue: self
]

{ #category : #accessing }
SbBoltValue >> stringValue [
	^ self ffi getStringOnValue: self
]

{ #category : #accessing }
SbBoltValue >> structureCodeValue [
	^ self ffi getStructureCodeOnValue: self
]

{ #category : #accessing }
SbBoltValue >> structureValue [
	^ self ffi getStructureOnValue: self
]

{ #category : #'private-printing' }
SbBoltValue >> toString: dest length: length onConnection: aSbBoldConnection [
	^ self ffi toString: dest fromValue: self length: length onConnection: aSbBoldConnection
]

{ #category : #accessing }
SbBoltValue >> type [
	^ self ffi getTypeOnValue: self
]

{ #category : #converting }
SbBoltValue >> value [
	^ value ifNil: [ value := self fetchValue ]
]

{ #category : #accessing }
SbBoltValue >> value: anObject [
	value := anObject
]
