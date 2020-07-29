Class {
	#name : #SbClient,
	#superclass : #SbRawClient,
	#category : #'SmallBolt-GraphModel'
}

{ #category : #factory }
SbClient >> createValueFetcher [
	^SbGraphObjectValueFetcher new
]
