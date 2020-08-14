Class {
	#name : #BaselineOfSmallBolt,
	#superclass : #BaselineOf,
	#category : #BaselineOfSmallBolt
}

{ #category : #baseline }
BaselineOfSmallBolt >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
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
