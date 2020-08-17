Class {
	#name : #SbLocalLogger,
	#superclass : #Object,
	#instVars : [
		'logLevel'
	],
	#classInstVars : [
		'defaultLogLevel'
	],
	#category : #'SmallBolt-Core'
}

{ #category : #accessing }
SbLocalLogger class >> defaultLogLevel [
	^defaultLogLevel ifNil: [ defaultLogLevel := 2]
]

{ #category : #accessing }
SbLocalLogger class >> defaultLogLevel: anInteger [
	^defaultLogLevel := anInteger
]

{ #category : #'class initialization' }
SbLocalLogger class >> initialize [
	defaultLogLevel := nil
]

{ #category : #actions }
SbLocalLogger >> debug: record [
	"Use Nagare-logger for production"
	self shouldLogDebug ifFalse: [ ^self ].
	self log: record tag: 'DEBUG'
]

{ #category : #actions }
SbLocalLogger >> error: record [
	"Use Nagare-logger for production"
	self shouldLogError ifFalse: [ ^self ].
	self log: record tag: 'ERROR'
]

{ #category : #actions }
SbLocalLogger >> info: record [
	"Use Nagare-logger for production"
	self shouldLogInfo ifFalse: [ ^self ].
	self log: record tag: 'INFO'
]

{ #category : #'initialize-release' }
SbLocalLogger >> initialize [
	logLevel := nil
]

{ #category : #acccessing }
SbLocalLogger >> isDebugging [
	^self logLevel > 0
]

{ #category : #acccessing }
SbLocalLogger >> isDebugging: aBoolean [
	| level |
	level := aBoolean ifTrue: [self defaultLogLevel] ifFalse: [0].
	self logLevel: level
]

{ #category : #private }
SbLocalLogger >> log: record tag: tagString [
	Transcript cr; show: tagString, ':', record asString
]

{ #category : #acccessing }
SbLocalLogger >> logLevel [
	^logLevel ifNil: [logLevel := self class defaultLogLevel ]
]

{ #category : #acccessing }
SbLocalLogger >> logLevel: anInteger [
	logLevel := anInteger
]

{ #category : #testing }
SbLocalLogger >> shouldLogDebug [
	^self logLevel >= 3
]

{ #category : #testing }
SbLocalLogger >> shouldLogError [
	^self logLevel >= 1
]

{ #category : #testing }
SbLocalLogger >> shouldLogInfo [
	^self logLevel >= 4
]

{ #category : #testing }
SbLocalLogger >> shouldLogWarn [
	^self logLevel >= 2
]

{ #category : #actions }
SbLocalLogger >> warn: record [
	"Use Nagare-logger for production"
	self shouldLogWarn ifFalse: [ ^self ].
	self log: record tag: 'WARN'
]
