Class {
	#name : #SbPharoPortableUtil,
	#superclass : #SbPortableUtil,
	#category : #'SmallBolt-Core'
}

{ #category : #'class initialization' }
SbPharoPortableUtil class >> initialize [
	"self initialize"
	self activate
]

{ #category : #actions }
SbPharoPortableUtil >> parseUri: targetUri [
	| dict url |
	dict := super parseUri: targetUri.
	url := targetUri asUrl.
	dict at: #scheme put: url scheme asString.
	dict at: #host put: url host.
	dict at: #port put: url port.
	url username ifNotNil: [:n | dict at: #username put: n  ].
	url password ifNotNil: [:p | dict at: #password put: p  ]. 
	^dict
	
	
]

{ #category : #actions }
SbPharoPortableUtil >> parseUriScheme: usiScheme [
	| tokens |
	tokens := usiScheme findTokens: '+'.
	tokens size = 1 ifTrue: [ ^ Array with: tokens first with: '' ].
	^ tokens asArray
]

{ #category : #'startup - shutdown' }
SbPharoPortableUtil >> registerAsStartupAndShutdownHandler: aClass [
	SessionManager default
		registerNetworkClassNamed: aClass name
]

{ #category : #testing }
SbPharoPortableUtil >> smalltalkMajorVersion [
	^ SystemVersion current major
]

{ #category : #'startup - shutdown' }
SbPharoPortableUtil >> unregisterAsStartupAndShutdownHandler: aClass [
	SessionManager default
		unregisterClassNamed: aClass name
]
