Extension { #name : #True }

{ #category : #'*xmlrpc-server' }
True >> asXMLRPCString [
	"answer a XMLRPC representation of the receiver"
	^ '<value><boolean>1</boolean></value>
'
]
