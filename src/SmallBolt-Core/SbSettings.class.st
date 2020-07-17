Class {
	#name : #SbSettings,
	#superclass : #Object,
	#instVars : [
		'settingsDict',
		'parsedUriValues'
	],
	#classInstVars : [
		'default'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #accessing }
SbSettings class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #accessing }
SbSettings class >> default: anObject [
	default := anObject
]

{ #category : #'class initialization' }
SbSettings class >> initialize [
	default := nil
]

{ #category : #'accessing - dictionary' }
SbSettings >> at: key [
	^self settingsDict at: key
]

{ #category : #'accessing - dictionary' }
SbSettings >> at: key ifAbsent: aBlock [
	^self settingsDict at: key ifAbsent: aBlock
]

{ #category : #'accessing - dictionary' }
SbSettings >> at: key ifAbsentPut: aBlock [
	^self settingsDict at: key ifAbsentPut: aBlock
]

{ #category : #'accessing - dictionary' }
SbSettings >> at: key put: value [
	^self settingsDict at: key put: value
]

{ #category : #authentication }
SbSettings >> authType [
	^self at: #authType ifAbsentPut: [#basic]
]

{ #category : #authentication }
SbSettings >> authType: aSymbol [
	self at: #authType put: aSymbol
]

{ #category : #defaults }
SbSettings >> defaultRootUri [
	"neo4j
	neo4j+s
	neo4j+ssc
	bolt
	bolt+s
	bolt+ssc"
	"bolt+routing://graph.example.com:7687"
	^'bolt://localhost:7687'
]

{ #category : #accessing }
SbSettings >> host [
	^self parsedUriValues at: #host ifAbsent: [ 'localhost' ]
]

{ #category : #'accessing - dictionary' }
SbSettings >> includesKey: key [
	^self settingsDict includesKey: key
]

{ #category : #aliasing }
SbSettings >> isBasicAuth [
	^ self authType = #basic
]

{ #category : #aliasing }
SbSettings >> isDirectScheme [
	^self parsedUriScheme first = 'bolt'
]

{ #category : #aliasing }
SbSettings >> isEncryptedTransport [
	^self isPlainTextTransport not
]

{ #category : #aliasing }
SbSettings >> isNeo4jScheme [
	^self parsedUriScheme first = 'neo4j'
]

{ #category : #aliasing }
SbSettings >> isNoAuth [
	^ self authType = #none
]

{ #category : #aliasing }
SbSettings >> isPlainTextTransport [
	^self parsedUriScheme last = ''
]

{ #category : #'accessing - dictionary' }
SbSettings >> keys [
	^self settingsDict keys
]

{ #category : #private }
SbSettings >> parseUri: aString [
	self parsedUriValues: (self portableUtil parseUri: aString)
]

{ #category : #private }
SbSettings >> parsedUriScheme [
	^self portableUtil parseUriScheme: self scheme
]

{ #category : #'accessing - private' }
SbSettings >> parsedUriValues [
	^parsedUriValues ifNil: [ parsedUriValues := Dictionary new ]
]

{ #category : #'accessing - private' }
SbSettings >> parsedUriValues: aDictionary [
	parsedUriValues := aDictionary 
]

{ #category : #authentication }
SbSettings >> password [
	^self at: #password ifAbsentPut: ['neo4j']
]

{ #category : #authentication }
SbSettings >> password: aString [
	self at: #password put: aString
]

{ #category : #accessing }
SbSettings >> port [
	^self parsedUriValues at: #port ifAbsent: [ 7867 ]
]

{ #category : #'accessing - private' }
SbSettings >> portableUtil [
	^SbPortableUtil default
]

{ #category : #authentication }
SbSettings >> realm [
	^self at: #realm ifAbsentPut: [nil]
]

{ #category : #authentication }
SbSettings >> realm: aString [
	self at: #realm put: aString
]

{ #category : #accessing }
SbSettings >> scheme [
	^self parsedUriValues at: #scheme ifAbsent: ['bolt']
]

{ #category : #'accessing - private' }
SbSettings >> settingsDict [
	^ settingsDict ifNil: [settingsDict := IdentityDictionary new]
]

{ #category : #'accessing - private' }
SbSettings >> settingsDict: anObject [
	settingsDict := anObject
]

{ #category : #accessing }
SbSettings >> targetUri [
	^ self at: #targetUri ifAbsentPut: [self defaultRootUri]
]

{ #category : #accessing }
SbSettings >> targetUri: aString [
	self parsedUriValues: nil.
	self at: #targetUri put: aString.
	aString ifNotNil: [ self parseUri: aString ].
	^aString
]

{ #category : #accessing }
SbSettings >> userAgent [
	^self parsedUriValues at: #userAgent ifAbsent: [ 'SmallBolt/1' ]
]

{ #category : #authentication }
SbSettings >> username [
	^self at: #username ifAbsentPut: ['neo4j']
]

{ #category : #authentication }
SbSettings >> username: aString [
	self at: #username put: aString
]
