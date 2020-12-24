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

{ #category : #accessing }
SbSettings >> accessMode [
	^ self at: #accessMode ifAbsentPut: [#write]
]

{ #category : #accessing }
SbSettings >> accessMode: aSymbol [
	^ self at: #accessMode put: aSymbol
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

{ #category : #'accessing - session' }
SbSettings >> clientKindKey [
	^ self at: #clientKindKey ifAbsentPut: [#default]
]

{ #category : #'accessing - session' }
SbSettings >> clientKindKey: aSymbol [
	aSymbol ifNil: [
		^ self removeKey: #clientKindKey
	].
	self at: #clientKindKey put: aSymbol asSymbol
]

{ #category : #defaults }
SbSettings >> defaultTargerUri [
	"neo4j
	neo4j+s
	neo4j+ssc
	bolt
	bolt+s
	bolt+ssc"
	"bolt+routing://graph.example.com:7687"
	^'bolt://127.0.0.1:7687'
]

{ #category : #extracting }
SbSettings >> extractFrom: otherSettings [
	otherSettings keysAndValuesDo: [ :k :v |
		self at: k put: v	
	].
	self refreshParsedUriValues
]

{ #category : #accessing }
SbSettings >> host [
	^self parsedUriValues at: #host ifAbsent: [ '127.0.0.1' ]
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

{ #category : #'accessing - dictionary' }
SbSettings >> keysAndValuesDo: block [
	^self settingsDict keysAndValuesDo: block
]

{ #category : #'accessing - session' }
SbSettings >> maxClientsPerKey [
	^ self at: #maxClientsPerKey ifAbsentPut: [10]
]

{ #category : #'accessing - session' }
SbSettings >> maxClientsPerKey: anInteger [
	self at: #maxClientsPerKey put: anInteger
]

{ #category : #accessing }
SbSettings >> maxConnectionAcquisitionTime [
	^ self at: #maxConnectionAcquisitionTime ifAbsentPut: [0]
]

{ #category : #accessing }
SbSettings >> maxConnectionAcquisitionTime: anInteger [
	^ self at: #maxConnectionAcquisitionTime put: anInteger
]

{ #category : #accessing }
SbSettings >> maxConnectionLifeTime [
	^ self at: #maxConnectionLifeTime ifAbsentPut: [0]
]

{ #category : #accessing }
SbSettings >> maxConnectionLifeTime: anInteger [
	^ self at: #maxConnectionLifeTime put: anInteger
]

{ #category : #accessing }
SbSettings >> maxPoolSize [
	^ self at: #maxPoolSize ifAbsentPut: [100]
]

{ #category : #accessing }
SbSettings >> maxPoolSize: anInteger [
	^ self at: #maxPoolSize put: anInteger
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
	^self parsedUriValues at: #port ifAbsent: [ 7687 ]
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

{ #category : #private }
SbSettings >> refreshParsedUriValues [
	self parseUri: self targetUri
]

{ #category : #'accessing - dictionary' }
SbSettings >> removeKey: key [
	^self settingsDict removeKey: key ifAbsent:[]
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
SbSettings >> shouldRaiseErrorOnConnectionFailed [
	^ self at: #shouldRaiseErrorOnConnectionFailed ifAbsentPut: [true]
]

{ #category : #accessing }
SbSettings >> shouldRaiseErrorOnConnectionFailed: aBoolean [
	^ self at: #shouldRaiseErrorOnConnectionFailed: put: aBoolean
]

{ #category : #accessing }
SbSettings >> shouldRaiseErrorOnTransactionFailed [
	^ self at: #shouldRaiseErrorOnTransactionFailed ifAbsentPut: [false]
]

{ #category : #accessing }
SbSettings >> shouldRaiseErrorOnTransactionFailed: aBoolean [
	^ self at: #shouldRaiseErrorOnTransactionFailed put: aBoolean
]

{ #category : #accessing }
SbSettings >> targetUri [
	^ self at: #targetUri ifAbsentPut: [self defaultTargerUri]
]

{ #category : #accessing }
SbSettings >> targetUri: aString [
	| urlString |
	urlString := aString ifNil: [ self defaultTargerUri ].
	self parsedUriValues: nil.
	self at: #targetUri put: urlString.
	self refreshParsedUriValues.
]

{ #category : #accessing }
SbSettings >> traceLibraryLogOnTranscript [
	^ self at: #traceLibraryLogOnTranscript ifAbsentPut: [false]
]

{ #category : #accessing }
SbSettings >> traceLibraryLogOnTranscript: aBoolean [
	^ self at: #traceLibraryLogOnTranscript put: aBoolean
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
