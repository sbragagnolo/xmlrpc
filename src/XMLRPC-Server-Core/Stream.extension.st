Extension { #name : #Stream }

{ #category : #'*XMLRPC-Server-Core' }
Stream >> asXMLRPCString [
	"answer a XMLRPC representation of the receiver. A stream will be
	encoded as an base64 (mimeencoded) element."
	| w |
	w := WriteStream on: String new.
	w nextPutAll: '<value><base64>';
		 nextPutAll: (Base64MimeConverter mimeEncode: self) contents;
		 nextPutAll: '</base64></value>'.
	^ w contents
]
