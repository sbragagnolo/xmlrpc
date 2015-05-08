"
Test the XMLRPC Decoder.

XMLRPCDecoderTest new testDecoder
"
Class {
	#name : #XMLRPCDecoderTest,
	#superclass : #XMLRPCClientBaseTest,
	#category : #'XMLRPC-Client-Tests'
}

{ #category : #'instance creation' }
XMLRPCDecoderTest >> suite [
	^ (TestSuite named: 'XMLRPCDecoderTests')
		addTest: (XMLRPCDecoderTest selector: #testDecoder)
]

{ #category : #tests }
XMLRPCDecoderTest >> testDecoder [
	"Test the decoder."
	| e d coll |
	e := XMLRPCEncoder new.
	d := XMLRPCDecoder new.

	coll := OrderedCollection new.
	coll add: 17.
	coll add: 'Some String'.
	coll add: true.
	coll add: false.
	coll add: 3.14159265359.
	coll add: XMLRPCDateTime now.
	coll add: #(1 2 3 'ima g' ).

	coll
		do: [:item | 
			| xdom er dr | 
			er := self
						xmlIfy: (e encode: item).
			xdom := XMLDOMParser parseDocumentFrom: er readStream.
			dr := d
						decode: (xdom elements at: 1).
			"Transcript show: 'Decoded ' , er , ' to ' , dr asString. 
			Transcript cr.]"
			self
				assertEquals: item
				to: dr  
				msg: 'Decoding ' , item className]
			
		
]

{ #category : #tests }
XMLRPCDecoderTest >> testDecoderStruct [
	"Test the decoder structure."
	| e d dict xdom er dr|
	e := XMLRPCEncoder new.
	d := XMLRPCDecoder new.
	dict := Dictionary new.
	dict at: 'a' put: 'A'.
	dict at: 'b' put: 'B'.

	er := self xmlIfy: (e encodeStruct: dict).


	xdom := XMLDOMParser parse: er readStream.

	dr := d decodeStruct: (xdom findElementNamed: 'struct').
			"Transcript show: 'Decoded ' , er , ' to ' , dr asString. 
			Transcript cr."
		self
			assertEquals: dict
				to: dr
				msg: 'Decoding ' , dict className



]

{ #category : #'test support' }
XMLRPCDecoderTest >> xmlIfy: t [ 
	^ '<?xml version="1.0"?><param>' , t , '</param>'
]
