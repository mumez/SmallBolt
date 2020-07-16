"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestSmallBoltCore,
	#superclass : #PackageManifest,
	#category : #'SmallBolt-FFI-Manifest'
}

{ #category : #'code-critics' }
ManifestSmallBoltCore class >> ruleRBLiteralArrayContainsCommaRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#SbSeaboltFFI)) #'2020-06-20T00:21:43.401653+09:00') )
]
