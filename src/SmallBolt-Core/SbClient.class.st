Class {
	#name : #SbClient,
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
SbClient >> authenticate [
	^(SbAuthenticator for: self) authenticate
]

{ #category : #releasing }
SbClient >> autoReleaseDo: aBlock [
	^ [ aBlock cull: self factory ]
		ensure: [ self releaseFactory ]
]

{ #category : #accessing }
SbClient >> client [
	^ self
]

{ #category : #accessing }
SbClient >> configBuilder [
	^configBuilder ifNil: [ configBuilder := self defaultConfigBuilder ]
]

{ #category : #accessing }
SbClient >> configBuilder: aBlock [
	configBuilder := aBlock
]

{ #category : #connecting }
SbClient >> connect [
	connection ifNil: [ connection := self tryConnect ].
	^connection
]

{ #category : #accessing }
SbClient >> connector [
	^ connector
]

{ #category : #factory }
SbClient >> createAddress [
	^ self factory create: SbBoltAddress
	
]

{ #category : #factory }
SbClient >> createConfig [
	^ self factory createConfigBySetting: self configBuilder
	
]

{ #category : #factory }
SbClient >> createConnector [
	^ self factory createConnector: self createActionMap token: self authenticate config: self createConfig
]

{ #category : #defaults }
SbClient >> defaultConfigBuilder [
	^ [ :config :clientSettings| 
		config maxPoolSize: clientSettings maxPoolSize.
	]
]

{ #category : #private }
SbClient >> ensureConnector [
	connector
		ifNil: [ connector := self autoReleaseDo: [ self createConnector ] ].
	^ connector
]

{ #category : #accessing }
SbClient >> factory [
	^factory ifNil: [ factory := SbExternalObjectFactory on: self settings ]
]

{ #category : #accessing }
SbClient >> factory: anObject [
	factory := anObject
]

{ #category : #'initialization-release' }
SbClient >> release [
	self releaseFactory 
]

{ #category : #releasing }
SbClient >> releaseFactory [
	factory ifNotNil: [ factory autoRelease ].
	factory := nil
]

{ #category : #accessing }
SbClient >> settings [
	^settings ifNil: [ settings := SbSettings default ]
]

{ #category : #accessing }
SbClient >> settings: anObject [
	settings := anObject
]

{ #category : #private }
SbClient >> tryConnect [
	self ensureConnector.
	^ self autoReleaseDo: [ :f | | status newConnection |
		status := f create: SbBoltStatus.
		newConnection := self connector acquireConnectionWithMode: self settings accessMode toStatus: status.
		newConnection ifNil: [ self warnConnectionFailed: status ].
		newConnection
	]
]

{ #category : #'error handling' }
SbClient >> warnConnectionFailed: connectionStatus [
	| error connectionStateSymbol |
	error := connectionStatus connectionStateSymbol.
	connectionStateSymbol := connectionStatus error.
	{ error. connectionStateSymbol } inspect
]
