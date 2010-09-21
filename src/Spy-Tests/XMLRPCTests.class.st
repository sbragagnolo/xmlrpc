"
SUnit tests for all XML-RPC functionality.
"
Class {
	#name : #XMLRPCTests,
	#superclass : #TestCase,
	#category : #'Spy-XML-RPC-Test'
}

{ #category : #Testing }
XMLRPCTests >> suite [
	| s |
	s _ TestSuite named: 'All XML RPC Tests'.
	s
		addTest: (XMLRPCEncoderTest selector: #testEncoder).
	s
		addTest: (XMLRPCDecoderTest selector: #testDecoder).
	^ s
]
