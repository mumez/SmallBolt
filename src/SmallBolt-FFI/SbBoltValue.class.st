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
	| strAddress actualLength |
	strAddress := self ffi class newAutoReleasePointer: bufferLength.
	actualLength := self  
		toString: strAddress length: bufferLength onConnection: aBoltConnection.
	actualLength > bufferLength ifTrue: [ 
		^self basicPrintStringOnConnection: aBoltConnection bufferLength: actualLength + 1.
	].
	^strAddress readString
]

{ #category : #accessing }
SbBoltValue >> booleanValue [
	^ self ffi getBooleanOnValue: self
]

{ #category : #accessing }
SbBoltValue >> booleanValue: aBoolean [
	| booleanNumber |
	booleanNumber := aBoolean == true ifTrue: [ 1 ] ifFalse: [ 0 ].
	^ self ffi setBoolean: booleanNumber onValue: self
]

{ #category : #accessing }
SbBoltValue >> bytesValue [
	| sz rawBytes strm bytes |
	sz := self ffi getSizeOnValue: self.
	rawBytes := self ffi getBytesOnValue: self.
	strm := rawBytes fromCString asByteArray readStream.
	bytes := ByteArray new: sz.
	strm readInto: bytes startingAt: 1 count: sz.
	^ bytes 
]

{ #category : #accessing }
SbBoltValue >> bytesValue: aByteArray [
	^ self ffi setBytes: aByteArray onValue: self
]

{ #category : #printing }
SbBoltValue >> debugShortString [
	| strAddress size |
	strAddress := self ffi class newAutoReleasePointer: 1024.
	size := self ffi toString: strAddress fromValue: self length: 1024.
	^strAddress readString
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
SbBoltValue >> dictionarySize: size [
	^ self ffi setDictionarySize: size onValue: self
]

{ #category : #accessing }
SbBoltValue >> dictionaryStringKeyAt: index [
	^ self ffi getDictionaryStringKeyAt: index onValue: self
]

{ #category : #accessing }
SbBoltValue >> dictionaryStringKeyAt: index put: keyString [
	^ self ffi setDictionaryKey: keyString at: index onValue: self
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
SbBoltValue >> floatValue: aFloat [
	^ self ffi setFloat: aFloat onValue: self
]

{ #category : #accessing }
SbBoltValue >> integerValue [
	^ self ffi getIntegerOnValue: self
]

{ #category : #accessing }
SbBoltValue >> integerValue: anInteger [
	^ self ffi setInteger: anInteger onValue: self
]

{ #category : #accessing }
SbBoltValue >> listSize: size [
	^ self ffi setListSize: size onValue: self
]

{ #category : #accessing }
SbBoltValue >> listValueAt: index [
	^ self ffi getListValueAt: index onValue: self
]

{ #category : #printing }
SbBoltValue >> printStringOnConnection: aBoltConnection [
	^self basicPrintStringOnConnection: aBoltConnection bufferLength: 2048
]

{ #category : #'setting value' }
SbBoltValue >> setValue: anObject [
	value := nil.
	^ SbValueInjector new inject: anObject into: self
]

{ #category : #accessing }
SbBoltValue >> size [
	^ self ffi getSizeOnValue: self
]

{ #category : #accessing }
SbBoltValue >> stringValue [
	| sz rawString strm str |
	sz := self ffi getSizeOnValue: self.
	rawString := self ffi getStringOnValue: self.
	strm := rawString readStream.
	str := String new: sz.
	strm readInto: str startingAt: 1 count: sz.
	^ str 
]

{ #category : #accessing }
SbBoltValue >> stringValue: aString [
	^ self ffi setString: aString onValue: self
]

{ #category : #accessing }
SbBoltValue >> structureCodeValue [
	^ self ffi getStructureCodeOnValue: self
]

{ #category : #accessing }
SbBoltValue >> structureFieldValueAt: index [
	^ self ffi getStructureFieldValueAt: index onValue: self
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

{ #category : #'setting value' }
SbBoltValue >> value: anObject [
	^self setValue: anObject 
]

{ #category : #converting }
SbBoltValue >> valueBy: aValueFetcher [
	^ aValueFetcher fetchFrom: self	
]
