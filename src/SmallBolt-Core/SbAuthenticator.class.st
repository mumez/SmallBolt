Class {
	#name : #SbAuthenticator,
	#superclass : #SbObject,
	#category : #'SmallBolt-Core'
}

{ #category : #actions }
SbAuthenticator >> authenticate [
	| token |
	token := self basicAuthenticate.
	self factory pool register: token.
	^token
]

{ #category : #actions }
SbAuthenticator >> basicAuthenticate [
	| se |
	se := self settings.
	se isBasicAuth
		ifTrue: [ ^ self ffi
				authBasic: se userName
				password: se password
				realm: se realm ].
	^ self ffi authNone
]
