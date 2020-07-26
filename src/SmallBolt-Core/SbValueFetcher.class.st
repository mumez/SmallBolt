Class {
	#name : #SbValueFetcher,
	#superclass : #Object,
	#category : #'SmallBolt-Core'
}

{ #category : #private }
SbValueFetcher >> asArraySized: size from: aBoltValue [
	| array |
	array := Array new: size.
	1 to: size do: [ :idx |
		array at: 1 put: (self fetchFrom: (aBoltValue listValueAt: idx - 1))
	].
	^array
]

{ #category : #private }
SbValueFetcher >> asCompositeValueTyped: typeSymbol size: size from: aBoltValue [
	typeSymbol = #BOLT_DICTIONARY ifTrue: [ ^ self asDictionarySized: size from: aBoltValue ].
	typeSymbol = #BOLT_LIST ifTrue: [ ^ self asArraySized: size from: aBoltValue ].
	typeSymbol = #BOLT_STRUCTURE ifTrue: [ ^ self asStructureSized: size from: aBoltValue ]
]

{ #category : #private }
SbValueFetcher >> asDictionarySized: size from: aBoltValue [
	| dict |
	dict := Dictionary new: size.
	0 to: size - 1 do: [ :idx |
		dict at: (self fetchFrom: (aBoltValue dictionaryKeyAt: idx)) put: (self fetchFrom: (aBoltValue dictionaryValueAt: idx))
	].
	^dict
]

{ #category : #private }
SbValueFetcher >> asPrimitiveValueTyped: typeSymbol from: aBoltValue [
	typeSymbol = #BOLT_STRING ifTrue: [ ^ aBoltValue stringValue ].
	typeSymbol = #BOLT_INTEGER ifTrue: [ ^ aBoltValue integerValue ].
	typeSymbol = #BOLT_FLOAT ifTrue: [ ^ aBoltValue floatValue ].
	typeSymbol = #BOLT_BOOLEAN ifTrue: [ ^ aBoltValue booleanValue = 1].
	typeSymbol = #BOLT_BYTES ifTrue: [ ^ aBoltValue bytesValue ].
	typeSymbol = #BOLT_NULL ifTrue: [ ^ nil ].
	^ nil
]

{ #category : #private }
SbValueFetcher >> asStructureSized: size from: aBoltValue [
	| typeCode fields |
	typeCode := aBoltValue structureCodeValue.
	fields := OrderedCollection new: size.
	1 to: size do: [ :idx |
		fields add: (self fetchFrom: (aBoltValue structureFieldValueAt: idx - 1))
	].
	^ SbStructure typeCode: typeCode fields: fields asArray
]

{ #category : #actions }
SbValueFetcher >> fetchFrom: aBoltValue [
	| type typeSymbol size |
	type := aBoltValue type.
	typeSymbol := type typeSymbol.
	type isPrimitive ifTrue: [ 
		^ self asPrimitiveValueTyped: typeSymbol from: aBoltValue
	].
	size := aBoltValue size.
	^ self asCompositeValueTyped: typeSymbol size: size from: aBoltValue
]
