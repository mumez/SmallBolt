Class {
	#name : #BaselineOfSmallBolt,
	#superclass : #BaselineOf,
	#category : #BaselineOfSmallBolt
}

{ #category : #baseline }
BaselineOfSmallBolt >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec blessing: #baseline.
		spec preLoadDoIt: #preLoad.
		
		spec package: 'SmallBolt-FFI'.
		spec package: 'SmallBolt-Core'.
		spec package: 'SmallBolt-GraphModel' with: [
				spec requires: #('SmallBolt-Core')].
		spec package: 'SmallBolt-Session' with: [
				spec requires: #('SmallBolt-Core')].
		spec package: 'SmallBolt-Tests' with: [
				spec requires: #('SmallBolt-Core')].
		spec 
			group: 'default' with: #('Core' 'Tests');
			group: 'Core' with: #('SmallBolt-FFI' 'SmallBolt-Core' 'SmallBolt-GraphModel' 'SmallBolt-Session');
			group: 'Tests' with: #('SmallBolt-Tests')].

]

{ #category : #private }
BaselineOfSmallBolt >> platformLibraryName [
	| os libBaseName |
	os := Smalltalk os.
	libBaseName := self sharedLibraryBaseName.
	os isUnix ifTrue: [ ^ libBaseName, '.so' ].
	os isWindows ifTrue: [ ^ libBaseName, '.dll' ].
	os isMacOSX ifTrue: [ ^ libBaseName, '.dylib' ].
	self error: 'Unsupported OS platform'
]

{ #category : #private }
BaselineOfSmallBolt >> platformLibraryUrl [
	^'https://github.com/mumez/SmallBolt/releases/download/stable/', self platformLibraryName 
]

{ #category : #doits }
BaselineOfSmallBolt >> preLoad [
	self platformLibraryName asFileReference exists 
		ifTrue: [ ^ self ].

	ZnClient new
		url: self platformLibraryUrl;
		downloadTo: (FileLocator imageDirectory / self platformLibraryName) fullName.
]

{ #category : #private }
BaselineOfSmallBolt >> sharedLibraryBaseName [
	^'libseabolt17'
]
