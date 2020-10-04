Class {
	#name : #SbBoltType,
	#superclass : #FFIEnumeration,
	#classVars : [
		'BOLT_BOOLEAN',
		'BOLT_BYTES',
		'BOLT_DICTIONARY',
		'BOLT_FLOAT',
		'BOLT_INTEGER',
		'BOLT_LIST',
		'BOLT_NULL',
		'BOLT_STRING',
		'BOLT_STRUCTURE'
	],
	#category : #'SmallBolt-FFI'
}

{ #category : #accessing }
SbBoltType class >> boolean [
	^BOLT_BOOLEAN  
]

{ #category : #accessing }
SbBoltType class >> bytes [
	^BOLT_BYTES
]

{ #category : #accessing }
SbBoltType class >> dictionary [
	^BOLT_DICTIONARY
]

{ #category : #'enum declaration' }
SbBoltType class >> enumDecl [
	^ #(BOLT_NULL 0
	 BOLT_BOOLEAN 1
	 BOLT_INTEGER 2
	 BOLT_FLOAT 3
	 BOLT_STRING 4
	 BOLT_DICTIONARY 5
	 BOLT_LIST 6
	 BOLT_BYTES 7
	 BOLT_STRUCTURE 8)
]

{ #category : #accessing }
SbBoltType class >> float [
	^BOLT_FLOAT
]

{ #category : #accessing }
SbBoltType class >> integer [
	^BOLT_INTEGER
]

{ #category : #accessing }
SbBoltType class >> list [
	^BOLT_LIST
]

{ #category : #accessing }
SbBoltType class >> null [
	^BOLT_NULL 
]

{ #category : #accessing }
SbBoltType class >> string [
	^BOLT_STRING
]

{ #category : #accessing }
SbBoltType class >> structure [
	^BOLT_STRUCTURE
]

{ #category : #testing }
SbBoltType >> isComposite [ 
	^{BOLT_STRUCTURE. BOLT_DICTIONARY. BOLT_LIST}
	 includes: self 
]

{ #category : #testing }
SbBoltType >> isPrimitive [
	^self isComposite not
]

{ #category : #accessing }
SbBoltType >> typeSymbol [
	^self item
]
