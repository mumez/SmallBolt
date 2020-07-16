Class {
	#name : #SbBoltConfig,
	#superclass : #SbExternalObject,
	#category : #'SmallBolt-FFI'
}

{ #category : #'instance creation' }
SbBoltConfig class >> create [
	^self ffi createConfig
]

{ #category : #releasing }
SbBoltConfig >> destroy [
	self ffi destroyConfig: self
]

{ #category : #accessing }
SbBoltConfig >> maxPoolSize [
	^ self ffi getMaxPoolSizeOnConfig: self
]

{ #category : #accessing }
SbBoltConfig >> maxPoolSize: anInteger [
	self ffi	setMaxPoolSize: anInteger onConfig: self
]

{ #category : #actions }
SbBoltConfig >> useDirectScheme [
	self ffi	setScheme: BOLT_SCHEME_DIRECT onConfig: self
]

{ #category : #actions }
SbBoltConfig >> useEncryptedTransport [
	self ffi	setTransport: BOLT_TRANSPORT_ENCRYPTED onConfig: self
]

{ #category : #actions }
SbBoltConfig >> useNeo4jScheme [
	self ffi	setScheme: BOLT_SCHEME_NEO4J onConfig: self
]

{ #category : #actions }
SbBoltConfig >> usePlainTextTransport [
	self ffi	setTransport: BOLT_TRANSPORT_PLAINTEXT onConfig: self
]

{ #category : #accessing }
SbBoltConfig >> userAgent [
	^ self ffi getUserAgentOnConfig: self
]

{ #category : #accessing }
SbBoltConfig >> userAgent: aString [
	self ffi	setUserAgent: aString asString onConfig: self
]
