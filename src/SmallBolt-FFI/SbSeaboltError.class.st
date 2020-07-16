Class {
	#name : #SbSeaboltError,
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
SbSeaboltError class >> buildErrorCodes [
	| dict |
	dict := Dictionary newFromPairs: self errorCodePairs.
	^ dict inject: Dictionary new into: [ :sum :each | sum at: each put: (dict keyAtValue: each); yourself]
]

{ #category : #'instance creation' }
SbSeaboltError class >> errorCode: anInteger [
	^ self new
		errorCode: anInteger;
		yourself
]

{ #category : #accessing }
SbSeaboltError class >> errorCodePairs [
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
SbSeaboltError class >> errorCodes [
	^ errorCodes ifNil: [ errorCodes := self buildErrorCodes ]
]

{ #category : #'class initialization' }
SbSeaboltError class >> initialize [
	self initializeErrorCodes
]

{ #category : #'class initialization' }
SbSeaboltError class >> initializeErrorCodes [
	errorCodes := nil
]

{ #category : #private }
SbSeaboltError >> buildMessageText [
	^self errorSymbol , ' - ', self errorDescription 
]

{ #category : #accessing }
SbSeaboltError >> errorCode [
	^ errorCode
]

{ #category : #accessing }
SbSeaboltError >> errorCode: anObject [
	errorCode := anObject
]

{ #category : #accessing }
SbSeaboltError >> errorCodes [
	^self class errorCodes
]

{ #category : #accessing }
SbSeaboltError >> errorDescription [
	^self ffi getErrorStringOnErrorCode: self errorCode
]

{ #category : #accessing }
SbSeaboltError >> errorSymbol [
	^self errorCodes at: self errorCode ifAbsent: [ #UNKNOWN ].
]

{ #category : #accessing }
SbSeaboltError >> ffi [
	^ SbSeaboltFFI new
]

{ #category : #accessing }
SbSeaboltError >> messageText [
	messageText ifNil: [ messageText := self buildMessageText ].
	^messageText 
]
