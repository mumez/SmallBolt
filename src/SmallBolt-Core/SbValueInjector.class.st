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
]
