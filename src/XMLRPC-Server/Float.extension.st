Extension { #name : #Float }

{ #category : #'*xmlrpc-server' }
Float >> asXMLRPCString [
	"answer a XMLRPC representation of the receiver"
	| w | 
	w := WriteStream
				on: (String new: 50).
	w nextPutAll: '<value><double>';
		 nextPutAll: self asString;
		 nextPutAll: '</double></value>'.
	^ w contents
]
