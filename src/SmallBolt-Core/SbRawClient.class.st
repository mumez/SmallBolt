Class {
	#name : #SbRawClient,
	#superclass : #SbObject,
	#instVars : [
		'settings',
		'factory',
		'configBuilder',
		'connector',
		'connection'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #authentication }
SbRawClient >> authenticate [
	^(SbAuthenticator for: self) authenticate
]

{ #category : #releasing }
SbRawClient >> autoReleaseDo: aBlock [
	^ [ aBlock cull: self factory ]
		ensure: [ self releaseFactory ]
]

{ #category : #accessing }
SbRawClient >> client [
	^ self
]

{ #category : #accessing }
SbRawClient >> configBuilder [
	^configBuilder ifNil: [ configBuilder := self defaultConfigBuilder ]
]

{ #category : #accessing }
SbRawClient >> configBuilder: aBlock [
	configBuilder := aBlock
]

{ #category : #connecting }
SbRawClient >> connect [
	connection ifNil: [ connection := self tryConnect ].
	^connection
]

{ #category : #accessing }
SbRawClient >> connection [
	^connection 
]

{ #category : #accessing }
SbRawClient >> connector [
	^ connector
]

{ #category : #factory }
SbRawClient >> createAddress [
	^ self factory create: SbBoltAddress
	
]

{ #category : #factory }
SbRawClient >> createConfig [
	^ self factory createConfigBySetting: self configBuilder
	
]

{ #category : #factory }
SbRawClient >> createConnector [
	^ self factory createRetainConnector: self createAddress token: self authenticate config: self createConfig
]

{ #category : #factory }
SbRawClient >> createRequester [
	^ (self requesterClass on: self connection)
		valueFetcher: self valueFetcher;
		yourself
]

{ #category : #factory }
SbRawClient >> createValueFetcher [
	^SbValueFetcher new
]

{ #category : #defaults }
SbRawClient >> defaultConfigBuilder [
	^ [ :config :clientSettings| 
		config maxPoolSize: clientSettings maxPoolSize.
	]
]

{ #category : #resetting }
SbRawClient >> discardRequests [
	^self requester discard
]

{ #category : #private }
SbRawClient >> ensureConnector [
	connector
		ifNil: [ connector := self autoReleaseDo: [ self createConnector ] ].
	^ connector
]

{ #category : #accessing }
SbRawClient >> factory [
	^factory ifNil: [ factory := SbExternalObjectFactory on: self settings ]
]

{ #category : #accessing }
SbRawClient >> factory: anObject [
	factory := anObject
]

{ #category : #testing }
SbRawClient >> isConnected [
	self connection ifNil: [ ^false ].
	^self connection isReady
]

{ #category : #printing }
SbRawClient >> printOn: aStream [
	aStream nextPutAll: self className.
	aStream nextPutAll: ' ('.
	self connection printOn: aStream.
	aStream nextPutAll: ')'.
	
]

{ #category : #'initialization-release' }
SbRawClient >> release [
	self releaseFactory.
	self releaseConnector.
	configBuilder := connection :=  nil.
]

{ #category : #releasing }
SbRawClient >> releaseConnector [
	connector ifNotNil: [ connector destroy ].
	connector := nil
]

{ #category : #releasing }
SbRawClient >> releaseFactory [
	factory ifNotNil: [ factory autoRelease ].
	factory := nil
]

{ #category : #accessing }
SbRawClient >> requester [
	^ self createRequester
]

{ #category : #factory }
SbRawClient >> requesterClass [
	^ SbBasicRequester
]

{ #category : #resetting }
SbRawClient >> resetRequests [
	^self requester reset
]

{ #category : #'running cypher' }
SbRawClient >> runCypher: cypherString [
	^self requester runCypher: cypherString
]

{ #category : #'running cypher' }
SbRawClient >> runCyphers: cypherStrings [
	^self requester runCyphers: cypherStrings 
]

{ #category : #accessing }
SbRawClient >> settings [
	^settings ifNil: [ settings := SbSettings default ]
]

{ #category : #accessing }
SbRawClient >> settings: anObject [
	settings := anObject
]

{ #category : #'running cypher' }
SbRawClient >> transactCypher: cypherString [
	^self requester transactCypher: cypherString
]

{ #category : #'running cypher' }
SbRawClient >> transactCyphers: cypherStrings [
	^self requester transactCyphers: cypherStrings
]

{ #category : #private }
SbRawClient >> tryConnect [
	self ensureConnector.
	^ self autoReleaseDo: [ :f | | status newConnection |
		status := f create: SbBoltStatus.
		newConnection := self connector acquireConnectionWithMode: self settings accessMode toStatus: status.
		newConnection isReady ifFalse: [ self warnConnectionFailed: status. ^ nil].
		newConnection
	]
]

{ #category : #accessing }
SbRawClient >> valueFetcher [
	^self createValueFetcher
]

{ #category : #'error handling' }
SbRawClient >> warnConnectionFailed: connectionStatus [
	| error connectionStateSymbol |
	error := connectionStatus connectionStateSymbol.
	connectionStateSymbol := connectionStatus error.
	{ error. connectionStateSymbol } inspect
]
