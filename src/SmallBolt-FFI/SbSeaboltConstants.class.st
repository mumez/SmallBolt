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

{ #category : #utility }
SbSeaboltConstants class >> accessModeAt: aSymbol [
	aSymbol = #write ifTrue: [ ^ BOLT_ACCESS_MODE_WRITE ].
	^ BOLT_ACCESS_MODE_READ
]

{ #category : #utility }
SbSeaboltConstants class >> accessModeSymbolAt: anInteger [
	anInteger = BOLT_ACCESS_MODE_READ ifTrue: [ ^ #read ].
	anInteger = BOLT_ACCESS_MODE_WRITE ifTrue: [ ^ #write ].
	^ #unknown
]

{ #category : #utility }
SbSeaboltConstants class >> connectionStateSymbolAt: anInteger [
	anInteger = BOLT_CONNECTION_STATE_DISCONNECTED ifTrue: [ ^ #disconnected].
	anInteger = BOLT_CONNECTION_STATE_CONNECTED ifTrue: [ ^ #connected].
	anInteger = BOLT_CONNECTION_STATE_READY ifTrue: [ ^ #ready].
	anInteger = BOLT_CONNECTION_STATE_FAILED ifTrue: [ ^ #failed].
	anInteger = BOLT_CONNECTION_STATE_DEFUNCT ifTrue: [ ^ #defunct ].
	^ #unknown
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

{ #category : #utility }
SbSeaboltConstants class >> schemeSymbolAt: anInteger [
	anInteger = BOLT_SCHEME_DIRECT ifTrue: [ ^ #direct ].
	anInteger = BOLT_SCHEME_NEO4J ifTrue: [ ^ #neo4j ].
	^ #unknown
]

{ #category : #utility }
SbSeaboltConstants class >> transportSymbolAt: anInteger [
	anInteger = BOLT_TRANSPORT_PLAINTEXT ifTrue: [ ^ #plaintext ].
	anInteger = BOLT_TRANSPORT_ENCRYPTED ifTrue: [ ^ #encrypted ].
	^ #unknown
]
