Class {
	#name : #SbValueInjector,
	#superclass : #Object,
	#category : #'SmallBolt-Core'
}

{ #category : #actions }
SbValueInjector >> inject: anObject into: aSbValue [

	"Currently only supports primitive types"
	anObject isInteger ifTrue: [ ^ aSbValue integerValue: anObject].
	anObject isFloat ifTrue: [ ^ aSbValue floatValue: anObject].
	anObject isString ifTrue: [ ^ aSbValue stringValue: anObject].
	
	(anObject == true or: [ anObject == false ]) ifTrue: [ ^ aSbValue booleanValue: anObject]. 
	(anObject isKindOf: ByteArray) ifTrue: [ ^ aSbValue bytesValue: anObject].
	
	anObject isCollection ifTrue: [ ^ self setCollectionValues: anObject to: aSbValue ]
	
]

{ #category : #private }
SbValueInjector >> setCollectionValues: anObject to: aSbValue [
	(anObject isKindOf: SequenceableCollection)
		ifTrue: [ ^ self setListValues: anObject to: aSbValue ].
		
	(anObject isDictionary)
		ifTrue: [ ^ self setDictionaryValues: anObject to: aSbValue ].
]

{ #category : #private }
SbValueInjector >> setDictionaryValues: anObject to: aSbValue [
	| size index |
	size := anObject size.
	aSbValue dictionarySize: size.
	index := 0.
	anObject keysAndValuesDo: [ :key :stValue | | sbValue |
		aSbValue dictionaryStringKeyAt: index put: key.
		sbValue := aSbValue dictionaryValueAt: index.
		self inject: stValue into: sbValue.
		index := index + 1.
	].
]

{ #category : #private }
SbValueInjector >> setListValues: anObject to: aSbValue [
	| size |
	size := anObject size.
	aSbValue listSize: size.
	0 to: size - 1 do: [ :idx | | sbValue stValue |
		sbValue := aSbValue listValueAt: idx.
		stValue := anObject at: idx + 1.
		self inject: stValue into: sbValue
	]
]
