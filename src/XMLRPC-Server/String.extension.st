Extension { #name : #String }

{ #category : #'*xmlrpc-server' }
String >> asXMLRPCString [
	"answer a XMLRPC representation of the receiver"
	| w |
	w _ WriteStream on: String new.
	w nextPutAll: '<value>'; nextPutAll: self asString; nextPutAll: '</value>'.
	^ w contents
]
