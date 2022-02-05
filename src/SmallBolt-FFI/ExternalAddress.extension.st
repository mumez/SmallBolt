Extension { #name : #ExternalAddress }

{ #category : #'*SmallBolt-FFI' }
ExternalAddress >> asByteArraySized: size [
	| index aByte |
	^ (ByteArray streamContents: [ :aStream |
			index := 1.
			[index >= size] 
				whileFalse: [
					aByte := self unsignedByteAt: index.
					aStream nextPut: aByte.
					index := index + 1]]) 

]
