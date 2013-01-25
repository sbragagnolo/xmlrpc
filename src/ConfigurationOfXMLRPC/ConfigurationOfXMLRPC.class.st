Class {
	#name : #ConfigurationOfXMLRPC,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfXMLRPC
}

{ #category : #private }
ConfigurationOfXMLRPC class >> bootstrapPackage: aString from: aPath [ 
	| repository version |
	repository := MCHttpRepository
				location: aPath
				user: ''
				password: ''.
	repository
		versionReaderForFileNamed: aString , '.mcz'
		do: [:reader | 
			version := reader version.
			version load.
			version workingCopy repositoryGroup addRepository: repository]
]

{ #category : #'metacello tool support' }
ConfigurationOfXMLRPC class >> configurationOfLog [
	<logConfiguration>
	^ [
	     :builder |
	     builder forClass: LoggedExampleCustomized 
			     useLevel:#warn 
			     showingLogAs: ('%tag #%class >> %selector [%log]' asPatternFormatter) 
			     into: LogStdoutWriter instance.
	].

]

{ #category : #private }
ConfigurationOfXMLRPC class >> ensureMetacello [
	"Bootstrap Gofer (if necessary), load latest mcz file for ConfigurationOfMetacello (using old 
	 Gofer API), then load the latest version of Metacello itself."

	Smalltalk at: #MetacelloProject ifAbsent: [ | error |
		"list of repositories to try, in case primary repository is not accessible"
		(Array 
			with: 'http://www.squeaksource.com/MetacelloRepository' 
			with: 'http://seaside.gemstone.com/ss/metacello') do: [:repositoryUrl |
				([
					Smalltalk at: #Gofer ifAbsent: [
					"Current version of Gofer from which to bootstrap - as of 1.0-beta.21"
						self bootstrapPackage: 'Gofer-Core-lr.115' from: repositoryUrl ].
					Smalltalk at: #Gofer ifPresent: [:goferClass | | gofer |
						gofer := goferClass new
							url: repositoryUrl;
							yourself.
						[ gofer addPackage: 'ConfigurationOfMetacello' ] on: Warning do: [:ex | ex resume ].
						gofer load ]]
							on: Error
							do: [ :ex |
								error := ex.
								Transcript 
									cr; 
									show: 'failed ensureMetacello: ';
									show: ex description printString;
									show: '...retrying'.
								"try again"
								ex return: nil ]) ~~ nil
					ifTrue: [
						"load 'default' group of Metacello"
						(Smalltalk at: #ConfigurationOfMetacello) perform: #load.
						^self ]].
		"shouldn't get here unless the load failed ... throw an error"
		self error: 'retry with alternate repository failed: ', error description printString ]
]

