Class {
	#name : #SbClientTestCase,
	#superclass : #TestCase,
	#classInstVars : [
		'defaultSettings'
	],
	#category : #'SmallBolt-Tests'
}

{ #category : #accessing }
SbClientTestCase class >> defaultSettings [
	^defaultSettings ifNil: [ defaultSettings := SbSettings new]
]

{ #category : #'class initialization' }
SbClientTestCase class >> initSettingsExample [
	<script>
	self defaultSettings password: 'neoneo'
]

{ #category : #'class initialization' }
SbClientTestCase class >> initialize [
	defaultSettings := nil
]

{ #category : #private }
SbClientTestCase >> clientDo: aBlock [
	| client |
	client := SbClient new.
	[ client settings: self settings.
	client connect.
	aBlock value: client ]
		ensure: [ client release ]
]

{ #category : #accessing }
SbClientTestCase >> settings [
	^self class defaultSettings
]

{ #category : #testing }
SbClientTestCase >> testRunBasicCypher [
	| cypher result |
	cypher := 'UNWIND range(1, 10) AS n RETURN n'.
	self clientDo: [ :cli |
		result := cli runCypher: cypher.
	].
	self assert: (result fieldNames = (Array with: 'n')).
	self assert: (result records size = 10).
	self assert: ((result records collect: #first) asArray = #(1 2 3 4 5 6 7 8 9 10)).
	 
	
]

{ #category : #testing }
SbClientTestCase >> testRunBasicCyphers [
	| cypher1 cypher2 results result1 result2 |
	cypher1 := 'UNWIND range(1, 10) AS n RETURN n'.
	cypher2 := 'UNWIND range(11, 22) AS x RETURN x'.
	self clientDo: [ :cli |
		results := cli runCyphers: {cypher1. cypher2}.
	].
	result1 := results first.
	result2 := results second.
	self assert: (result1 fieldNames = (Array with: 'n')).
	self assert: (result1 records size = 10).
	self assert: ((result1 records collect: #first) asArray = #(1 2 3 4 5 6 7 8 9 10)).
	self assert: (result2 fieldNames = (Array with: 'x')).
	self assert: (result2 records size = 12).
	self assert: ((result2 records collect: #first) asArray = #(11 12 13 14 15 16 17 18 19 20 21 22)).
	 
	
]
