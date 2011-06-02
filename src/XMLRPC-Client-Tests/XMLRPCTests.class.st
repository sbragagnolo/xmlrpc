"
SUnit tests for all XML-RPC functionality.
"
Class {
	#name : #XMLRPCTests,
	#superclass : #TestCase,
	#category : #'XMLRPC-Client-Tests'
}

{ #category : #Testing }
XMLRPCTests >> suite [
	| s |
	s := TestSuite named: 'All XML RPC Tests'.
	s
		addTest: (XMLRPCEncoderTest selector: #testEncoder).
	s
		addTest: (XMLRPCDecoderTest selector: #testDecoder).
	s
		addTest: (XMLRPCTest  selector: #testArray).	
	s
		addTest: (XMLRPCTest  selector: #testBinary).	
	s
		addTest: (XMLRPCTest  selector: #testBoolean).	
	s
		addTest: (XMLRPCTest  selector: #testInt).	
	s
		addTest: (XMLRPCTest  selector: #testDateTime).	
	s
		addTest: (XMLRPCTest  selector: #testString).	
	s
		addTest: (XMLRPCTest  selector: #testStruct).	
				
	^ s
]
