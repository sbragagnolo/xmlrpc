Extension { #name : #False }

{ #category : #'*xmlrpc-server' }
False >> asXMLRPCString [
	"answer a XMLRPC representation of the receiver"
	^ '<value><boolean>0</boolean></value>'
]
