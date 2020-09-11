Class {
	#name : #SbCypherStatementAppender,
	#superclass : #Object,
	#instVars : [
		'statements'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #actions }
SbCypherStatementAppender >> cypher: cypherString [
	self statements add: cypherString
]

{ #category : #actions }
SbCypherStatementAppender >> cypher: cypherString arguments: arguments [
	self statements add: (cypherString -> arguments) 
]

{ #category : #'initialize-release' }
SbCypherStatementAppender >> initialize [
	statements := OrderedCollection new
]

{ #category : #accessing }
SbCypherStatementAppender >> statements [
	^ statements
]
