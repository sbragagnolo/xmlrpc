"
This class holds all information about a XMLRPC request an coordinates the computation of a XMLRPC methodcall
"
Class {
	#name : #XMLRPCServerRequest,
	#superclass : #Object,
	#instVars : [
		'methodCall',
		'params',
		'targetURI'
	],
	#classVars : [
		'Receivers'
	],
	#category : #'XMLRPC-Server'
}

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> cleanUpReceiverDictionary [
	" deletes references to obsolete classes from the 'Receivers' dictionary"
	| removeThem |
	removeThem _ Receivers
				select: [:each | each isObsolete].
	removeThem
		keysDo: [:key | Receivers removeKey: key]
]

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> fromRequest: xmlString [ 
	| xmldoc r parameters |
	r _ self new.
	parameters _ OrderedCollection new.
	xmldoc _ XMLDOMParser parseDocumentFrom: xmlString readStream.
	r methodCall: (xmldoc topElement elementAt: #methodName) contentString.
	[((xmldoc topElement)
		elementAt: #params) elements
		do: [:each | parameters
				add: (XMLRPCDecoder new decode: each)]] 
		on: Error
		do: [XMLRPCRequestError new signal: 'Could not decode request'].
	r params: parameters.
	^ r
]

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> initialize [
	Receivers _ Dictionary new.
]

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> registerService: serviceName class: aClass selector: aSelector [ 
	Receivers
		ifNil: [Receivers _ Dictionary new].
	Receivers at: serviceName asSymbol put: aClass -> aSelector
]

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> removeService: aXMLRPCService [
	Receivers removeKey: aXMLRPCService asSymbol
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
	| srv stream ret |
	stream _ WriteStream on: String new.
	stream nextPutAll: '<?xml version="1.0"?><methodResponse><params><param>'.
	[
	srv _ (Receivers
				at: methodCall asSymbol
				ifAbsent: [XMLRPCMethodError new signal: 'Serverside method not found']).
	ret _ ((srv key) perform: (srv value) with: (self params)).
]
		on: MessageNotUnderstood
		do: [:e | XMLRPCMethodError new signal: 'Message not understood by  
	server class'].
	ret
		ifNil: [ret _ false].
	[stream nextPutAll: ret asXMLRPCString]
		on: Error
		do: [XMLRPCReturnError new signal: 'Could not encode returned value "' , ret asString , '"'].
	stream nextPutAll: '</param></params></methodResponse>'.
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
