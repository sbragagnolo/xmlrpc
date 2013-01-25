Class {
	#name : #XMLRPCStandardEcho,
	#superclass : #Object,
	#category : #'XMLRPC-Server-Tests'
}

{ #category : #'as yet unclassified' }
XMLRPCStandardEcho class >> addTests [
	"XMLRPCStandardEcho addTests"

	XMLRPCServerRequest registerService: 'echo.echoArray' class: self selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoBinary' class: self selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoBoolean' class: self selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoDateTime' class: self  selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoDouble' class: self selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoInt' class: self selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoString' class: self selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoStruct' class: self selector: #echo:
]

{ #category : #'as yet unclassified' }
XMLRPCStandardEcho class >> echo: aValue [

   ^aValue first
]
