Class {
	#name : #SmLocalLogger,
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
SmLocalLogger class >> defaultLogLevel [
	^defaultLogLevel ifNil: [ defaultLogLevel := 2]
]

{ #category : #accessing }
SmLocalLogger class >> defaultLogLevel: anInteger [
	^defaultLogLevel := anInteger
]

{ #category : #'class initialization' }
SmLocalLogger class >> initialize [
	defaultLogLevel := nil
]

{ #category : #actions }
SmLocalLogger >> debug: record [
	"Use Nagare-logger for production"
	self shouldLogDebug ifFalse: [ ^self ].
	self log: record tag: 'DEBUG'
]

{ #category : #actions }
SmLocalLogger >> error: record [
	"Use Nagare-logger for production"
	self shouldLogError ifFalse: [ ^self ].
	self log: record tag: 'ERROR'
]

{ #category : #actions }
SmLocalLogger >> info: record [
	"Use Nagare-logger for production"
	self shouldLogInfo ifFalse: [ ^self ].
	self log: record tag: 'INFO'
]

{ #category : #'initialize-release' }
SmLocalLogger >> initialize [
	logLevel := nil
]

{ #category : #acccessing }
SmLocalLogger >> isDebugging [
	^self logLevel > 0
]

{ #category : #acccessing }
SmLocalLogger >> isDebugging: aBoolean [
	| level |
	level := aBoolean ifTrue: [self defaultLogLevel] ifFalse: [0].
	self logLevel: level
]

{ #category : #private }
SmLocalLogger >> log: record tag: tagString [
	Transcript cr; show: tagString, ':', record asString
]

{ #category : #acccessing }
SmLocalLogger >> logLevel [
	^logLevel ifNil: [logLevel := self class defaultLogLevel ]
]

{ #category : #acccessing }
SmLocalLogger >> logLevel: anInteger [
	logLevel := anInteger
]

{ #category : #testing }
SmLocalLogger >> shouldLogDebug [
	^self logLevel >= 3
]

{ #category : #testing }
SmLocalLogger >> shouldLogError [
	^self logLevel >= 1
]

{ #category : #testing }
SmLocalLogger >> shouldLogInfo [
	^self logLevel >= 4
]

{ #category : #testing }
SmLocalLogger >> shouldLogWarn [
	^self logLevel >= 2
]

{ #category : #actions }
SmLocalLogger >> warn: record [
	"Use Nagare-logger for production"
	self shouldLogWarn ifFalse: [ ^self ].
	self log: record tag: 'WARN'
]
