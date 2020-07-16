Class {
	#name : #SbSeaboltConstants,
	#superclass : #SharedPool,
	#classVars : [
		'BOLT_ACCESS_MODE_READ',
		'BOLT_ACCESS_MODE_WRITE',
		'BOLT_CONNECTION_STATE_CONNECTED',
		'BOLT_CONNECTION_STATE_DEFUNCT',
		'BOLT_CONNECTION_STATE_DISCONNECTED',
		'BOLT_CONNECTION_STATE_FAILED',
		'BOLT_CONNECTION_STATE_READY',
		'BOLT_SCHEME_DIRECT',
		'BOLT_SCHEME_NEO4J',
		'BOLT_TRANSPORT_ENCRYPTED',
		'BOLT_TRANSPORT_PLAINTEXT'
	],
	#category : #'SmallBolt-FFI'
}

{ #category : #accessing }
SbSeaboltConstants class >> ACCESS_MODE_READ [
	^BOLT_ACCESS_MODE_READ
]

{ #category : #accessing }
SbSeaboltConstants class >> ACCESS_MODE_WRITE [
	^BOLT_ACCESS_MODE_WRITE
]

{ #category : #utility }
SbSeaboltConstants class >> connectionStateSymbolAt: anInteger [
	anInteger = BOLT_CONNECTION_STATE_DISCONNECTED ifTrue: [ ^#DISCONNECTED ].
	anInteger = BOLT_CONNECTION_STATE_CONNECTED ifTrue: [ ^#CONNECTED ].
	anInteger = BOLT_CONNECTION_STATE_READY ifTrue: [ ^#READY ].
	anInteger = BOLT_CONNECTION_STATE_FAILED ifTrue: [ ^#FAILED ].
	anInteger = BOLT_CONNECTION_STATE_DEFUNCT ifTrue: [ ^#DEFUNCT ].
	^ #UNKNOWN
]

{ #category : #'class initialization' }
SbSeaboltConstants class >> initialize [
	self initializeConfig.
	self initializeConnectionState
]

{ #category : #'class initialization' }
SbSeaboltConstants class >> initializeConfig [
	BOLT_SCHEME_DIRECT := 0.
	BOLT_SCHEME_NEO4J := 1.
	BOLT_TRANSPORT_PLAINTEXT := 0.
	BOLT_TRANSPORT_ENCRYPTED := 1.
	BOLT_ACCESS_MODE_WRITE := 0.
	BOLT_ACCESS_MODE_READ := 1.
]

{ #category : #'class initialization' }
SbSeaboltConstants class >> initializeConnectionState [
	BOLT_CONNECTION_STATE_DISCONNECTED := 0.
	BOLT_CONNECTION_STATE_CONNECTED := 1.
	BOLT_CONNECTION_STATE_READY := 2.
	BOLT_CONNECTION_STATE_FAILED := 3.
	BOLT_CONNECTION_STATE_DEFUNCT := 4.
]
