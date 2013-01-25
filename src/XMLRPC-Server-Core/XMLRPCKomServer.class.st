Class {
	#name : #XMLRPCKomServer,
	#superclass : #XMLRPCServer,
	#category : #'XMLRPC-Server-Core'
}

{ #category : #control }
XMLRPCKomServer >> createServer [
	| assembly |
	
		
	
	assembly := ModuleAssembly core.

	modules keysAndValuesDo: [
		:key :value | 
		assembly alias: key to: [
			assembly addPlug: [
					:request | 	
					HttpResponse fromMIMEDocument: (MIMEDocument contentType: 'text/xml' content: (value process: request))
					
			]
		].
		
	].
		
	server := HttpService on: port.
	server plug: assembly rootModule.
	

]

{ #category : #control }
XMLRPCKomServer >> stop [
	server ifNotNil: [
		server unregister.
		server := nil
	].
]
