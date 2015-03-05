"
A PhaROSSystemLauncher is facade for executing ros commands in the host machine
"
Class {
	#name : #ROSSystemLauncher,
	#superclass : #Object,
	#instVars : [
		'masterProcess',
		'turtleProcess',
		'gmappingProcess'
	],
	#classInstVars : [
		'instance',
		'distro'
	],
	#category : #'ROSDDS-Commandline'
}

{ #category : #'as yet unclassified' }
ROSSystemLauncher class >> distro: aDistroSymbol [
	distro := aDistroSymbol
]

{ #category : #'as yet unclassified' }
ROSSystemLauncher class >> fuerte [
	^'/opt/ros/fuerte/bin/'
]

{ #category : #'as yet unclassified' }
ROSSystemLauncher class >> groovy [
	^'/opt/ros/groovy/bin/'
]

{ #category : #'as yet unclassified' }
ROSSystemLauncher class >> hydro [
	^ '/opt/ros/hydro/bin/'
]

{ #category : #'as yet unclassified' }
ROSSystemLauncher class >> indigo [
	^'/opt/ros/indigo/bin/'
]

{ #category : #'as yet unclassified' }
ROSSystemLauncher class >> initialize [
	super initialize.
	distro := #indigo.
]

{ #category : #'as yet unclassified' }
ROSSystemLauncher class >> instance [
	^ instance ifNil: [
		instance := super new.	
	]
]

{ #category : #'as yet unclassified' }
ROSSystemLauncher class >> new [
	self error: 'This is a singleton object, use instance instead of new'.
]

{ #category : #'as yet unclassified' }
ROSSystemLauncher class >> path: aCommand [
	^ (distro value: self) , '/', aCommand 
]

{ #category : #'as yet unclassified' }
ROSSystemLauncher >> catkinFind: anArray [
	^ self catkinFind: anArray tmpFile: anArray hash asString.
]

{ #category : #'as yet unclassified' }
ROSSystemLauncher >> catkinFind: anArrayOfArguments tmpFile: aTempFileName [
	| rosmsg outstream errstream return |
	outstream := StandardFileStream forceNewFileNamed: '/tmp/' , aTempFileName , '.tmp'.
	errstream := StandardFileStream forceNewFileNamed: '/tmp/error_' , aTempFileName , '.tmp'.
	rosmsg := ExternalUnixOSProcess
		forkAndExec: (ROSSystemLauncher path: 'catkin_find')
		arguments: anArrayOfArguments
		environment: nil
		descriptors:
			{(FileStream stdin).
			outstream.
			errstream}.
	[ rosmsg isComplete not ] whileTrue: [ (Delay forMilliseconds: 100) wait ].
	rosmsg succeeded
		ifTrue: [ 
			return := outstream
				reset;
				upToEnd.
			outstream close.
			errstream close ]
		ifFalse: [ 
			Error
				signal:
					'Error discovering service type. Is this process running in a ROS environment?'
						,
							(errstream
								reset;
								upToEnd).
			outstream close.
			errstream close ].
	^ return
]

{ #category : #'as yet unclassified' }
ROSSystemLauncher >> catkinfindNodeDirectories: aPackageName [
	^ self
		catkinFind:
			{'--without-underlays'.
			'--libexec'.
			'--share'.
			aPackageName}
]

{ #category : #types }
ROSSystemLauncher >> rosMsg: aCommand [
	^ self rosMsg: {aCommand} tmpFile: aCommand
]

{ #category : #types }
ROSSystemLauncher >> rosMsg: anArrayOfArguments tmpFile: aTempFileName [
	| rosmsg outstream errstream return |
	outstream := StandardFileStream forceNewFileNamed: '/tmp/' , aTempFileName , '.tmp'.
	errstream := StandardFileStream forceNewFileNamed: '/tmp/error_' , aTempFileName , '.tmp'.
	rosmsg := ExternalUnixOSProcess
		forkAndExec: (ROSSystemLauncher path: 'rosmsg')
		arguments: anArrayOfArguments
		environment: nil
		descriptors:
			{(FileStream stdin).
			outstream.
			errstream}.
	[ rosmsg isComplete not ] whileTrue: [ (Delay forMilliseconds: 100) wait ].
	rosmsg succeeded
		ifTrue: [ 
			return := outstream
				reset;
				upToEnd.
			outstream close.
			errstream close ]
		ifFalse: [ 
			Error
				signal:
					'Error discovering type. Is this process running in a ROS environment?'
						,
							(errstream
								reset;
								upToEnd).
			outstream close.
			errstream close ].
	^ return
]

{ #category : #types }
ROSSystemLauncher >> rosMsg: aCommand with: aTypeId [
	^ self
		rosMsg:
			{aCommand.
			aTypeId}
		tmpFile: (aTypeId copyReplaceAll: '/' with: '_')
]

{ #category : #types }
ROSSystemLauncher >> rosMsgMd5: aTypeId [
	^ (self rosMsg: 'md5' with: aTypeId) copyReplaceAll: String lf with: ''
]

{ #category : #types }
ROSSystemLauncher >> rosMsgShow: aTypeId [
	^ self rosMsg: 'show' with: aTypeId
]

{ #category : #'as yet unclassified' }
ROSSystemLauncher >> rosPackage: aCommand [
	^ self rosPackage: {aCommand} tmpFile: aCommand
]

{ #category : #'as yet unclassified' }
ROSSystemLauncher >> rosPackage: anArrayOfArguments tmpFile: aTempFileName [
	| rosmsg outstream errstream return |
	outstream := StandardFileStream forceNewFileNamed: '/tmp/' , aTempFileName , '.tmp'.
	errstream := StandardFileStream forceNewFileNamed: '/tmp/error_' , aTempFileName , '.tmp'.
	rosmsg := ExternalUnixOSProcess
		forkAndExec: (ROSSystemLauncher path: 'rospack')
		arguments: anArrayOfArguments
		environment: nil
		descriptors:
			{(FileStream stdin).
			outstream.
			errstream}.
	[ rosmsg isComplete not ] whileTrue: [ (Delay forMilliseconds: 100) wait ].
	rosmsg succeeded
		ifTrue: [ 
			return := outstream
				reset;
				upToEnd.
			outstream close.
			errstream close ]
		ifFalse: [ 
			Error
				signal:
					'Error discovering service type. Is this process running in a ROS environment?'
						,
							(errstream
								reset;
								upToEnd).
			outstream close.
			errstream close ].
	^ return
]

{ #category : #types }
ROSSystemLauncher >> rosSrv: aCommand [
	^ self rosSrv: {aCommand} tmpFile: aCommand
]

{ #category : #types }
ROSSystemLauncher >> rosSrv: anArrayOfArguments tmpFile: aTempFileName [
	| rosmsg outstream errstream return |
	outstream := StandardFileStream forceNewFileNamed: '/tmp/' , aTempFileName , '.tmp'.
	errstream := StandardFileStream forceNewFileNamed: '/tmp/error_' , aTempFileName , '.tmp'.
	rosmsg := ExternalUnixOSProcess
		forkAndExec: (ROSSystemLauncher path: 'rossrv')
		arguments: anArrayOfArguments
		environment: nil
		descriptors:
			{(FileStream stdin).
			outstream.
			errstream}.
	[ rosmsg isComplete not ] whileTrue: [ (Delay forMilliseconds: 100) wait ].
	rosmsg succeeded
		ifTrue: [ 
			return := outstream
				reset;
				upToEnd.
			outstream close.
			errstream close ]
		ifFalse: [ 
			Error
				signal:
					'Error discovering service type. Is this process running in a ROS environment?'
						,
							(errstream
								reset;
								upToEnd).
			outstream close.
			errstream close ].
	^ return
]

{ #category : #types }
ROSSystemLauncher >> rosSrv: aCommand with: aTypeId [
	^ self
		rosSrv:
			{aCommand.
			aTypeId}
		tmpFile: (aTypeId copyReplaceAll: '/' with: '_')
]

{ #category : #types }
ROSSystemLauncher >> rosSrvMd5: aTypeId [
	^ self rosSrv: 'md5' with: aTypeId
]

{ #category : #types }
ROSSystemLauncher >> rosSrvShow: aTypeId [
	^ self rosSrv: 'show' with: aTypeId
]

{ #category : #launching }
ROSSystemLauncher >> roslaunch: aConfigurationFile [
	| roslaunch |
	roslaunch := ExternalUnixOSProcess
		forkAndExec: (ROSSystemLauncher path: 'roslaunch')
		arguments: {aConfigurationFile}
		environment: nil
		descriptors:
			{(FileStream stdin).
			(FileStream stdout).
			(FileStream stderr)}.
	roslaunch spinForRos: 50.
	^ roslaunch
]

{ #category : #launching }
ROSSystemLauncher >> roslaunchForTests: aContent [
	| file |
	file := StandardFileStream forceNewFileNamed: '/tmp/content-empty-test.launch'.
	file nextPutAll: aContent.
	file flush.
	file close.
	^ (self roslaunch: '/tmp/content-empty-test.launch') asStickyReference
]

{ #category : #launching }
ROSSystemLauncher >> rosrun: anArrayOfArguments [
	| process |
	process := ExternalUnixOSProcess
		forkAndExec: (ROSSystemLauncher path: 'rosrun')
		arguments: anArrayOfArguments
		environment: nil
		descriptors:
			{(FileStream stdin).
			(FileStream stdout).
			(FileStream stderr)}.
	process spinForRos: 20.
	^ process
]

{ #category : #launching }
ROSSystemLauncher >> rosservice: anArrayOfArguments [
	| process |
	process := ExternalUnixOSProcess
		forkAndExec: (ROSSystemLauncher path: 'rosservice')
		arguments: anArrayOfArguments
		environment: nil
		descriptors:
			{(FileStream stdin).
			(FileStream stdout).
			(FileStream stderr)}.
	process spinForRos: 20.
	^ process
]

{ #category : #launching }
ROSSystemLauncher >> rosserviceCall: anArrayOfArguments [
	^ self rosservice: {'call'} , anArrayOfArguments
]
