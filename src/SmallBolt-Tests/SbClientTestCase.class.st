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
