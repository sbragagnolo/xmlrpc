"
XML-RPC decoder.

This class will take XML-RPC results and translate them into smalltalk types.  The following translations will take place:

	boolean  -> True or False
	string    -> String
	double   -> Float class
	i4         -> SmallInteger
	struct    -> Dictionary
	array    -> Array
	dateTime.iso8601 -> XMLRPCDateTime
	base64   -> Stream
"
Class {
	#name : #XMLRPCDecoder,
	#superclass : #Object,
	#category : #'XMLRPC-Client-Core'
}

{ #category : #decoding }
XMLRPCDecoder >> decode: xml [ 
	"Decode an XML Element representing an XML-RPC response."
	"xml inspect."
	| el0 |
	
	xml elements isEmpty ifTrue: [^ xml contentString].
	
	"Figure out what to do based on the name of the element (el0 is usually  a required argument."
	
	el0 := xml elements at: 1.
	(el0 name) caseOf: {
		[ #array ]					->	[ ^ self decodeArray: el0 ].
		[ #struct ]					-> 	[ ^ self decodeStructFromDictionary: el0 ].
		[ #param ] 					-> 	[ ^ self decode: el0 ].
		[ #value ] 					->	[ ^ self decode: el0 ].
		[ #string ] 					->	[ ^ el0 contentString ].
		[ #i4 ] 						->	[ ^ SmallInteger readFrom: el0 contentString readStream ].
		[ #int ] 						->	[ ^ SmallInteger readFrom: el0 contentString readStream ].
		[ #double ] 					->	[ ^ Float readFrom: el0 contentString readStream ].
		[ #boolean ]				->	[ ^ el0 contentString = '1' ].
		[ #'dateTime.iso8601' ]		->	[ ^ XMLRPCDateTime fromISO8601String: el0 contentString ].
		[ #base64 ] 				->	[ ^ Base64MimeConverter mimeDecodeToBytes: el0 contentString readStream ].
	} otherwise: [ 
		XMLRPCException signal: 'Unhandled type!  ' , xml name. 
	].
]

{ #category : #private }
XMLRPCDecoder >> decodeArray: xml [ 
	"Decode the Array."
	| rv |
	rv := OrderedCollection new.
	(xml elements at: 1) elements do: [ 
		:el | 
		rv add: (self decode: el)
	].

	^ rv asArray
]

{ #category : #private }
XMLRPCDecoder >> decodeStructFromDictionary: xml [
	"Decode the Struct."

	| rv name value |
	name := nil.
	value := nil.
	rv := Dictionary new.
	
	xml elements do: [ 
		:el | 
		el nodes do: [ 
			:eachNode | 
			eachNode name = 'name' ifTrue: [
				name:= eachNode contentString 
			] ifFalse: [
				value := self decode: eachNode.
				rv at: name put: value.
				name := value := nil.
			]
		]
	].	

	^ rv


]
