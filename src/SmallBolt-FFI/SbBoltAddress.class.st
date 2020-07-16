Class {
	#name : #SbBoltAddress,
	#superclass : #SbExternalObject,
	#category : #'SmallBolt-FFI'
}

{ #category : #defaults }
SbBoltAddress class >> defaultHost [
	^'localhost'
]

{ #category : #defaults }
SbBoltAddress class >> defaultPort [
	^7687
]

{ #category : #'instance creation' }
SbBoltAddress class >> host: host [
	^self host: host port: self defaultPort
]

{ #category : #'instance creation' }
SbBoltAddress class >> host: host port: port [
	^self ffi createAddress: host port: port asString
]

{ #category : #releasing }
SbBoltAddress >> destroy [
	self ffi destroyAddress: self
]

{ #category : #accessing }
SbBoltAddress >> host [
	^ self ffi getHostOnAddress: self
]

{ #category : #accessing }
SbBoltAddress >> port [
	^ self ffi getPortOnAddress: self
]
