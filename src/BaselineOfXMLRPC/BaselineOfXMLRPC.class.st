Class {
	#name : #BaselineOfXMLRPC,
	#superclass : #BaselineOf,
	#category : #BaselineOfXMLRPC
}

{ #category : #baselines }
BaselineOfXMLRPC >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "use the up-to-date XMLParser project"
			self xmlparser: spec.
			self pragmatic: spec.
			spec
				package: 'XMLRPC-Client-Core'
					with: [ spec requires: #('XMLParser') ];
				package: 'XMLRPC-Client-Tests'
					with: [ spec
						requires: 'XMLRPC-Client-Core';
						requires: 'XMLRPC-Server-Core' ];
				package: 'XMLRPC-Server-Core'
					with: [ spec requires: 'XMLRPC-Client-Core' ];
				package: 'XMLRPC-Server-Tests'
					with: [ spec requires: 'XMLRPC-Server-Core' ].
			spec
				group: 'default' with: 'Client';
				group: 'All'
					with:
					#('XMLRPC-Client-Core' 'XMLRPC-Client-Tests' 'XMLRPC-Server-Core' 'XMLRPC-Server-Tests');
				group: 'Client' with: #('XMLRPC-Client-Core' Pragmatic);
				group: 'Client with Tests'
					with: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests');
				group: 'Server' with: #('XMLRPC-Server-Core' Pragmatic);
				group: 'Server with Tests'
					with: #('XMLRPC-Server-Core' 'XMLRPC-Server-Tests') ]
]

{ #category : #baselines }
BaselineOfXMLRPC >> pragmatic: spec [
	spec
		baseline: 'Pragmatic'
		with: [ spec repository: 'github://sbragagnolo/Pragmatic' ]
]

{ #category : #baselines }
BaselineOfXMLRPC >> xmlparser: spec [
	spec
		project: 'XMLParser'
		with: [ spec
				className: 'ConfigurationOfXMLParser';
				versionString: #stable;
				repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main' ]
]
