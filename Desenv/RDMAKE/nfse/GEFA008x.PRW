#Include "Protheus.Ch"
#Include "TopConn.Ch"
#Include "Ap5Mail.Ch"
#Include "TbiConn.Ch"
/*__________________________________________________________________________________
|����������������������������������������������������������������������������������|
|��+----------------------------------------------------------------------------+��|
|��| Cliente   | Gefico                                   | Data   | 15/10/2013 |��|
|��|-----------+----------------------------------------------------------------|��|
|��| Programa  | GEFA008   | Tipo |Rotina de Envio E-mail   | M�dulo | SIGAFAT  |��|
|��|-----------+----------------------------------------------------------------|��|
|��| Autor     | Rafael Rezende        | Empresa | Id�ias Tecnologia            |��|
|��|-----------+----------------------------------------------------------------|��|
|��| Descri��o |   Rotina com o objetivo de enviar o arquivo XML de uma nota de |��|
|��|           |servi�os para o Cliente.                                        |��|
|��|-----------+----------------------------------------------------------------|��|
|����������������������������������������������������������������������������������|
|��|----------------------------------------------------------------------------|��|
|��| Altera��o da Rotina                                  | Data   | 14/11/2013 |��|
|��|----------------------------------------------------------------------------|��|
|��| Autor     |  Andr� Costa          | Empresa | Id�ias Tecnologia            |��|
|��|----------------------------------------------------------------------------|��|
|��| Motivo    | Coloca��o do filtro de Filial, acerto no envio do XML das      |��|
|��|           | empresas 07,20 e 21 pois n�o saia correto e coloca��o do Check |��|
|��|           | Box de Invers�o de Sele��o												  |��|
|��+----------------------------------------------------------------------------+��|
|����������������������������������������������������������������������������������|
����������������������������������������������������������������������������������*/
                      
*---------------------*
User Function GEFA008
*---------------------*
	Local _nOpc       := 0
	Local _oBtnOk		:= Nil
	Local _oBtnParam	:= Nil
	Local _oBtnSair	:= Nil
	Local _oGroupMsg	:= Nil
	Local _oSayMsg		:= Nil
	Local _oFontMsg	:= TFont():New( "Arial",, 018,, .F.,,,,, .F., .F. )
	Local _oFontBtn 	:= TFont():New( "Arial",, 017,, .T.,,,,, .F., .F. )
	Local _cMensagem	:= "Selecione os Par�metros desejados atrav�s do Bot�o Par�metros e ent�o confirme o Processamento."
	
	Private _cPerg 	:= "GEFA008X"
	Private _oDlgTela	:= Nil

Return