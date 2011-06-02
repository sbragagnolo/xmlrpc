Extension { #name : #Dictionary }

{ #category : #'*XMLRPC-Server-Core' }
Dictionary >> asXMLRPCString [
	"answer a XMLRPC representation of the receiver"
	| w |
	w := WriteStream
				on: (String new: 200).
	w nextPutAll: '<value><struct>'.
	self
		keysAndValuesDo: [:key :value | 
			w nextPutAll: '<member><name>';
				 nextPutAll: key asString;
				 nextPutAll: '</name>'.
			w nextPutAll: value asXMLRPCString;
				 nextPutAll: '</member>'].
	w nextPutAll: '</struct></value>'.
	^ w contents
]
