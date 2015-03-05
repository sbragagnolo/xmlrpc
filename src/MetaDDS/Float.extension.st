Extension { #name : #Float }

{ #category : #'*MetaDDS' }
Float class >> fromIEEE32BitByteArray: aByteArray [ 
	^ self fromIEEE32Bit: (LargePositiveInteger fromByteArray: aByteArray ).
]
