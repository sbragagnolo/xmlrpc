Extension { #name : #SmallInteger }

{ #category : #'*XMLRPC-Server-Core' }
SmallInteger >> asXMLRPCString [
	"answer a XMLRPC representation of the receiver"
	| w |
	w := WriteStream on: (String new: 50).
	w nextPutAll: '<value><i4>'; nextPutAll: self asString; nextPutAll: '</i4></value>'.
	^ w contents
]
