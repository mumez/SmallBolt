Class {
	#name : #SbSeaboltLibrary,
	#superclass : #FFILibrary,
	#classInstVars : [
		'libraryName',
		'libraryVersion',
		'libraryNameWithVersion'
	],
	#category : #'SmallBolt-FFI'
}

{ #category : #'class initialization' }
SbSeaboltLibrary class >> initialize [
	super initialize.
	libraryName := libraryVersion := libraryNameWithVersion := nil
]

{ #category : #accessing }
SbSeaboltLibrary class >> libraryName [
	^ libraryName ifNil: [ libraryName := 'libseabolt' ]
]

{ #category : #accessing }
SbSeaboltLibrary class >> libraryName: anObject [
	libraryName := anObject
]

{ #category : #accessing }
SbSeaboltLibrary class >> libraryNameWithVersion [
	^ libraryNameWithVersion ifNil: [libraryNameWithVersion := self libraryName , self libraryVersion asString]
]

{ #category : #accessing }
SbSeaboltLibrary class >> libraryVersion [
	^ libraryVersion ifNil: [ libraryVersion := 17 ]
]

{ #category : #accessing }
SbSeaboltLibrary class >> libraryVersion: anObject [
	libraryVersion := anObject
]

{ #category : #utilities }
SbSeaboltLibrary class >> useMsvcSharedLibrary [
	<script>
	self libraryName: 'seabolt'
	
]

{ #category : #private }
SbSeaboltLibrary >> libraryNameWithVersion [
	^self class libraryNameWithVersion
]

{ #category : #accessing }
SbSeaboltLibrary >> macLibraryName [
	^ self libraryNameWithVersion, '.dylib'
]

{ #category : #accessing }
SbSeaboltLibrary >> unixLibraryName [
	^ self libraryNameWithVersion, '.so'
]

{ #category : #accessing }
SbSeaboltLibrary >> win32LibraryName [
	^ self libraryNameWithVersion, '.dll'
]
