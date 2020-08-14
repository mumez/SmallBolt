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
SbClientTestCase >> testCypherGetNode [
	| cypher result node props |
	"Assuming Neo4j Movie sample schema"
	cypher := 'MATCH (n:Movie{title:"The Matrix"})<--(m) RETURN n LIMIT 1'.
	self clientDo: [ :cli |
		result := cli runCypher: cypher.
	].
	self assert: (result fieldNames = (Array with: 'n')).
	self assert: (result fieldValues size = 1).
	node := result fieldValues first first.
	
	self assert: (node isKindOf: SbNode).
	self assert: (node labels = #('Movie')).
	props := node properties.
	self assert: ((props at: 'title') = 'The Matrix').
	self assert: ((props at: 'tagline') = 'Welcome to the Real World').
	self assert: ((props at: 'released') = 1999).
	
]

{ #category : #testing }
SbClientTestCase >> testCypherGetPath [
	| cypher result path relationship startNode endNode |
	"Assuming Neo4j Movie sample schema"
	cypher := 'MATCH p = (n:Movie{title:"The Matrix"})<-[r]-(m) RETURN p ORDER BY m.name LIMIT 2'.
	self clientDo: [ :cli |
		result := cli runCypher: cypher.
	].
	self assert: (result fieldNames = #('p')).
	self assert: (result fieldValues size = 2).
	path := result fieldValues first first.
	
	self assert: (path isKindOf: SbPath).
	self assert: (path nodes size = 2).
	self assert: (path relationships size = 1).
	relationship := path relationships first.
	self assert: (relationship type = 'ACTED_IN').
	self assert: (relationship direction = #in).
	self assert: ((relationship propertyAt: 'roles') = #('Trinity')).
	startNode := path nodeAtId: relationship startNodeId.
	endNode := path nodeAtId: relationship endNodeId.
	self assert: (startNode label = 'Movie').
	self assert: (endNode label = 'Person').
	self assert: ((startNode propertyAt: 'title') = 'The Matrix').
	self assert: ((endNode propertyAt: 'name') = 'Carrie-Anne Moss').
	
]

{ #category : #testing }
SbClientTestCase >> testCypherGetRelationship [
	| cypher result relationship props |
	"Assuming Neo4j Movie sample schema"
	cypher := 'MATCH (m:Movie{title:"The Matrix"})<-[r:ACTED_IN]-(n) RETURN m,r,n ORDER BY r.roles ASC LIMIT 1'.
	self clientDo: [ :cli |
		result := cli runCypher: cypher.
	].
	self assert: (result fieldNames = #('m' 'r' 'n')).
	self assert: (result fieldValues size = 1).
	relationship := result fieldValues first second.
	
	self assert: (relationship isKindOf: SbRelationship).
	self assert: (relationship type = 'ACTED_IN').
	props := relationship properties.
	self assert: ((props at: 'roles') = #('Agent Smith')).
	
]

{ #category : #testing }
SbClientTestCase >> testRunBasicCypher [
	| cypher result |
	cypher := 'UNWIND range(1, 10) AS n RETURN n'.
	self clientDo: [ :cli |
		result := cli runCypher: cypher.
	].
	self assert: (result fieldNames = (Array with: 'n')).
	self assert: (result fieldValues size = 10).
	self assert: ((result fieldValues collect: #first) asArray = #(1 2 3 4 5 6 7 8 9 10)).
	 
	
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
	self assert: (result1 fieldValues size = 10).
	self assert: ((result1 fieldValues collect: #first) asArray = #(1 2 3 4 5 6 7 8 9 10)).
	self assert: (result2 fieldNames = (Array with: 'x')).
	self assert: (result2 fieldValues size = 12).
	self assert: ((result2 fieldValues collect: #first) asArray = #(11 12 13 14 15 16 17 18 19 20 21 22)).
	 
	
]

{ #category : #testing }
SbClientTestCase >> testWrongCypherResetRetry [
	| wrongCypher cypher result path relationship startNode endNode |
	"Assuming Neo4j Movie sample schema"
	wrongCypher := 'MATCH p = (n:Movie{title:"The Matrix"})<-[r-(m) RETURN p LIMIT 2'.
	cypher := 'MATCH p = (m)-[r:PRODUCED]->(n:Movie{title:"The Matrix"}) RETURN p ORDER BY m.name LIMIT 1'.
	
	self clientDo: [ :cli |
		self should: [cli runCypher: wrongCypher] raise: SbBoltError.
		result := cli runCypher: cypher.
	].
	self assert: (result fieldNames = #('p')).
	self assert: (result fieldValues size = 1).
	path := result fieldValues first first.
	
	self assert: (path isKindOf: SbPath).
	self assert: (path nodes size = 2).
	self assert: (path relationships size = 1).
	relationship := path relationships first.
	self assert: (relationship type = 'PRODUCED').
	self assert: (relationship direction = #out).
	startNode := path nodeAtId: relationship startNodeId.
	endNode := path nodeAtId: relationship endNodeId.
	self assert: (startNode label = 'Person').
	self assert: (endNode label = 'Movie').
	self assert: ((startNode propertyAt: 'name') = 'Joel Silver').
	self assert: ((endNode propertyAt: 'title') = 'The Matrix').
]
