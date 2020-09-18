Class {
	#name : #SbRawClient,
	#superclass : #SbObject,
	#instVars : [
		'settings',
		'factory',
		'configBuilder',
		'connector',
		'connection',
		'libraryLogger'
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
SbRawClient >> createLibraryLogger [
	^ self factory create: SbBoltLog
	
]

{ #category : #factory }
SbRawClient >> createRequester [
	^ self requesterClass for: self
]

{ #category : #factory }
SbRawClient >> createValueFetcher [
	^SbValueFetcher new
]

{ #category : #defaults }
SbRawClient >> defaultConfigBuilder [
	^ [ :config :clientSettings| 
		config maxPoolSize: clientSettings maxPoolSize.
		clientSettings traceLibraryLogOnTranscript ifTrue: [ 
			config log: self prepareAllToTranscriptLibraryLogger.
		]
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

{ #category : #accessing }
SbRawClient >> libraryLogger [
	^libraryLogger
]

{ #category : #accessing }
SbRawClient >> logger [
	^ self class logger
]

{ #category : #'error handling' }
SbRawClient >> notifyConnectionFailed: connectionStatus [
	| error connectionStateSymbol |
	connectionStateSymbol := connectionStatus connectionStateSymbol.
	error := connectionStatus error.
	error tag: connectionStateSymbol.
	self logger error: error.
	self settings shouldRaiseErrorOnConnectionFailed ifTrue: [ 
		error signal
	]
]

{ #category : #logging }
SbRawClient >> prepareAllToTranscriptLibraryLogger [
	^ self createLibraryLogger allToTranscript
	
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
SbRawClient >> runCypher: cypherString arguments: arguments [
	^self requester runCypher: (cypherString -> arguments)
]

{ #category : #'running cypher' }
SbRawClient >> runCyphers: cypherStringOrAssocs [
	^self requester runCyphers: cypherStringOrAssocs 
]

{ #category : #'running cypher' }
SbRawClient >> runCyphersBy: aStatementsAppenderBlock [
	| appender |
	appender := SbCypherStatementAppender new.
	aStatementsAppenderBlock value: appender.
	^self runCyphers: appender statements
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

{ #category : #'running cypher' }
SbRawClient >> transactCyphersBy: aStatementsAppenderBlock [
	| appender |
	appender := SbCypherStatementAppender new.
	aStatementsAppenderBlock value: appender.
	^self transactCyphers: appender statements
]

{ #category : #private }
SbRawClient >> tryConnect [
	self ensureConnector.
	^ self autoReleaseDo: [ :f | | status newConnection |
		status := f create: SbBoltStatus.
		newConnection := self connector acquireConnectionWithMode: self settings accessMode toStatus: status.
		newConnection isReady ifFalse: [ self notifyConnectionFailed: status. ^ nil].
		newConnection
	]
]

{ #category : #accessing }
SbRawClient >> valueFetcher [
	^self createValueFetcher
]
