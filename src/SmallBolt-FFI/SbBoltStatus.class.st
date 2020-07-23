Class {
	#name : #SbBoltStatus,
	#superclass : #SbExternalObject,
	#category : #'SmallBolt-FFI'
}

{ #category : #'instance creation' }
SbBoltStatus class >> create [
	^self ffi createStatus
]

{ #category : #accessing }
SbBoltStatus >> connectionState [
	^ self ffi getConnectionStateOnStatus: self
]

{ #category : #accessing }
SbBoltStatus >> connectionStateSymbol [
	^ SbBoltConstants connectionStateSymbolAt: self connectionState 
]

{ #category : #releasing }
SbBoltStatus >> destroy [
	self ffi destroyStatus: self
]

{ #category : #accessing }
SbBoltStatus >> error [
	^SbBoltError errorCode: self errorCode
]

{ #category : #accessing }
SbBoltStatus >> errorCode [
	^ self ffi getErrorCodeOnStatus: self
]

{ #category : #accessing }
SbBoltStatus >> errorContext [
	^ self ffi getErrorContextOnStatus: self
]

{ #category : #testing }
SbBoltStatus >> isError [
	^SbBoltError isError: self errorCode
]

{ #category : #testing }
SbBoltStatus >> isSuccess [
	^SbBoltError isSuccess: self errorCode
]
