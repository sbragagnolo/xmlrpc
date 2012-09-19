"
This class holds all information about a XMLRPC request an coordinates the computation of a XMLRPC methodcall
"
Class {
	#name : #XMLRPCServerRequest,
	#superclass : #Object,
	#traits : 'TLogger',
	#classTraits : 'TLogger classTrait',
	#instVars : [
		'methodCall',
		'params',
		'targetURI'
	],
	#classVars : [
		'Receivers'
	],
	#category : #'XMLRPC-Server-Core'
}

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> cleanUpReceiverDictionary [
	" deletes references to obsolete classes from the 'Receivers' dictionary"
	| removeThem |
	
	self debug: ['Cleaning up receiving dictionary: ' , self receivers ].
	removeThem := self receivers 	select: [ : each | each isObsolete ].
	removeThem keysDo: [ : key | self receivers removeKey: key ].
	
]

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> fromRequest: xmlString [ 
	| xmldoc r parameters relatedSelector |
	
	self debug: ['Creating XMLRPCServerRequest from:', xmlString ].
	
	r := self new.
	parameters := OrderedCollection new.
	xmldoc := XMLDOMParser parseDocumentFrom: xmlString readStream.
	
	relatedSelector := ((xmldoc firstElement elementAt: #methodName) contentString).
	
	self info: ['Server requested for: ', relatedSelector ].
	r methodCall: relatedSelector.	
	[
		((xmldoc firstElement) elementAt: #params ) elements do: [
			:each | 
			parameters add: (XMLRPCDecoder new decode: each)
		].
		
	] on: Error do: [
		XMLRPCRequestError new signal: 'Could not decode request'
	].

	self info: ['Using parameters ', parameters ].
	r params: parameters.
	^ r
]

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> initialize [
	Receivers := Dictionary new.
]

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> receivers [
	^Receivers ifNil: [Receivers := Dictionary new].
]

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> registerService: serviceName class: aClass selector: aSelector [ 
	self info: ['Registering service: ', serviceName, ' Poting to #', aClass name asSymbol asString, '>>', aSelector asSymbol asString  ].
	self receivers at: serviceName asSymbol put: aClass -> aSelector
]

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> removeAllServices [
	self info: ['Removing all services '].
	self receivers removeAll.
]

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> removeService: aXMLRPCService [
	self info: ['Removing service: ', aXMLRPCService asString ].
	self receivers removeKey: aXMLRPCService asSymbol
]

{ #category : #accessing }
XMLRPCServerRequest >> methodCall [
	"Answer the receiver's 'methodCall'."

	^methodCall
]

{ #category : #accessing }
XMLRPCServerRequest >> methodCall: anObject [
	"Set the receiver's instance variable 'methodCall' to be anObject."

	methodCall := anObject
]

{ #category : #invocation }
XMLRPCServerRequest >> methodResponse [
	| srv stream ret encodedReturn |
	
	" 
		Reach the method then executeit. If is not there a MessageNotFound is thrown. 
		TODO: show an error in case of method fail.
	"
	self flag: #lookAtTheComment.

	[
		self debug: ['Attempting to load [', methodCall ,'] service'].
		srv := (
		Receivers at: methodCall asSymbol ifAbsent: [
			self logError: ['There is not related service to: [', methodCall asSymbol asString, ']'].
			XMLRPCMethodError new signal: 'Serverside method not found'
			]
		).
		self debug: ['Attempting to call [', methodCall ,' service]'].
		ret := ((srv key) perform: (srv value) withArguments: (self params asArray)).		
		ret 	ifNil: [ret := false].
			
		self debug: ['Service call was successfull ', ret asString].
			
	] on: Error do: [
		:e | 
		self halt.
		self logError: ['Error calling service [', methodCall asSymbol asString, '] [', e messageText, ']'].
		XMLRPCMethodError new signal: 'Message not understood by server class: ', e messageText.
	] .
 "MessageNotUnderstood"
	
	" 
		If all the process of execution was right, just need to encode the response in the xml format. 
	"	
	[
		encodedReturn := ret asXMLRPCString.
	] on: Error do: [
		:e |
		self logError: ['Error trying to encode service [', methodCall asSymbol asString, '] response [', e messageText, ']'].
		
		XMLRPCReturnError new signal: 'Could not encode returned value "' , ret asString , '"'
	].
	
	
	stream := WriteStream on: String new.
	
	stream nextPutAll: '<?xml version="1.0"?><methodResponse><params><param>'.
	stream nextPutAll: encodedReturn.
	stream nextPutAll: '</param></params></methodResponse>'.
	
	self debug: [ 'XMLResponse: ', '<?xml version="1.0"?><methodResponse><params><param>', String cr, encodedReturn, String cr, '</param></params></methodResponse>'.].
	^ stream contents
	







]

{ #category : #accessing }
XMLRPCServerRequest >> params [
	"Answer the receiver's 'params'."

	^params
]

{ #category : #accessing }
XMLRPCServerRequest >> params: anObject [
	"Set the receiver's instance variable 'params' to be anObject."

	params := anObject
]

{ #category : #accessing }
XMLRPCServerRequest >> targetURI [
	"Answer the receiver's 'targetURI'."

	^targetURI
]

{ #category : #accessing }
XMLRPCServerRequest >> targetURI: anObject [
	"Set the receiver's instance variable 'targetURI' to be anObject."

	targetURI := anObject
]
