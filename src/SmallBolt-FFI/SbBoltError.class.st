Class {
	#name : #SbBoltError,
	#superclass : #Error,
	#instVars : [
		'errorCode'
	],
	#classInstVars : [
		'errorCodes'
	],
	#category : #'SmallBolt-FFI'
}

{ #category : #private }
SbBoltError class >> buildErrorCodes [
	| dict |
	dict := Dictionary newFromPairs: self errorCodePairs.
	^ dict inject: Dictionary new into: [ :sum :each | sum at: each put: (dict keyAtValue: each); yourself]
]

{ #category : #'instance creation' }
SbBoltError class >> errorCode: anInteger [
	^ self new
		errorCode: anInteger;
		yourself
]

{ #category : #accessing }
SbBoltError class >> errorCodePairs [
^ #(
#BOLT_SUCCESS 0
#BOLT_UNKNOWN_ERROR   1
#BOLT_UNSUPPORTED   2
#BOLT_INTERRUPTED   3
#BOLT_CONNECTION_RESET   4
#BOLT_NO_VALID_ADDRESS   5
#BOLT_TIMED_OUT   6
#BOLT_PERMISSION_DENIED   7
#BOLT_OUT_OF_FILES   8
#BOLT_OUT_OF_MEMORY   9
#BOLT_OUT_OF_PORTS   10
#BOLT_CONNECTION_REFUSED   11
#BOLT_NETWORK_UNREACHABLE   12
#BOLT_TLS_ERROR   13
#BOLT_END_OF_TRANSMISSION   15
#BOLT_SERVER_FAILURE   16
#BOLT_TRANSPORT_UNSUPPORTED   16r400
#BOLT_PROTOCOL_VIOLATION   16r500
#BOLT_PROTOCOL_UNSUPPORTED_TYPE   16r501
#BOLT_PROTOCOL_NOT_IMPLEMENTED_TYPE   16r502
#BOLT_PROTOCOL_UNEXPECTED_MARKER   16r503
#BOLT_PROTOCOL_UNSUPPORTED   16r504
#BOLT_POOL_FULL   16r600
#BOLT_POOL_ACQUISITION_TIMED_OUT   16r601
#BOLT_ADDRESS_NOT_RESOLVED   16r700
#BOLT_ADDRESS_NAME_INFO_FAILED   16r701
#BOLT_ROUTING_UNABLE_TO_RETRIEVE_ROUTING_TABLE   16r800
#BOLT_ROUTING_NO_SERVERS_TO_SELECT   16r801
#BOLT_ROUTING_UNABLE_TO_CONSTRUCT_POOL_FOR_SERVER   16r802
#BOLT_ROUTING_UNABLE_TO_REFRESH_ROUTING_TABLE   16r803
#BOLT_ROUTING_UNEXPECTED_DISCOVERY_RESPONSE   16r804
#BOLT_CONNECTION_HAS_MORE_INFO   16rFFE
#BOLT_STATUS_SET   16rFFF
)
]

{ #category : #accessing }
SbBoltError class >> errorCodes [
	^ errorCodes ifNil: [ errorCodes := self buildErrorCodes ]
]

{ #category : #'class initialization' }
SbBoltError class >> initialize [
	self initializeErrorCodes
]

{ #category : #'class initialization' }
SbBoltError class >> initializeErrorCodes [
	errorCodes := nil
]

{ #category : #testing }
SbBoltError class >> isError: errorCode [
	^ errorCode > 1 "BOLT_SUCCESS"
]

{ #category : #testing }
SbBoltError class >> isSuccess: errorCode [
	^ (self isError: errorCode) not
]

{ #category : #private }
SbBoltError >> buildMessageText [
	^self errorSymbol , ' - ', self errorDescription 
]

{ #category : #accessing }
SbBoltError >> errorCode [
	^ errorCode
]

{ #category : #accessing }
SbBoltError >> errorCode: anObject [
	errorCode := anObject
]

{ #category : #accessing }
SbBoltError >> errorCodes [
	^self class errorCodes
]

{ #category : #accessing }
SbBoltError >> errorDescription [
	^self ffi getErrorStringOnErrorCode: self errorCode
]

{ #category : #accessing }
SbBoltError >> errorSymbol [
	^self errorCodes at: self errorCode ifAbsent: [ #UNKNOWN ].
]

{ #category : #accessing }
SbBoltError >> ffi [
	^ SbSeaboltFFI new
]

{ #category : #accessing }
SbBoltError >> messageText [
	messageText ifNil: [ messageText := self buildMessageText ].
	^messageText 
]
