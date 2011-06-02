Extension { #name : #False }

{ #category : #'*XMLRPC-Server-Core' }
False >> asXMLRPCString [
	"answer a XMLRPC representation of the receiver"

	^ '<value><boolean>0</boolean></value>'
]