{ #category : #'metacello tool support' }
ConfigurationOfXMLRPC class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfXMLRPC class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #loading }
ConfigurationOfXMLRPC class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #'metacello tool support' }
ConfigurationOfXMLRPC class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfXMLRPC class >> project [

	^self new project
]

{ #category : #'unloading Metacello' }
ConfigurationOfXMLRPC class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #baselines }
ConfigurationOfXMLRPC >> baseline10alpha1: spec [ 
	<version: '1.0-alpha1-baseline'>
	
spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/XMLRPC'. 

		spec
			project: 'XMLSupport' with: [
				spec
					className: 'ConfigurationOfXMLSupport';
					versionString: '1.0.2';
					file: 'ConfigurationOfXMLSupport';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].		

	spec
		  project: 'Kom' with: [
				spec
					className: 'ConfigurationOfKomHttpServer';
					versionString: '1.0.4';
					file: 'ConfigurationOfKomHttpServer';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
			
		spec 
			package: 'XMLRPC-Client-Core' with: [spec requires: #('XMLSupport' 'Kom') ];
			package: 'XMLRPC-Client-Tests' with: [ spec requires: 'XMLRPC-Client-Core' ];
			package: 'XMLRPC-Server-Core' with: [ spec requires: 'XMLRPC-Client-Core' ]; 
			package: 'XMLRPC-Server-Tests' with: [ spec requires: 'XMLRPC-Server-Core'].

		spec
	 		group: 'default' with: 'XMLRPC-Client-Core';	
			group: 'All' with: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests' 'XMLRPC-Server-Core' 'XMLRPC-Server-Tests');
			group: 'Client' with: #('XMLRPC-Client-Core');
			group: 'Client with Tests' with: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests');
			group: 'Server' with: #('XMLRPC-Server-Core');
			group: 'Server with Tests' with: #('XMLRPC-Server-Core' 'XMLRPC-Server-Tests').
].
]

{ #category : #baselines }
ConfigurationOfXMLRPC >> baseline11alpha1: spec [ 
	<version: '1.1-alpha1-baseline'>
	
spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/XMLRPC'. 

		spec
			project: 'XMLSupport' with: [
				spec
					className: 'ConfigurationOfXMLSupport';
					versionString: '1.1.7';
					file: 'ConfigurationOfXMLSupport';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].		

	spec
		  project: 'Kom' with: [
				spec
					className: 'ConfigurationOfKomHttpServer';
					versionString: '1.0.7';
					file: 'ConfigurationOfKomHttpServer';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
			
		spec 
			package: 'XMLRPC-Client-Core' with: [spec requires: #('XMLSupport' 'Kom') ];
			package: 'XMLRPC-Client-Tests' with: [ spec requires: 'XMLRPC-Client-Core' ];
			package: 'XMLRPC-Server-Core' with: [ spec requires: 'XMLRPC-Client-Core' ]; 
			package: 'XMLRPC-Server-Tests' with: [ spec requires: 'XMLRPC-Server-Core'].

		spec
	 		group: 'default' with: 'XMLRPC-Client-Core';	
			group: 'All' with: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests' 'XMLRPC-Server-Core' 'XMLRPC-Server-Tests');
			group: 'Client' with: #('XMLRPC-Client-Core');
			group: 'Client with Tests' with: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests');
			group: 'Server' with: #('XMLRPC-Server-Core');
			group: 'Server with Tests' with: #('XMLRPC-Server-Core' 'XMLRPC-Server-Tests').
].
]

{ #category : #baselines }
ConfigurationOfXMLRPC >> baseline12alpha1: spec [ 
	<version: '1.2-alpha1-baseline'>
	
spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/XMLRPC'. 

		spec
			project: 'XMLSupport' with: [
				spec
					className: 'ConfigurationOfXMLSupport';
					versionString: '1.1.7';
					file: 'ConfigurationOfXMLSupport';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].		

	spec
		  project: 'Kom' with: [
				spec
					className: 'ConfigurationOfKomHttpServer';
					versionString: '1.0.8';
					file: 'ConfigurationOfKomHttpServer';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
			
		spec 
			package: 'XMLRPC-Client-Core' with: [spec requires: #('XMLSupport' 'Kom') ];
			package: 'XMLRPC-Client-Tests' with: [ spec requires: 'XMLRPC-Client-Core' ];
			package: 'XMLRPC-Server-Core' with: [ spec requires: 'XMLRPC-Client-Core' ]; 
			package: 'XMLRPC-Server-Tests' with: [ spec requires: 'XMLRPC-Server-Core'].

		spec
	 		group: 'default' with: 'XMLRPC-Client-Core';	
			group: 'All' with: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests' 'XMLRPC-Server-Core' 'XMLRPC-Server-Tests');
			group: 'Client' with: #('XMLRPC-Client-Core');
			group: 'Client with Tests' with: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests');
			group: 'Server' with: #('XMLRPC-Server-Core');
			group: 'Server with Tests' with: #('XMLRPC-Server-Core' 'XMLRPC-Server-Tests').
].
]

{ #category : #baselines }
ConfigurationOfXMLRPC >> baseline13beta2: spec [ 
	<version: '1.3-beta2-baseline'>
	
spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/XMLRPC'. 

		spec
			project: 'XMLSupport' with: [
				spec
					className: 'ConfigurationOfXMLSupport';
					versionString: '1.2.0';
					file: 'ConfigurationOfXMLSupport';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].		

	spec
		  project: 'Kom' with: [
				spec
					className: 'ConfigurationOfKomHttpServer';
					versionString: '1.0.9';
					file: 'ConfigurationOfKomHttpServer';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
			
		spec 
			package: 'XMLRPC-Client-Core' with: [spec requires: #('XMLSupport' 'Kom') ];
			package: 'XMLRPC-Client-Tests' with: [ spec requires: 'XMLRPC-Client-Core' ];
			package: 'XMLRPC-Server-Core' with: [ spec requires: 'XMLRPC-Client-Core' ]; 
			package: 'XMLRPC-Server-Tests' with: [ spec requires: 'XMLRPC-Server-Core'].

		spec
	 		group: 'default' with: 'XMLRPC-Client-Core';	
			group: 'All' with: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests' 'XMLRPC-Server-Core' 'XMLRPC-Server-Tests');
			group: 'Client' with: #('XMLRPC-Client-Core');
			group: 'Client with Tests' with: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests');
			group: 'Server' with: #('XMLRPC-Server-Core');
			group: 'Server with Tests' with: #('XMLRPC-Server-Core' 'XMLRPC-Server-Tests').
].
]

{ #category : #baselines }
ConfigurationOfXMLRPC >> baseline13beta3: spec [ 
	<version: '1.3-beta3-baseline'>
	
spec for: #common do: [
	spec blessing: #baseline.
	spec repository: 'http://ss3.gemstone.com/ss/XMLRPC'. 

	spec project: 'XMLSupport' with: [
				spec 	className: 'ConfigurationOfXMLSupport';
						versionString: '1.2.1';
						file: 'ConfigurationOfXMLSupport';
						repository: 'http://www.squeaksource.com/MetacelloRepository' 
	].		

	spec project: 'Kom' with: [
				spec	className: 'ConfigurationOfKomHttpServer';
						versionString: '1.0.9';
						file: 'ConfigurationOfKomHttpServer';
						repository: 'http://www.squeaksource.com/MetacelloRepository' 
	].

	" logger framework "
	spec project: 'PaulLePoulpe' with: [ 
				spec 	className: 'ConfigurationOfPaulLePoulpe'; 
						loads: #('default' );
						file: 'ConfigurationOfPaulLePoulpe';
						repository: 'http://ss3.gemstone.com/ss/PaulLePoulpe'. 
	].

			
	spec 	package: 'XMLRPC-Client-Core' with: [spec requires: #('XMLSupport' 'Kom' 'PaulLePoulpe') ];
			package: 'XMLRPC-Client-Tests' with: [ spec requires: 'XMLRPC-Client-Core' ];
			package: 'XMLRPC-Server-Core' with: [ spec requires: 'XMLRPC-Client-Core' ]; 
			package: 'XMLRPC-Server-Tests' with: [ spec requires: 'XMLRPC-Server-Core'].

	spec	group: 'default' with: 'XMLRPC-Client-Core';	
			group: 'All' with: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests' 'XMLRPC-Server-Core' 'XMLRPC-Server-Tests');
			group: 'Client' with: #('XMLRPC-Client-Core');
			group: 'Client with Tests' with: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests');
			group: 'Server' with: #('XMLRPC-Server-Core');
			group: 'Server with Tests' with: #('XMLRPC-Server-Core' 'XMLRPC-Server-Tests').

].
]

{ #category : #baselines }
ConfigurationOfXMLRPC >> baseline13beta5: spec [ 
	<version: '1.3-beta3-baseline'>
	
spec for: #common do: [
	spec blessing: #baseline.
	spec repository: 'http://ss3.gemstone.com/ss/XMLRPC'. 

	spec project: 'XMLSupport' with: [
				spec 	className: 'ConfigurationOfXMLSupport';
						versionString: '1.2.1';
						file: 'ConfigurationOfXMLSupport';
						repository: 'http://www.squeaksource.com/MetacelloRepository' 
	].		

	spec project: 'Kom' with: [
				spec	className: 'ConfigurationOfKomHttpServer';
						versionString: '1.0.9';
						file: 'ConfigurationOfKomHttpServer';
						repository: 'http://www.squeaksource.com/MetacelloRepository' 
	].
			
	spec 	package: 'XMLRPC-Client-Core' with: [spec requires: #('XMLSupport' 'Kom' 'PaulLePoulpe') ];
			package: 'XMLRPC-Client-Tests' with: [ spec requires: 'XMLRPC-Client-Core' ];
			package: 'XMLRPC-Server-Core' with: [ spec requires: 'XMLRPC-Client-Core' ]; 
			package: 'XMLRPC-Server-Tests' with: [ spec requires: 'XMLRPC-Server-Core'].

	spec	group: 'default' with: 'XMLRPC-Client-Core';	
			group: 'All' with: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests' 'XMLRPC-Server-Core' 'XMLRPC-Server-Tests');
			group: 'Client' with: #('XMLRPC-Client-Core');
			group: 'Client with Tests' with: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests');
			group: 'Server' with: #('XMLRPC-Server-Core');
			group: 'Server with Tests' with: #('XMLRPC-Server-Core' 'XMLRPC-Server-Tests').

].
]

{ #category : #accessing }
ConfigurationOfXMLRPC >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfXMLRPC >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.0-Beta3'.

]

{ #category : #versions }
ConfigurationOfXMLRPC >> version100Beta1: spec [ 
	<version: '1.0-Beta1' imports: #('1.2-alpha1-baseline') >
	
	spec for: #common do: [
		spec blessing: #alpha.
		spec author: 'GermanArduino'.
		spec timestamp: '09/23/2010 16:00'.
		spec 
			project: 'XMLSupport' with: '1.1.7';
			project: 'Kom' with: '1.0.8'.
		spec
			package: 'XMLRPC-Client-Core' with: 'XMLRPC-Client-Core-GermanArduino.20';
			package: 'XMLRPC-Client-Tests' with: 'XMLRPC-Client-Tests-GermanArduino.11';
			package: 'XMLRPC-Server-Core' with: 'XMLRPC-Server-Core-GermanArduino.10';
			package: 'XMLRPC-Server-Tests' with: 'XMLRPC-Server-Tests-GermanArduino.5'.].
]

{ #category : #versions }
ConfigurationOfXMLRPC >> version100Beta2: spec [ 
	<version: '1.0-Beta2' imports: #('1.3-beta2-baseline') >
	
	spec for: #common do: [
		spec blessing: #beta.
		spec author: 'GermanArduino'.
		spec timestamp: '08/18/2011 18:00'.
		spec 
			project: 'XMLSupport' with: '1.2.0';
			project: 'Kom' with: '1.0.9'.
		spec
			package: 'XMLRPC-Client-Core' with: 'XMLRPC-Client-Core-GermanArduino.20';
			package: 'XMLRPC-Client-Tests' with: 'XMLRPC-Client-Tests-GermanArduino.11';
			package: 'XMLRPC-Server-Core' with: 'XMLRPC-Server-Core-GermanArduino.12';
			package: 'XMLRPC-Server-Tests' with: 'XMLRPC-Server-Tests-GermanArduino.5'.].
]

{ #category : #versions }
ConfigurationOfXMLRPC >> version100Beta3: spec [ 
	<version: '1.0-Beta3' imports: #('1.3-beta3-baseline') >
	
	spec for: #common do: [
		spec blessing: #beta.
		spec author: 'GermanArduino'.
		spec timestamp: '06/03/2012 18:00'.
		spec 
			project: 'XMLSupport' with: '1.2.1';
			project: 'Kom' with: '1.0.9'.
		spec
			package: 'XMLRPC-Client-Core' with: 'XMLRPC-Client-Core-GermanArduino.21';
			package: 'XMLRPC-Client-Tests' with: 'XMLRPC-Client-Tests-GermanArduino.12';
			package: 'XMLRPC-Server-Core' with: 'XMLRPC-Server-Core-GermanArduino.11';
			package: 'XMLRPC-Server-Tests' with: 'XMLRPC-Server-Tests-GermanArduino.6'.].
]

{ #category : #versions }
ConfigurationOfXMLRPC >> version100Beta4: spec [ 
	<version: '1.0-Beta4' imports: #('1.3-beta3-baseline') >
	
	spec for: #common do: [
		spec blessing: #beta.
		spec author: 'GermanArduino'.
		spec timestamp: '06/03/2012 18:00'.
		spec 
			project: 'XMLSupport' with: '1.2.1';
			project: 'Kom' with: '1.0.9'.
		spec
			package: 'XMLRPC-Client-Core' with: 'XMLRPC-Client-Core-GermanArduino.23';
			package: 'XMLRPC-Client-Tests' with: 'XMLRPC-Client-Tests-GermanArduino.12';
			package: 'XMLRPC-Server-Core' with: 'XMLRPC-Server-Core-GermanArduino.11';
			package: 'XMLRPC-Server-Tests' with: 'XMLRPC-Server-Tests-GermanArduino.6'.].
]

{ #category : #versions }
ConfigurationOfXMLRPC >> version100Beta5: spec [ 
	<version: '1.0-Beta5' imports: #('1.3-beta5-baseline') >
	
	spec for: #common do: [
		spec blessing: #beta.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '25/01/2013 12:30'.
		spec 
			project: 'XMLSupport' with: '1.2.1';
			project: 'Kom' with: '1.0.9'.
		spec
			package: 'XMLRPC-Client-Core' with: ' XMLRPC-Client-Core-SantiagoBragagnolo.30';
			package: 'XMLRPC-Client-Tests' with: 'XMLRPC-Client-Tests-SantiagoBragagnolo.14';
			package: 'XMLRPC-Server-Core' with: 'XMLRPC-Server-Core-SantiagoBragagnolo.17';
			package: 'XMLRPC-Server-Tests' with: 'XMLRPC-Server-Tests-SantiagoBragagnolo.9'.].
]

{ #category : #versions }
ConfigurationOfXMLRPC >> version100alpha1: spec [ 
	<version: '1.0-alpha1' imports: #('1.0-alpha1-baseline') >
	
	spec for: #common do: [
		spec blessing: #alpha.
		spec author: 'GermanArduino'.
		spec timestamp: '091/23/2010 16:00'.
		spec 
			project: 'XMLSupport' with: '1.0.2';
			project: 'Kom' with: '1.0.4'.
		spec
			package: 'XMLRPC-Client-Core' with: 'XMLRPC-Client-Core-GermanArduino.11';
			package: 'XMLRPC-Client-Tests' with: 'XMLRPC-Client-Tests-GermanArduino.3';
			package: 'XMLRPC-Server-Core' with: 'XMLRPC-Server-Core-GermanArduino.1';
			package: 'XMLRPC-Server-Tests' with: 'XMLRPC-Server-Tests-GermanArduino.1'.].
]

{ #category : #versions }
ConfigurationOfXMLRPC >> version100alpha2: spec [ 
	<version: '1.0-alpha2' imports: #('1.1-alpha1-baseline') >
	
	spec for: #common do: [
		spec blessing: #alpha.
		spec author: 'GermanArduino'.
		spec timestamp: '091/23/2010 16:00'.
		spec 
			project: 'XMLSupport' with: '1.1.7';
			project: 'Kom' with: '1.0.7'.
		spec
			package: 'XMLRPC-Client-Core' with: 'XMLRPC-Client-Core-GermanArduino.11';
			package: 'XMLRPC-Client-Tests' with: 'XMLRPC-Client-Tests-GermanArduino.3';
			package: 'XMLRPC-Server-Core' with: 'XMLRPC-Server-Core-GermanArduino.1';
			package: 'XMLRPC-Server-Tests' with: 'XMLRPC-Server-Tests-GermanArduino.1'.].
]

{ #category : #versions }
ConfigurationOfXMLRPC >> version100alpha3: spec [ 
	<version: '1.0-alpha3' imports: #('1.2-alpha1-baseline') >
	
	spec for: #common do: [
		spec blessing: #alpha.
		spec author: 'GermanArduino'.
		spec timestamp: '091/23/2010 16:00'.
		spec 
			project: 'XMLSupport' with: '1.1.7';
			project: 'Kom' with: '1.0.8'.
		spec
			package: 'XMLRPC-Client-Core' with: 'XMLRPC-Client-Core-GermanArduino.11';
			package: 'XMLRPC-Client-Tests' with: 'XMLRPC-Client-Tests-GermanArduino.3';
			package: 'XMLRPC-Server-Core' with: 'XMLRPC-Server-Core-GermanArduino.1';
			package: 'XMLRPC-Server-Tests' with: 'XMLRPC-Server-Tests-GermanArduino.1'.].
]

{ #category : #versions }
ConfigurationOfXMLRPC >> version100alpha4: spec [ 
	<version: '1.0-alpha4' imports: #('1.2-alpha1-baseline') >
	
	spec for: #common do: [
		spec blessing: #alpha.
		spec author: 'GermanArduino'.
		spec timestamp: '09/23/2010 16:00'.
		spec 
			project: 'XMLSupport' with: '1.1.7';
			project: 'Kom' with: '1.0.8'.
		spec
			package: 'XMLRPC-Client-Core' with: 'XMLRPC-Client-Core-GermanArduino.14';
			package: 'XMLRPC-Client-Tests' with: 'XMLRPC-Client-Tests-GermanArduino.5';
			package: 'XMLRPC-Server-Core' with: 'XMLRPC-Server-Core-GermanArduino.7';
			package: 'XMLRPC-Server-Tests' with: 'XMLRPC-Server-Tests-GermanArduino.1'.].
]

{ #category : #'as yet unclassified' }
ConfigurationOfXMLRPC >> workspace [
"
This is the Metacello Configuration of XMLRPC for Pharo / Squeak.
You can install one of several versions in the image where this configuration is loaded.
But first, you need to install this configuration.
"

"Install ConfigurationOfXMLRPC"

"Pharo"
(Smalltalk at: #Gofer) new
	squeaksource: 'MetacelloRepository';
	package: 'ConfigurationOfXMLRPC';
	load.
	
"Squeak"
"	(Installer squeaksource
		project: 'MetacelloRepository';
		packagesMatching: 'ConfigurationOfXMLRPC') first install"

"Load XMLRPC"

"
XMLRPC can be installed as the Client only (alone or with tests) and with Server component (also alone or with tests).
"

"If you want the latest released version of XMLRPC, evaluate (by default the Client level is loaded)"
ConfigurationOfXMLRPC project latestVersion load.

"This is equivalent to evaluate"
ConfigurationOfXMLRPC project latestVersion load: 'Client'.

"If you want the Client and Tests, then evaluate"
ConfigurationOfXMLRPC project latestVersion load: 'Client with Tests'.

"If you want the Server (it requires the Client), evaluate"
ConfigurationOfXMLRPC project latestVersion load: 'Server'.

"If you want the Server (it requires the Client) and Tests, evaluate"
ConfigurationOfXMLRPC project latestVersion load: 'Server with Tests'.

"Or if you want ALL the packages, evaluate"
ConfigurationOfXMLRPC project latestVersion load: 'All'.

"But you can also load any version, not only the latest released version.
To install for example version 1.0.1, you'll evaluate one of:"

(ConfigurationOfXMLRPC project version: '1.0-alpha1') load: 'Client'.
(ConfigurationOfXMLRPC project version: '1.0-alpha1') load: 'Client with Tests'.
(ConfigurationOfXMLRPC project version: '1.0-alpha1') load: 'Server'.
(ConfigurationOfXMLRPC project version: '1.0-alpha1') load: 'Server with Tests'.
(ConfigurationOfXMLRPC project version: '1.0-alpha1') load: 'All'.

"The two last are equivalents"


"Upgrading ConfigurationOfXMLRPC"
"If you have an image with ConfigurationOfXMLRPC already loaded, and you want to use a version of XMLRPC that exists only in the newest ConfigurationOfXMLRPC package, you don't need to install ConfigurationOfXMLRPC as stated at the beginning, you can upgrade your current ConfigurationOfXMLRPC to the latest version with:"
ConfigurationOfXMLRPC project updateProject.

"And then install a new version as explained before"

"
Enjoy!
"







]
