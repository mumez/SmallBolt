Class {
	#name : #SbPortabilityTestCase,
	#superclass : #TestCase,
	#category : #'SmallBolt-Tests'
}

{ #category : #testing }
SbPortabilityTestCase >> testParseUrl [
	| settings |
	settings := SbSettings new.
	settings targetUri: 'bolt://graph.example.com:7687'.
	self assert: (settings scheme = 'bolt').
	self assert: (settings isDirectScheme).
	settings targetUri: 'neo4j+ssc://graph.example.com:7687'.
	self assert: (settings scheme = 'neo4j+ssc').
	self assert: (settings isNeo4jScheme).
]
