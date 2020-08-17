Class {
	#name : #SbClientSessionManagerTestCase,
	#superclass : #TestCase,
	#category : #'SmallBolt-Tests'
}

{ #category : #factory }
SbClientSessionManagerTestCase >> sessionManagerClass [
	^ SbClientSessionManager
]

{ #category : #private }
SbClientSessionManagerTestCase >> sessionManagerDo: aBlock [
	| sessionManager |
	sessionManager := self sessionManagerClass default.
	[ sessionManager settings: self settings.
	sessionManager standBy: 3.
	aBlock value: sessionManager ]
		ensure: [ sessionManager release ]
]

{ #category : #accessing }
SbClientSessionManagerTestCase >> settings [
	^SbClientTestCase defaultSettings
]

{ #category : #testing }
SbClientSessionManagerTestCase >> testConcurrentSessions [
	| sema procOne procTwo results |
	self sessionManagerDo: [ :sm |

	sema := Semaphore new.
	results := OrderedCollection new.

	procOne := [ | cypher1 result1 |
	cypher1 := 'MATCH p = (n:Movie)<-[r]-(m) RETURN p LIMIT 10'.
	sm clientDo: [ :cli | 
	  result1 := cli runCypher: cypher1.
	  results add: { #ONE. result1 fieldValues}.
	].
	20 atRandom milliSeconds wait.
	sema signal.
	].
	 
	procTwo := [  | cypher2 result2 |
	cypher2 := 'MATCH p = (n)-[r]->(m) RETURN p LIMIT 10'.
	sm clientDo: [ :cli | 
	  result2 := cli runCypher: cypher2.	
	  results add: { #TWO. result2  fieldValues}.
	].
	20 atRandom milliSeconds wait.
	sema signal.
	]. 
	
	100 milliSeconds wait.
	10 timesRepeat: [procOne fork. procTwo fork].
	20 timesRepeat: [sema wait].
	
	self assert: (results size = 20).
	self assert: (((results copyFrom: 1 to: 10) collect: [ :each | each first ]) asSet asSortedCollection asArray) = #(#ONE #TWO).

	].
]
