#Include "Protheus.CH" 

/*
Data				- 11/05/2015
Autor				- Andre Costa
Descri��o		- O PE FI040ROT inclui novos itens no menu aRotina.
Observa��es		- Est� presente na fun��o MenuDef()
Par�metros		- (ParamIxb) = Recebe um array aRotina com o menu padr�o e adiciona novos itens ao menu
Retorno			- Retorna um array aRotina com o(s) novo(s) itens do menu que foram adicionados.
Programa Fonte	- FINA040.PRX
*/
 
User Function FI040ROT
	Local aArea		:= GetArea()
	Local aRotina	:= PARAMIXB

	aAdd( aRotina, { "AST","StaticCall( GEFCNHBWS, GEFCNHBWS )", 0, 7} )
	
	RestArea( aArea )
	
Return( aRotina )
