Extension { #name : #SequenceableCollection }

{ #category : #'*XMLRPC-Server-Core' }
SequenceableCollection >> asXMLRPCString [
	"answer a XMLRPC representation of the receiver"
	| w |
	w := WriteStream on: (String new: 200).
	w nextPutAll: '<value><array><data>'.
	self
		do: [:each | w nextPutAll: each asXMLRPCString].
	w nextPutAll: '</data></array></value>'.
	^ w contents
]
