Extension { #name : #ByteString }

{ #category : #'*XMLRPC-Server-Core' }
ByteString >> asXMLRPCString [
	"answer a XMLRPC representation of the receiver"
	"TO-DO Revisar, está como String por ahora"
"	^ '<value>' , self asString , '</value>' "
	
	| w |
	w := WriteStream on: String new.
	w nextPutAll: '<value>'; nextPutAll: self asString; nextPutAll: '</value>'.
	^ w contents
]
