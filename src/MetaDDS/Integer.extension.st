Extension { #name : #Integer }

{ #category : #'*MetaDDS' }
Integer >> bitInvert16 [
	"Answer the 8-bit complement of the receiver."

	^ self bitXor: 16rFFFF
]

{ #category : #'*MetaDDS' }
Integer >> bitInvert64 [
	"Answer the 64-bit complement of the receiver."
	^ self bitXor: 16rFFFFFFFFFFFFFFFF.
]

{ #category : #'*MetaDDS' }
Integer >> bitInvert8 [
		^ self bitXor: 16rFF
]

{ #category : #'*MetaDDS' }
Integer class >> fromByteArray: aByteArray [ 
	^ self byte1: (aByteArray at:1) byte2: (aByteArray at:2) byte3:( aByteArray at:3 )byte4: (aByteArray at:4) .
]
