Extension { #name : #SmallInteger }

{ #category : #'*xmlrpc-server' }
SmallInteger >> asXMLRPCString [
	"answer a XMLRPC representation of the receiver"
	| w |
	w _ WriteStream on: (String new: 50).
	w nextPutAll: '<value><i4>'; nextPutAll: self asString; nextPutAll: '</i4></value>'.
	^ w contents
]
