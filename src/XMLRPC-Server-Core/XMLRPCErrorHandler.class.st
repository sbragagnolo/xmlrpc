"
This is the error handler for XMLRPC errors
"
Class {
	#name : #XMLRPCErrorHandler,
	#superclass : #Object,
	#instVars : [
		'error'
	],
	#category : #'XMLRPC-Server-Core'
}

{ #category : #accessing }
XMLRPCErrorHandler >> error [
	"Answer the receiver's 'error'."

	^error
]

{ #category : #accessing }
XMLRPCErrorHandler >> error: anObject [
	"Set the receiver's instance variable 'error' to be anObject."

	error := anObject
]

{ #category : #accessing }
XMLRPCErrorHandler >> errorMessage [
	| str errorDict |
	errorDict := Dictionary new.
	
	(error class canUnderstand: #faultCode) ifTrue: [
		errorDict at: #faultCode put: error faultCode
	] ifFalse: [
		errorDict at: #faultCode put: 10
	]. 

	errorDict at: #faultString put: error messageText.
	
	str := WriteStream on: (String new: 1000).
	
	str 	nextPutAll: '<?xml version="1.0"?><methodResponse><fault>';
		nextPutAll: errorDict asXMLRPCString;
		nextPutAll: '</fault></methodResponse>'.
		
	^ str contents
]
