"
Test the XMLRPC Decoder.

XMLRPCDecoderTest new testDecoder
"
Class {
	#name : #XMLRPCDecoderTest,
	#superclass : #SpyTest,
	#category : #'Spy-XML-RPC-Test'
}

{ #category : #Testing }
XMLRPCDecoderTest >> suite [
	^ (TestSuite named: 'XMLRPCDecoderTests')
		addTest: (XMLRPCDecoderTest selector: #testDecoder)
]

{ #category : #Testing }
XMLRPCDecoderTest >> testDecoder [
	"Test the decoder."
	| e d coll dict |
	e _ XMLRPCEncoder new.
	d _ XMLRPCDecoder new.
	dict _ Dictionary new.
	dict at: 'a' put: 'A'.
	dict at: 'b' put: 'B'.
	coll _ OrderedCollection new.
	coll add: 17.
	coll add: 'Some String'.
	coll add: true.
	coll add: false.
	coll add: 3.14159265359.
	coll add: XMLRPCDateTime now.
	coll add: #(1 2 3 'ima g' ).
	coll add: dict.
	coll
		do: [:item | 
			| xdom er dr | 
			er _ self
						xmlIfy: (e encode: item).
			xdom _ XMLDOMParser parseDocumentFrom: er readStream.
			dr _ d
						decode: (xdom elements at: 1).
			"Transcript show: 'Decoded ' , er , ' to ' , dr asString. 
			Transcript cr."
			self
				assertEquals: item
				to: dr
				msg: 'Decoding ' , item className]
]

{ #category : #private }
XMLRPCDecoderTest >> xmlIfy: t [ 
	^ '<?xml version="1.0"?><param>' , t , '</param>'
]
