"
Encode objects into proper XML-RPC types.

The following types are understood (smalltalk types in parens):

	Booleans (True and False)
	Strings (String)
	Strings (ByteString) --> GermanArduino 06/06/2010
	Doubles (Float class)
	Integers (SmallInteger class)
	Struct (Dictionary)
	Array (Array)
	dateTime.iso8601 (XMLRPCDateTime)
	base64 (Stream)
"
Class {
	#name : #XMLRPCEncoder,
	#superclass : #Object,
	#category : #'Spy-XML-RPC'
}

{ #category : #encoding }
XMLRPCEncoder >> encode: val [ 
	"Encode the given value for inclusion in an XML-RPC request or  
	response.  
	 
	Returns the encoded value.  
	"
	val caseOf: {
		[True] -> [^ self wrapVal: '1' type: 'boolean'].
		[true] -> [^ self wrapVal: '1' type: 'boolean'].
		[False] -> [^ self wrapVal: '0' type: 'boolean'].
		[false] -> [^ self wrapVal: '0' type: 'boolean'].
	} otherwise: [
		(val class) caseOf: {
			[SmallInteger] -> [^ self wrapVal: val asString type: 'i4'].
			[Float] -> [^ self wrapVal: val asString type: 'double'].
			[String] -> [^ self
				wrapVal: (self normalize: val)].
			[ByteString] -> [^ self
				wrapVal: (self normalize: val)].
			[XMLRPCDateTime] -> [^ self wrapVal: val encodeISO8601 type: 'dateTime.iso8601'].
			[Array] -> [^ self
				wrapVal: (self encodeArray: val)
				type: 'array'].
			[Dictionary] -> [^ self
				wrapVal: (self encodeStruct: val)
				type: 'struct'].
		} otherwise: [
			val isStream
				ifTrue: [^ self wrapVal: (Base64MimeConverter mimeEncode: val) contents type: 'base64']
				ifFalse:
					"Unhandled type."
					[XMLRPCException signal: 'Unhandled type:  ' , val className].
			]]
]

{ #category : #private }
XMLRPCEncoder >> encodeArray: a [ 
	"Encode an array."
	| rv |
	rv _ Text new.
	rv append: '<data>'.
	a
		do: [:el | rv
				append: (self encode: el)].
	rv append: '</data>'.
	^ rv asString
]

{ #category : #private }
XMLRPCEncoder >> encodeStruct: s [ 
	"Encode a struct."
	| rv |
	rv _ Text new.
	s
		keysAndValuesDo: [:key :val | rv append: '<member><name>' , (self normalize: key) , '</name>'
					, (self encode: val) , '</member>'].
	^ rv asString
]

{ #category : #private }
XMLRPCEncoder >> normalize: s [ 
	"Normalize an XML string."
	| rv map |
	map _ Dictionary new.
	map at: $< put: '&lt;'.
	map at: $> put: '&gt;'.
	map at: $& put: '&amp;'.
	rv _ Text new.
	s
		do: [:c | 
			rv
				append: (map
						at: c
						ifAbsent: [c])].
	^ rv asString
]

{ #category : #private }
XMLRPCEncoder >> wrapVal: val [
	"Wrap the given value in <value> tags, assuming it's already a string."
	^ self wrapVal: val type: 'string'
]

{ #category : #private }
XMLRPCEncoder >> wrapVal: val type: t [ 
	"Wrap the given value in <value> and <t>"
	^ '<value><' , t , '>' , val , '</' , t , '></value>'
]
