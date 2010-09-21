"
Test the XMLRPC Encoder.

XMLRPCEncoderTest new testEncoder
"
Class {
	#name : #XMLRPCEncoderTest,
	#superclass : #SpyTest,
	#category : #'Spy-XML-RPC-Test'
}

{ #category : #Testing }
XMLRPCEncoderTest >> suite [
	^ (TestSuite named: 'XMLRPCEncoderTests')
		addTest: (XMLRPCEncoderTest selector: #testEncoder)
]

{ #category : #Testing }
XMLRPCEncoderTest >> testEncoder [
	"Run all the encoder tests."
	| e d |
	e _ XMLRPCEncoder new.
	"Transcript show: 'Running encoder test.'; cr."
	self
		assertEquals: '<value><i4>17</i4></value>'
		to: (e encode: 17)
		msg: 'Encoding int.'.
	self
		assertEquals: '<value><double>3.14159265358979</double></value>'
		to: (e encode: 3.14159265358979)
		msg: 'Encoding float.'.
	self
		assertEquals: '<value><string>pi</string></value>'
		to: (e encode: 'pi')
		msg: 'Encoding string.'.
	self
		assertEquals: '<value><boolean>1</boolean></value>'
		to: (e encode: True)
		msg: 'Encoding True'.
	self
		assertEquals: '<value><boolean>0</boolean></value>'
		to: (e encode: False)
		msg: 'Encoding False'.
	self
		assertEquals: '<value><array><data><value><i4>1</i4></value><value><i4>2</i4></value></data></array></value>'
		to: (e encode: #(1 2 ))
		msg: 'Encoding array.'.
	d _ Dictionary new.
	d at: 'a' put: 'A'.
	d at: 'b' put: 'B'.
	self
		assertEquals: '<value><struct><member><name>b</name><value><string>B</string></value></member><member><name>a</name><value><string>A</string></value></member></struct></value>'
		to: (e encode: d)
		msg: 'Encoding struct.'
]
