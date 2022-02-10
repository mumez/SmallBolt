Class {
	#name : #SbFfiTestCase,
	#superclass : #TestCase,
	#category : #'SmallBolt-Tests'
}

{ #category : #testing }
SbFfiTestCase >> testCreateBasicAuth [
	| authInfo authDict |
	authInfo := SbSeaboltFFI new authBasic: 'neo4j' password: '?????'.
	authDict := authInfo value.
	self assert: ((authDict at: 'scheme')  = 'basic').
	self assert: ((authDict at: 'principal')  = 'neo4j').
	self assert: ((authDict at: 'credentials')  = '?????').
	authInfo destroy.
]

{ #category : #testing }
SbFfiTestCase >> testCreateConfig [
	| config |
	config := SbBoltConfig create.
	config maxPoolSize: 10.
	config userAgent: 'pharo'.
	config useDirectScheme.
	self assert: (config maxPoolSize  = 10).
	self assert: (config userAgent = 'pharo').
	self assert: (config scheme = #direct).
	config destroy.
]

{ #category : #testing }
SbFfiTestCase >> testCreateLog [
	| log cb |
	log := SbBoltLog create.
	cb := log createTranscriptLogCallback.
	log infoCallback: cb.
	log debugCallback: cb.
	log warningCallback: cb.
	log errorCallback: cb.
	self assert: (log infoCallback = cb).
	self assert: (log debugCallback = cb).
	self assert: (log warningCallback = cb).
	self assert: (log errorCallback = cb).
	log destroy.
]

{ #category : #testing }
SbFfiTestCase >> testSetGetByteArray [
	| boltValue |
	[ boltValue := SbBoltValue create.
	boltValue value: #[1 2 3 4 5 6 7 8 9].
	self assert: boltValue value = #[1 2 3 4 5 6 7 8 9].
	] ensure: [ boltValue ifNotNil: [ boltValue destroy ] ].

	[ boltValue := SbBoltValue create.
	boltValue value: 'abcdefghijklmn' asByteArray.
	self assert: boltValue value = 'abcdefghijklmn' asByteArray.
	] ensure: [ boltValue ifNotNil: [ boltValue destroy ] ].
]

{ #category : #testing }
SbFfiTestCase >> testSetGetDictionaryBoltValue [
	| boltValue dict |
	[ boltValue := SbBoltValue create.
	dict := Dictionary new.
	dict at: 'a' put: 1.
	dict at: 'b' put: 2.
	dict at: 'c' put: 3.
	boltValue value: dict.
	self assert: (boltValue value keys asSortedCollection asArray = #('a' 'b' 'c')).
	boltValue value keysAndValuesDo: [ :k :v |
		self assert: (v = (dict at: k))
	]
	] ensure: [ boltValue ifNotNil: [ boltValue destroy ] ]
]

{ #category : #testing }
SbFfiTestCase >> testSetGetListBoltValue [
	| boltValue |
	[ boltValue := SbBoltValue create.
	boltValue value: #(4 5 6).
	self assert: boltValue value = #(4 5 6).
	boltValue value: #('Smalltalk' 'Pharo' 'Squeak' 'Cuis' 'VW').
	self assert: boltValue value = #('Smalltalk' 'Pharo' 'Squeak' 'Cuis' 'VW').
	] ensure: [ boltValue ifNotNil: [ boltValue destroy ] ]
]

{ #category : #testing }
SbFfiTestCase >> testSetGetPrimitiveBoltValue [
	| boltValue |
	[ boltValue := SbBoltValue create.
	boltValue value: 1.
	self assert: boltValue value = 1.
	boltValue value: 0.1.
	self assert: boltValue value = 0.1.
	boltValue value: 'abc'.
	self assert: boltValue value = 'abc'. 
	boltValue value: true.
	self assert: boltValue value = true. 
	boltValue value: false.
	self assert: boltValue value = false. 
	boltValue value: #[1 2 3].
	self assert: boltValue value = #[1 2 3]. 
	] ensure: [ boltValue ifNotNil: [ boltValue destroy ] ]
]

{ #category : #testing }
SbFfiTestCase >> testSetGetString [
	| boltValue nbsp |
	[ boltValue := SbBoltValue create.
	boltValue value: 'あいうええおあお、かきくけけこかこ。'.
	self assert: boltValue value = 'あいうええおあお、かきくけけこかこ。'.
	] ensure: [ boltValue ifNotNil: [ boltValue destroy ] ].

	[ boltValue := SbBoltValue create.
	boltValue value: 'abcdefghijklmn'.
	self assert: boltValue value = 'abcdefghijklmn'.
	] ensure: [ boltValue ifNotNil: [ boltValue destroy ] ].

	nbsp := (Character value: 160) asString.
	[ boltValue := SbBoltValue create.
	boltValue value: 'abcdefghijklmn', nbsp.
	self assert: boltValue value = ('abcdefghijklmn', nbsp).
	] ensure: [ boltValue ifNotNil: [ boltValue destroy ] ].
]
