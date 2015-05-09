Class {
	#name : #XMLRPCServerForTest,
	#superclass : #Object,
	#instVars : [
		'server'
	],
	#category : #'XMLRPC-Server-Tests'
}

{ #category : #'services callbacks' }
XMLRPCServerForTest >> arrayOfStructsTest: aCollection [ 
	| ret |
	ret := 0.
	aCollection first	do: [:each | ret := ret
								+ (each at: 'curly')].
	^ ret
]

{ #category : #'services callbacks' }
XMLRPCServerForTest >> countTheEntities: aCollection [ 
	| ret string |
	ret := Dictionary new.
	string := aCollection first.
	ret
		at: 'ctLeftAngleBrackets'
		put: (string occurrencesOf: $<).
	ret
		at: 'ctRightAngleBrackets'
		put: (string occurrencesOf: $>).
	ret
		at: 'ctAmpersands'
		put: (string occurrencesOf: $&).
	ret
		at: 'ctApostrophes'
		put: (string occurrencesOf: $').
	ret
		at: 'ctQuotes'
		put: (string occurrencesOf: $").
	^ ret
]

{ #category : #'services callbacks' }
XMLRPCServerForTest >> easyStructTest: aCollection [
	| ret |
	ret := 0. aCollection first valuesDo: [ :each | ret := ret + each ].
	^ret
]

{ #category : #'services callbacks' }
XMLRPCServerForTest >> echo: aValue [

   ^aValue
]

{ #category : #'services callbacks' }
XMLRPCServerForTest >> echoStructTest: aDictionary [ 

	^ aDictionary
]

{ #category : #'services callbacks' }
XMLRPCServerForTest >> manyTypesTest: aCollection [
    "simply return the decoded values in aCollection encoded"
	| arr x | 
	x := 1.
	arr := Array new: 6.
	aCollection do: [ :each | arr at: x put: each. x := x+1].
	^arr 
]

{ #category : #'services callbacks' }
XMLRPCServerForTest >> moderateSizeArrayCheck: aCollection [ 
	| arr |
	arr := aCollection first.
	^ (arr first), (arr last)
]

{ #category : #'services callbacks' }
XMLRPCServerForTest >> nestedStructTest: aCollection [
	| struct ret |
	struct := aCollection first.
	ret := 0.
	(((struct at: '2000') at: '04') at: '01') valuesDo: [ :each | ret := ret + each].
	^ ret
]

{ #category : #services }
XMLRPCServerForTest >> services [
	^ {
		'validator1.arrayOfStructsTest' -> { self-> #arrayOfStructsTest:}.
		'validator1.countTheEntities'  ->  { self ->  #countTheEntities:}.
		'validator1.echoStructTest'  ->  { self ->  #echoStructTest:}.
		'validator1.easyStructTest'  ->  { self  ->  #easyStructTest:}.
		'validator1.moderateSizeArrayCheck'  ->  { self ->  #moderateSizeArrayCheck:}.
		'validator1.nestedStructTest'  ->  { self ->  #nestedStructTest:}.
		'validator1.simpleStructReturnTest'  ->  { self ->  #simpleStructReturnTest:}.
		'validator1.manyTypesTest'  ->  { self ->  #manyTypesTest: }.	
		'echo.echoArray' -> { self-> #echo:}.
		'echo.echoBinary' 	-> { self-> #echo: }. 
		'echo.echoBoolean' 	-> { self-> #echo: }. 
		'echo.echoDateTime' 	-> { self-> #echo: }. 
		'echo.echoDouble' 	-> { self-> #echo: }. 
		'echo.echoInt' 		-> { self-> #echo: }. 
		'echo.echoString' 	-> { self-> #echo: }. 
		'echo.echoStruct' 	-> { self-> #echo: }.
	} asXMLRPCHttpModule
]

{ #category : #'services callbacks' }
XMLRPCServerForTest >> simpleStructReturnTest: aCollection [ 
	| num dict |
	dict := Dictionary new.
	num := aCollection first.
	dict at: 'times10' put: num * 10;
		 at: 'times100' put: num * 100;
		 at: 'times1000' put: num * 1000.
	^ dict
]

{ #category : #running }
XMLRPCServerForTest >> start [
	^ self startOn: 8081
]

{ #category : #running }
XMLRPCServerForTest >> startOn: aPortNumber [
	server := XMLRPCServer startOn: aPortNumber with: self services 
	
]

{ #category : #running }
XMLRPCServerForTest >> stop [
	server destroy

]
