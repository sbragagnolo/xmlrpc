Extension { #name : #String }

{ #category : #'*XMLRPC-Server-Core' }
String >> asXMLRPCString [
	"answer a XMLRPC representation of the receiver"
	| w |
	w := WriteStream on: String new.
	w nextPutAll: '<value>'; nextPutAll: self asString; nextPutAll: '</value>'.
	^ w contents
]
