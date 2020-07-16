Class {
	#name : #SbBoltConnector,
	#superclass : #SbExternalObject,
	#category : #'SmallBolt-FFI'
}

{ #category : #'instance creation' }
SbBoltConnector class >> address: address token: token config: config [
	^self ffi createConnector: address token: token config: config
]

{ #category : #actions }
SbBoltConnector >> acquireConnectionWithMode: accessMode toStatus: status [
	^self ffi acquireConnection: self mode: accessMode status: status
]

{ #category : #releasing }
SbBoltConnector >> destroy [
	self ffi destroyConnector: self
]

{ #category : #actions }
SbBoltConnector >> releaseConnection: aBoltConnection [
	^self ffi releaseConnection: aBoltConnection onConnector: self
]
