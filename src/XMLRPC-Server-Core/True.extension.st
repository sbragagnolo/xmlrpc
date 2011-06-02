Extension { #name : #True }

{ #category : #'*XMLRPC-Server-Core' }
True >> asXMLRPCString [
	"answer a XMLRPC representation of the receiver"
	^ '<value><boolean>1</boolean></value>'
]
