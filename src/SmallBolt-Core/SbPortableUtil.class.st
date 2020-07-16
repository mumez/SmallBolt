Class {
	#name : #SbPortableUtil,
	#superclass : #Object,
	#classVars : [
		'Default',
		'DialectSpecificClass'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #actions }
SbPortableUtil class >> activate [
	"For subclass"
	self dialectSpecificClass: self
]

{ #category : #'instance creation' }
SbPortableUtil class >> default [
	^Default ifNil: [Default := self dialectSpecificClass new]
]

{ #category : #factory }
SbPortableUtil class >> dialectSpecificClass [
	^DialectSpecificClass ifNil: [DialectSpecificClass := self subclasses at: 1]
]

{ #category : #factory }
SbPortableUtil class >> dialectSpecificClass: aClass [
	DialectSpecificClass := aClass
]

{ #category : #'class initialization' }
SbPortableUtil class >> initialize [
	Default := nil.
	DialectSpecificClass := nil
]

{ #category : #actions }
SbPortableUtil >> parseUri: targetUrl [
	^Dictionary new
]
