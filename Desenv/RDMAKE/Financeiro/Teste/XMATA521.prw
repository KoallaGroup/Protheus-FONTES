#DEFINE GD_INSERT 1
#DEFINE GD_UPDATE 2
#DEFINE GD_DELETE 4
#INCLUDE "MATA521.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rogram   矼ATA521A  � Rev.  矱duardo Riera          � Data �29.12.2001  潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噮o 砇otina de exclusao dos documentos de Saida                    潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   砃enhum                                                        潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros砃enhum                                                        潮�
北�          �                                                              潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                       潮�
北媚哪哪哪哪哪哪穆哪哪哪哪履哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� PROGRAMADOR  � DATA   � BOPS �  MOTIVO DA ALTERACAO                     潮�
北媚哪哪哪哪哪哪呐哪哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�              �        �      �                                          潮�
北滥哪哪哪哪哪哪牧哪哪哪哪聊哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/

User Function AMATA521A()

Local aArea     := GetArea()
Local aIndSF2   := {}
Local cFilSF2   := ""
Local cBakSF2   := ""
Local cQrySF2   := ""
Local cMarca	:= ""
Local lSeleciona:= .F.
Local lCreate   := .F.

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//砊ratamento para e-Commerce      �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
Local lECommerce := SuperGetMV("MV_LJECOMM",,.F.) .AND. GetRpoRelease("R5")
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//矯arga das Variaveis Staticas do Programa                                �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Define Array contendo as Rotinas a executar do programa  �
//� ----------- Elementos contidos por dimensao ------------ �
//� 1. Nome a aparecer no cabecalho                          �
//� 2. Nome da Rotina associada                              �
//� 3. Usado pela rotina                                     �
//� 4. Tipo de Transa噭o a ser efetuada                      �
//�    1 - Pesquisa e Posiciona em um Banco de Dados         �
//�    2 - Simplesmente Mostra os Campos                     �
//�    3 - Inclui registros no Bancos de Dados               �
//�    4 - Altera o registro corrente                        �
//�    5 - Remove o registro corrente do Banco de Dados      �
//�    6 - Altera determinados campos sem incluir novos Regs �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
PRIVATE bFiltraBrw := {|| Nil}
PRIVATE bEndFilBrw := {|| EndFilBrw("SF2",aIndSF2),aIndSF2:={}}
PRIVATE cCadastro  := OemToAnsi(STR0001)	//"Exclusao dos Documento de Saida"
PRIVATE aRotina    := { ;
	{ STR0002 ,"PesqBrw"  , 0 , 0},; //"Pesquisa"
	{ STR0004,"Mc090Visua", 0 , 2},; //"Visualizar"
	{ STR0005,"Ma521MarkB", 0 , 5}} //"Excluir"
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//矱xibe as perguntas da rotina:                                           �
//�                                                                        �
//�1) Modelo de Interface? Marcacao/Selecao                                �
//�2) Selecionar Itens   ? Sim/Nao                                         �
//�3) Emissao de         ?                                                 �
//�4) Emissao ate        ?                                                 �
//�5) Serie de           ?                                                 �
//�6) Serie ate          ?                                                 �
//�7) Documento de       ?                                                 �
//�8) Documento ate      ?                                                 �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
AjustaSX1()
If Pergunte("MT521A",.T.)
	#IFDEF TOP
		SF2->(dbSetOrder(1))
	#ELSE
		SF2->(dbSetOrder(2))    /// colocado para que a fun玢o FilBrowse utilize o indice 1 no filtro, a fu玢o utiliza indice -1, tornando o indice 0, neste fonte necessitamos que o fitro utiliza um indice 19/04/2011 TI4501
	#ENDIF

	lSeleciona := MV_PAR02==1
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//矼ontagem da expressao de filtro                                         �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	cFilSF2 := "F2_FILIAL='"+xFilial("SF2")+"' .And. "
	cQrySF2 := "SF2.F2_FILIAL='"+xFilial("SF2")+"' AND "
	cFilSF2 += "DTOS(F2_EMISSAO)>='"+Dtos(MV_PAR03)+"' .And. "
	cQrySF2 += "SF2.F2_EMISSAO>='"+Dtos(MV_PAR03)+"' AND "
	cFilSF2 += "DTOS(F2_EMISSAO)<='"+Dtos(MV_PAR04)+"' .And. "
	cQrySF2 += "SF2.F2_EMISSAO<='"+Dtos(MV_PAR04)+"' AND "
	cFilSF2 += "F2_SERIE>='"+MV_PAR05+"' .And. "
	cQrySF2 += "SF2.F2_SERIE>='"+MV_PAR05+"' AND "
	cFilSF2 += "F2_SERIE<='"+MV_PAR06+"' .And. "
	cQrySF2 += "SF2.F2_SERIE<='"+MV_PAR06+"' AND "
	cFilSF2 += "F2_DOC>='"+MV_PAR07+"' .And. "
	cQrySF2 += "SF2.F2_DOC>='"+MV_PAR07+"' AND "
	cFilSF2 += "F2_DOC<='"+MV_PAR08+"'"
	cQrySF2 += "SF2.F2_DOC<='"+MV_PAR08+"'"

	If ExistBlock( "M520FIL" )
		cFilSF2 += ".And."+ExecBlock("M520FIL",.F.,.F.)
	EndIf

	If ExistBlock( "M520QRY" )
		cQrySF2 := ExecBlock("M520QRY",.F.,.F.,{ cQrySF2 , 1 })
	EndIf


	cBakSF2 := cFilSF2

	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//砇ealiza a Filtragem                                                     �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	bFiltraBrw := {|x,y|IIf(x==Nil,FilBrowse("SF2",@aIndSF2,@cFilSF2),IIf(x==1,{cBakSF2,cQrySF2},IIf(x==2,aIndSF2,cFilSF2:=y))) }
	//Eval(bFiltraBrw)    //Ajustes efetuados para o chamado THSQNC (instru珲es conforme Framework)

	SF2->(dbSetOrder(1))     /// no CodeBase a fun玢o FilBrowse retornar� o indice 2 19/04/2011 TI4501
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//砎erifica o modelo de interface                                          �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	If MV_PAR01 == 1
		Pergunte("MTA521",.F.)
		SetKey(VK_F12,{||Pergunte("MTA521",.T.)})
		aRotina[3][2] := "Ma521MarkB"

        //谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
        //� Ponto de entrada para pre-validar os dados a serem  �
        //� exibidos.                                           �
        //滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
        IF ExistBlock("M520BROW")
	       ExecBlock("M520BROW",.F.,.F.)
        Endif

		if lECommerce
   		   cMarca	:= GetMark(,"SF2","F2_OK")
		   MarkBrow("SF2","F2_OK",,,lSeleciona,cMarca,,,,,"A521VERPRS('1','" + cMarca + "')",,,,,,,cFilSF2)
		else
		   MarkBrow("SF2","F2_OK",,,lSeleciona,GetMark(,"SF2","F2_OK"),,,,,,,,,,,,cFilSF2)
		endIf
		SetKey(VK_F12,Nil)
	Else
		Pergunte("MTA521",.F.)
		SetKey(VK_F12,{||Pergunte("MTA521",.T.)})
		aRotina[3][2] := "Ma521Mbrow"

        //谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
        //� Ponto de entrada para pre-validar os dados a serem  �
        //� exibidos.                                           �
        //滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
        IF ExistBlock("M520BROW")
	       ExecBlock("M520BROW",.F.,.F.)
        Endif

		mBrowse(7,4,20,74,"SF2")
		SetKey(VK_F12,Nil)
	EndIf
EndIf
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//砇estaura a integridade da rotina                                �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
EndFilBrw("SF2",aIndSF2)
RetIndex("SF2")

RestArea(aArea)
Return(.T.)

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rogram   矼A521Filtr� Rev.  矱duardo Riera          � Data �29.12.2001	潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噮o 砇otina de filtragem da interface da rotina de exclusao     	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   砃enhum                                                      	潮�
北�          �                                                            	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros矱xpC1: Alias para filtragem                                 	潮�
北�          �                                                            	潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     	潮�
北媚哪哪哪哪哪哪穆哪哪哪哪履哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� PROGRAMADOR  � DATA   � BOPS �  MOTIVO DA ALTERACAO                     潮�
北媚哪哪哪哪哪哪呐哪哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�              �        �      �                                          潮�
北滥哪哪哪哪哪哪牧哪哪哪哪聊哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
Static Function MA521Filtr(cAlias)

Local aArea   := GetArea()
Local cOldFil := Eval(bFiltraBrw,1)[1]
Local cFiltro := ""

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//矲echa todos os indices e restaura a integridade da tabela       �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
(cAlias)->(dbClearFilter())
cFiltro := FilterExpr(cAlias)
Eval(bEndFilBrw)
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//矼onta a expressao do filtro                                     �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
dbSelectArea(cAlias)
If ( Empty(cFiltro) )
	cFiltro := ".T."
EndIf
cFiltro := cOldFil + ".And." + cFiltro
Eval(bFiltraBrw,3,cFiltro)
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//砇ecria o novo indice/filtro                                     �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
Eval(bFiltraBrw)
RestArea(aArea)
Return(.T.)

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rogram   矼A521Markb� Rev.  矱duardo Riera          � Data �29.12.2001	潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噮o 砇otina de processamento da Exclusao dos documento de saida 	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   砃enhum                                                      	潮�
北�          �                                                            	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros矱xpC1: Alias                                                	潮�
北�          �                                                            	潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     	潮�
北媚哪哪哪哪哪哪穆哪哪哪哪履哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� PROGRAMADOR  � DATA   � BOPS �  MOTIVO DA ALTERACAO                     潮�
北媚哪哪哪哪哪哪呐哪哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�              �        �      �                                          潮�
北滥哪哪哪哪哪哪牧哪哪哪哪聊哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
Static Function Ma521Markb(cAlias,nReg,nOpcX,cMarca,lInverte)

Local aArea    := GetArea()

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//� Define variaveis de parametrizacao de lancamentos             �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//� mv_par01 Mostra Lan�.Contab ?  Sim/Nao                        �
//� mv_par02 Aglut. Lan嘺mentos ?  Sim/Nao                        �
//� mv_par03 Lan�.Contab.On-Line?  Sim/Nao                        �
//� mv_par04 Retornar PV        ?  Carteira/Apto a faturar        �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
If MsgYesNo(OemToAnsi(STR0006),; //"Confirma estorno dos documentos marcados ?"
		OemToAnsi(STR0007)) //"Aten噭o"
	PcoIniLan("000101")
	Processa({|lEnd| Ma521Mark2(cAlias,;
		@lEnd,;
		MV_PAR01==1,;
		MV_PAR02==1,;
		MV_PAR03==1,;
		MV_PAR04==1)},,OemToAnsi(STR0008),.T.) //"Estorno dos documentos de saida"
	PcoFinLan("000101")
EndIf
RestArea(aArea)
Return(.T.)

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rogram   矼A521Markb� Rev.  矱duardo Riera          � Data �29.12.2001	潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噮o 砇otina de processamento da Exclusao dos documento de saida 	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   砃enhum                                                      	潮�
北�          �                                                            	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros矱xpC1: Alias                                                	潮�
北�          矱xpL2: Controle de cancelamento                             	潮�
北�          矱xpL3: Mostra lancto contabil                               	潮�
北�          矱xpL4: Aglutina lancto contabil                             	潮�
北�          矱xpL5: Contabiliza On-Line                                  	潮�
北�          矱xpL6: Pedido em carteira                                   	潮�
北�          �                                                            	潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     	潮�
北媚哪哪哪哪哪哪穆哪哪哪哪履哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� PROGRAMADOR  � DATA   � BOPS �  MOTIVO DA ALTERACAO                     潮�
北媚哪哪哪哪哪哪呐哪哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�              �        �      �                                          潮�
北滥哪哪哪哪哪哪牧哪哪哪哪聊哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
Static Function Ma521Mark2(cAlias,lEnd,lMostraCtb,lAglCtb,lContab,lCarteira)

Local aArea     := GetArea()
Local aAreaSF2  := SF2->(GetArea())
Local aAreaDAK  := DAK->(GetArea())
Local aRegSD2   := {}
Local aRegSE1   := {}
Local aRegSE2   := {}
Local cMensagem := RetTitle("F2_DOC")
Local cAliasSF2 := "SF2"
Local cAliasDAK := "DAK"
Local cMarca    := ThisMark()
Local cIndSF2   := ""
Local cSavFil   := cFilAnt
Local lInverte  := ThisInv()
Local lQuery    := .F.
Local lValido   := .F.
Local lMs520Vld := (existblock("MS520VLD",,.T.))
Local lMs520VldE:= ExistTemplate("MS520VLD")
Local lSF2520ET := ExistTemplate("SF2520E")
Local lSF2520E  := Existblock("SF2520E")
Local lIntACD	:= SuperGetMV("MV_INTACD",.F.,"0") == "1"
Local nVlEntCom := OsVlEntCom()
Local nIndSF2   := 5
Local bWhile1   := {|| !Eof()}
Local bWhile2   := {|| !Eof()}

#IFDEF TOP
	Local aFiltro   := Eval(bFiltraBrw,1)
	Local aStruSF2  := {}
	Local cQuery    := ""
	Local nX        := 0
#ENDIF

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Verifica a Tabela da MarkBrowse                                �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
Do Case
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Tratamento dos Documentos de saida                             �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
Case cAlias == "SF2"
	dbSelectArea("SF2")

	#IFDEF TOP

		If TcSrvType()<>"AS/400"
			lQuery    := .T.
			cAliasSF2 := "MA521MarkB"
			aStruSF2  := SF2->(dbStruct())

			cQuery := "SELECT SF2.*,R_E_C_N_O_ SF2RECNO "
			cQuery += "FROM "+RetSqlName("SF2")+" SF2 "
			cQuery += "WHERE SF2.F2_FILIAL='"+xFilial("SF2")+"' AND "
			If ( lInverte )
				cQuery += "SF2.F2_OK<>'"+cMarca+"' AND "
			Else
				cQuery += "SF2.F2_OK='"+cMarca+"' AND "
			EndIf
			cQuery += aFiltro[2]+" AND "
			cQuery += "SF2.D_E_L_E_T_=' ' "
			cQuery += "ORDER BY "+SqlOrder(SF2->(IndexKey()))

			cQuery := ChangeQuery(cQuery)

			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSF2,.T.,.T.)

			For nX := 1 To Len(aStruSF2)
				If aStruSF2[nX][2]<>"C"
					TcSetField(cAliasSF2,aStruSF2[nX][1],aStruSF2[nX][2],aStruSF2[nX][3],aStruSF2[nX][4])
				EndIf
			Next nX
		Else
	#ENDIF
			dbSelectArea("SF2")
			MsSeek(xFilial("SF2"))
	#IFDEF TOP
		EndIf
	#ENDIF
	ProcRegua(SF2->(LastRec()))
	dbSelectArea(cAliasSF2)
	While !Eof()
		lValido := .T.
		If !lQuery
			If  !((SF2->F2_OK != cMarca .And. lInverte).Or.(SF2->F2_OK == cMarca .And. !lInverte))
				lValido := .F.
			EndIf
		EndIf
		If lValido
			If lQuery
				dbSelectArea("SF2")
				MsGoto((cAliasSF2)->SF2RECNO)
				cFiltro:= dbFilter()
				If !Empty(cFiltro)
					lValido := &cFiltro
				EndIf
			EndIf
			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
			//� Integracao com o ACD - Validacao da exclusao da Nota Fiscal de Saida  		 �
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
			If lIntACD .And. FindFunction("CBMS520VLD")
				lValido := CBMS520VLD()
			ElseIf lMs520VldE
				lValido := ExecTemplate("MS520VLD",.F.,.F.)
			EndIf
			If lValido .And. lMs520Vld
				lValido := ExecBlock("MS520VLD",.F.,.F.)
			EndIf
			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
			//� Verifica se o estorno do documento de saida pode ser feito     �
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
			aRegSD2 := {}
			aRegSE1 := {}
			aRegSE2 := {}
			If MaCanDelF2(cAliasSF2,SF2->(RecNo()),@aRegSD2,@aRegSE1,@aRegSE2) .And. lValido .AND. MA521VerSC6(SF2->F2_FILIAL,SF2->F2_DOC,SF2->F2_SERIE,SF2->F2_CLIENTE,SF2->F2_LOJA)
				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
				//� Integracao com o ACD - Acerto do CB0 na Exclusao da NF de devolucao via Protheus,			�
				//� Somente se a etiqueta estiver com NF de Devolucao gravada 		  							�
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
				If lIntACD .And. FindFunction("CBSF2520E")
					CBSF2520E()
				//谀哪哪哪哪哪哪哪哪哪哪目
				//� Pontos de Entrada 	 �
				//滥哪哪哪哪哪哪哪哪哪哪馁
				ElseIf lSF2520ET
					ExecTemplate("SF2520E",.F.,.F.)
				EndIf

				If nModulo == 72
					KEXFA00()
				Endif

				If lSF2520E
					ExecBlock("SF2520E",.F.,.F.)
				EndIf
				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
				//� Estorna o documento de saida                                   �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
				SF2->(MaDelNFS(aRegSD2,aRegSE1,aRegSE2,lMostraCtb,lAglCtb,lContab,lCarteira))
			EndIf
			MsUnLockAll()
		EndIf
		dbSelectArea(cAliasSF2)
		dbSkip()
		IncProc(cMensagem+"..:"+(cAliasSF2)->F2_SERIE+"/"+(cAliasSF2)->F2_DOC)
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Controle de cancelamento do usuario                            �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If lEnd
			Exit
		EndIf
	EndDo
	If lQuery
		dbSelectArea(cAliasSF2)
		dbCloseArea()
		dbSelectArea("SF2")
	EndIf
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Tratamento para as Cargas                                      �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
Case cAlias == "DAK"
	dbSelectArea("DAK")
	dbSetOrder(1)
	#IFDEF TOP
		If TcSrvType()<>"AS/400"
			lQuery    := .T.
			cAliasSF2 := "MA521MarkB"
			cAliasDAK := "MA521MarkB"
			aStruSF2  := SF2->(dbStruct())

			cQuery := "SELECT SF2.*,R_E_C_N_O_ SF2RECNO "
			cQuery += "FROM "+RetSqlName("DAK")+" DAK,"+RetSqlName("SF2")+" SF2 "
			cQuery += "WHERE DAK.DAK_FILIAL='"+xFilial("DAK")+"' AND "
			If ( lInverte )
				cQuery += "DAK.DAK_OK<>'"+cMarca+"' AND "
			Else
				cQuery += "DAK.DAK_OK='"+cMarca+"' AND "
			EndIf
			cQuery += aFiltro[2]+" AND "
			If nVlEntCom == 1
				cQuery += "SF2.F2_FILIAL='"+xFilial("SF2")+"' AND "
			EndIf
			cQuery += "SF2.F2_CARGA=DAK.DAK_COD AND "
			cQuery += "SF2.F2_SEQCAR=DAK.DAK_SEQCAR AND "
			cQuery += "SF2.D_E_L_E_T_=' ' "
			cQuery += "ORDER BY "+SqlOrder(DAK->(IndexKey()))

			cQuery := ChangeQuery(cQuery)

			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasDAK,.T.,.T.)

			For nX := 1 To Len(aStruSF2)
				If aStruSF2[nX][2]<>"C"
					TcSetField(cAliasSF2,aStruSF2[nX][1],aStruSF2[nX][2],aStruSF2[nX][3],aStruSF2[nX][4])
				EndIf
			Next nX
    	Else
	#ENDIF
			If nVlEntCom <> 1
				cIndSF2 := CriaTrab(,.F.)
				dbSelectArea("SF2")
				IndRegua("SF2",cIndSF2,"F2_CARGA+F2_SEQCAR")
				nIndSF2 := RetIndex("SF2")+1
				#IFDEF TOP
					dbSetIndex(cIndSF2+OrdBagExt())
				#ENDIF
				dbSetOrder(nIndSF2)
				dbGotop()
				bWhile2 := {|| !Eof() .And. (cAliasSF2)->F2_CARGA == (cAliasDAK)->DAK_COD .And.;
					(cAliasSF2)->F2_SEQCAR == (cAliasDAK)->DAK_SEQCAR }
			Else
				bWhile2 := {|| !Eof() .And. (cAliasSF2)->F2_FILIAL == xFilial("SF2") .And.;
					(cAliasSF2)->F2_CARGA == (cAliasDAK)->DAK_COD .And.;
					(cAliasSF2)->F2_SEQCAR == (cAliasDAK)->DAK_SEQCAR }
			EndIf
			dbSelectArea("DAK")
			MsSeek(xFilial("DAK"))
	#IFDEF TOP
		EndIf
	#ENDIF
	ProcRegua(DAK->(LastRec()))
	dbSelectArea(cAliasDAK)
	While Eval(bWhile1)
		lValido := .T.
		If !lQuery
			If  !((DAK->DAK_OK != cMarca .And. lInverte).Or.(DAK->DAK_OK == cMarca .And. !lInverte))
				lValido := .F.
			EndIf
		EndIf
		If lValido
			If lQuery
				dbSelectArea("SF2")
				MsGoto((cAliasSF2)->SF2RECNO)
			Else
				If nVlEntCom == 1
					dbSelectArea("SF2")
					dbSetOrder(5)
					MsSeek(xFilial("SF2")+(cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR)
				Else
					dbSelectArea("SF2")
					dbSetOrder(nIndSF2)
					MsSeek((cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR)
				EndIf
			EndIf
			While Eval(bWhile2)
				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
				//矷ntegracao com o  ACD - Validacao da exclusao da Nota Fiscal de Saida  		�
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
				If lIntACD .And. FindFunction("CBMS520VLD")
					lValido := CBMS520VLD()
				ElseIf lMs520VldE
					lValido := ExecTemplate("MS520VLD",.F.,.F.)
				EndIf
				If lValido .And. lMs520Vld
					lValido := ExecBlock("MS520VLD",.F.,.F.)
				EndIf
				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
				//� Verifica a Filial do SF2                                       �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
				cFilAnt := IIf(!Empty(xFilial("SF2")),SF2->F2_FILIAL,cFilAnt)
				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
				//� Verifica se o estorno do documento de saida pode ser feito     �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
				aRegSD2 := {}
				aRegSE1 := {}
				aRegSE2 := {}
				If MaCanDelF2(cAliasSF2,SF2->(RecNo()),@aRegSD2,@aRegSE1,@aRegSE2) .And. lValido

					//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
					//� Integracao com o  ACD - Acerto do CB0 na Exclusao da NF de devolucao via Protheus,			�
					//� Somente se a etiqueta estiver com NF de Devolucao gravada 		  							�
					//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
					If lIntACD .And. FindFunction("CBSF2520E")
						CBSF2520E()
					//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
					//� Pontos de Entrada 											   �
					//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
					ElseIf lSF2520ET
						ExecTemplate("SF2520E",.F.,.F.)
					EndIf

					If nModulo == 72
						KEXFA00()
					Endif

					If lSF2520E
						ExecBlock("SF2520E",.F.,.F.)
					EndIf
					//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
					//� Estorna o documento de saida                                   �
					//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
					SF2->(MaDelNFS(aRegSD2,aRegSE1,aRegSE2,lMostraCtb,lAglCtb,lContab,lCarteira))
				EndIf
				MsUnLockAll()
				dbSelectArea(cAliasSF2)
				dbSkip()
			EndDo
		EndIf
		If lQuery
			dbSelectArea(cAliasDAK)
			dbSkip()
		EndIf
		IncProc(cMensagem+"..:"+(cAliasDAK)->DAK_COD+"/"+(cAliasDAK)->DAK_SEQCAR)
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Controle de cancelamento do usuario                            �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If lEnd
			Exit
		EndIf
	EndDo
	If lQuery
		dbSelectArea(cAliasDAK)
		dbCloseArea()
		dbSelectArea("DAK")
	Else
		dbSelectArea("SF2")
		RetIndex("SF2")
		FErase(cIndSF2+OrdBagExt())
	EndIf
EndCase
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Restaura a integridade da rotina                               �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
cFilAnt := cSavFil
RestArea(aAreaSF2)
RestArea(aAreaDAK)
RestArea(aArea)
Return(.T.)

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rogram   矼A521Mbrow� Rev.  矱duardo Riera          � Data �01.01.2002	潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噮o 砇otina de processamento da Exclusao dos documento de saida 	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   砃enhum                                                      	潮�
北�          �                                                            	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros矱xpC1: Alias                                                	潮�
北�          矱xpL2: Controle de cancelamento                             	潮�
北�          矱xpL3: Mostra lancto contabil                               	潮�
北�          矱xpL4: Aglutina lancto contabil                             	潮�
北�          矱xpL5: Contabiliza On-Line                                  	潮�
北�          矱xpL6: Pedido em carteira                                   	潮�
北�          �                                                            	潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     	潮�
北媚哪哪哪哪哪哪穆哪哪哪哪履哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� PROGRAMADOR  � DATA   � BOPS �  MOTIVO DA ALTERACAO                     潮�
北媚哪哪哪哪哪哪呐哪哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�              �        �      �                                          潮�
北滥哪哪哪哪哪哪牧哪哪哪哪聊哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
Static Function Ma521Mbrow(cAlias)

Local aArea     := GetArea()
Local aAreaSF2  := SF2->(GetArea())
Local aAreaDAK  := DAK->(GetArea())
Local aRegSD2   := {}
Local aRegSE1   := {}
Local aRegSE2   := {}
Local cQuery    := ""
Local cAliasSF2 := "SF2"
Local cIndSF2   := ""
Local cSavFil   := cFilAnt
Local lQuery    := .F.
Local lValido   := .T.
Local lMs520Vld := (existblock("MS520VLD",,.T.))
Local lMs520VldE:= ExistTemplate("MS520VLD")
Local lSF2520ET := ExistTemplate("SF2520E")
Local lSF2520E  := Existblock("SF2520E")
Local lIntACD	:= SuperGetMV("MV_INTACD",.F.,"0") == "1"
Local lMostraCtb:= .F.
Local lAglCtb   := .F.
Local lContab   := .F.
Local lCarteira := .F.
Local nVlEntCom := OsVlEntCom()
Local nIndSF2   := 5
Local bWhile   := {|| !Eof()}

#IFDEF TOP
	Local aStruSF2  := {}
	Local nX        := 0
#ENDIF


//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//� Define variaveis de parametrizacao de lancamentos             �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//� mv_par01 Mostra Lan�.Contab ?  Sim/Nao                        �
//� mv_par02 Aglut. Lan嘺mentos ?  Sim/Nao                        �
//� mv_par03 Lan�.Contab.On-Line?  Sim/Nao                        �
//� mv_par04 Retornar PV        ?  Carteira/Apto a faturar        �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
If MsgYesNo(OemToAnsi(STR0009),OemToAnsi(STR0007)) //"Confirma estorno do documento ?"###"Aten噭o"

	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
	//� Inicializa processo de lan鏰mento no modulo PCO �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
	PcoIniLan("000101")

	lMostraCtb := MV_PAR01==1
	lAglCtb    := MV_PAR02==1
	lContab    := MV_PAR03==1
	lCarteira  := MV_PAR04==1

	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Verifica a Tabela da MarkBrowse                                �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	Do Case
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Tratamento dos Documentos de saida                             �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	Case cAlias == "SF2"
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Integracao com o ACD - Validacao da exclusao da Nota Fiscal de Saida  		 �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If lIntACD .And. FindFunction("CBMS520VLD")
			lValido := CBMS520VLD()
		ElseIf lMs520VldE
			lValido := ExecTemplate("MS520VLD",.F.,.F.)
		EndIf
		If lValido .And. lMs520Vld
			lValido := ExecBlock("MS520VLD",.F.,.F.)
		EndIf
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Verifica se o estorno do documento de saida pode ser feito     �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		aRegSD2 := {}
		aRegSE1 := {}
		aRegSE2 := {}
		If MaCanDelF2(cAliasSF2,SF2->(RecNo()),@aRegSD2,@aRegSE1,@aRegSE2) .And. lValido .AND. MA521VerSC6(SF2->F2_FILIAL,SF2->F2_DOC,SF2->F2_SERIE,SF2->F2_CLIENTE,SF2->F2_LOJA)

			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
			//� Integracao com o ACD - Acerto do CB0 na Exclusao da NF de devolucao via Protheus,			�
			//� Somente se a etiqueta estiver com NF de Devolucao gravada 		  							�
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
			If lIntACD .And. FindFunction("CBSF2520E")
				CBSF2520E()
			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
			//� Pontos de Entrada 										       �
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
			ElseIf lSF2520ET
				ExecTemplate("SF2520E",.F.,.F.)
			EndIf

			If nModulo == 72
				KEXFA00()
			Endif

			If lSF2520E
				ExecBlock("SF2520E",.F.,.F.)
			EndIf
			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
			//� Estorna o documento de saida                                   �
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
			SF2->(MaDelNFS(aRegSD2,aRegSE1,aRegSE2,lMostraCtb,lAglCtb,lContab,lCarteira))
		EndIf
		MsUnLockAll()
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Tratamento para as Cargas                                      �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	Case cAlias == "DAK"
		If DAK->DAK_ACEFIN<>"2"
			Help(" ",1,"OMS320JAFIN") //"Acerto financeiro ja efetuado"
		ElseIf DAK->DAK_ACECAR<>"2"
				Help(" ",1,"OMS320JAAC") //Carga ja encerrada
		Else
			dbSelectArea("SF2")
			dbSetOrder(1)
			#IFDEF TOP
				If TcSrvType()<>"AS/400"
					lQuery    := .T.
					cAliasSF2 := "MA521Mbrow"
					aStruSF2  := SF2->(dbStruct())

					cQuery := "SELECT SF2.*,R_E_C_N_O_ SF2RECNO "
					cQuery += "FROM "+RetSqlName("SF2")+" SF2 "
					cQuery += "WHERE "
					If nVlEntCom == 1
						cQuery += "SF2.F2_FILIAL='"+xFilial("SF2")+"' AND "
					EndIf
					cQuery += "SF2.F2_CARGA='"+DAK->DAK_COD+"' AND "
					cQuery += "SF2.F2_SEQCAR='"+DAK->DAK_SEQCAR+"' AND "
					cQuery += "SF2.D_E_L_E_T_=' ' "

					cQuery := ChangeQuery(cQuery)

					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSF2,.T.,.T.)

					For nX := 1 To Len(aStruSF2)
						If aStruSF2[nX][2]<>"C"
							TcSetField(cAliasSF2,aStruSF2[nX][1],aStruSF2[nX][2],aStruSF2[nX][3],aStruSF2[nX][4])
						EndIf
					Next nX
		    	Else
			#ENDIF
					If nVlEntCom <> 1
						cQuery := "F2_CARGA='"+DAK->DAK_COD+"' .And."
						cQuery += "F2_SEQCAR='"+DAK->DAK_SEQCAR+"'"
						cIndSF2 := CriaTrab(,.F.)
						dbSelectArea("SF2")
						IndRegua("SF2",cIndSF2,"F2_CARGA+F2_SEQCAR",,cQuery)
						nIndSF2 := RetIndex("SF2")+1
						#IFNDEF TOP
							dbSetIndex(cIndSF2+OrdBagExt())
						#ENDIF
						dbSetOrder(nIndSF2)
						dbGotop()
						bWhile := {|| !Eof() .And. (cAliasSF2)->F2_CARGA == DAK->DAK_COD .And.;
							(cAliasSF2)->F2_SEQCAR == DAK->DAK_SEQCAR }
					Else
						dbSelectArea("SF2")
						dbSetOrder(5)
						MsSeek(xFilial("SF2")+DAK->DAK_COD+DAK->DAK_SEQCAR)
						bWhile := {|| !Eof() .And. (cAliasSF2)->F2_FILIAL == xFilial("SF2") .And.;
							(cAliasSF2)->F2_CARGA == DAK->DAK_COD .And.;
							(cAliasSF2)->F2_SEQCAR == DAK->DAK_SEQCAR }
					EndIf
			#IFDEF TOP
				EndIf
			#ENDIF
			dbSelectArea(cAliasSF2)
			While Eval(bWhile)
				If lQuery
					dbSelectArea("SF2")
					MsGoto((cAliasSF2)->SF2RECNO)
				EndIf
				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
				//� Integracao com o ACD - Validacao da exclusao da Nota Fiscal de Saida  		 �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
				If lIntACD .And. FindFunction("CBMS520VLD")
					lValido := CBMS520VLD()
				ElseIf lMs520VldE
					lValido := ExecTemplate("MS520VLD",.F.,.F.)
				EndIf
				If lValido .And. lMs520Vld
					lValido := ExecBlock("MS520VLD",.F.,.F.)
				EndIf
				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
				//� Verifica a Filial do SF2                                       �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
				cFilAnt := IIf(!Empty(xFilial("SF2")),(cAliasSF2)->F2_FILIAL,cFilAnt)
				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
				//� Verifica se o estorno do documento de saida pode ser feito     �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
				aRegSD2 := {}
				aRegSE1 := {}
				aRegSE2 := {}
				If MaCanDelF2(cAliasSF2,SF2->(RecNo()),@aRegSD2,@aRegSE1,@aRegSE2) .And. lValido

					If lIntACD .And. FindFunction("CBSF2520E")
						CBSF2520E()
					//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
					//� Pontos de Entrada 										       �
					//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
					ElseIf lSF2520ET
						ExecTemplate("SF2520E",.F.,.F.)
					EndIf

					If nModulo == 72
						KEXFA00()
					Endif

					If lSF2520E
						ExecBlock("SF2520E",.F.,.F.)
					EndIf
					//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
					//� Estorna o documento de saida                                   �
					//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
					SF2->(MaDelNFS(aRegSD2,aRegSE1,aRegSE2,lMostraCtb,lAglCtb,lContab,lCarteira))
				EndIf
				MsUnLockAll()
				dbSelectArea(cAliasSF2)
				dbSkip()
			EndDo
			If lQuery
				dbSelectArea(cAliasSF2)
				dbCloseArea()
				dbSelectArea("SF2")
			Else
				dbSelectArea("SF2")
				RetIndex("SF2")
				FErase(cIndSF2+OrdBagExt())
			EndIf
		Endif
	EndCase

	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
	//� Finaliza processo de lancamento no modulo PCO �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
	PcoFinLan("000101")

EndIf
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Restaura a integridade da rotina                               �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
cFilAnt := cSavFil
RestArea(aAreaSF2)
RestArea(aAreaDAK)
RestArea(aArea)
Return(.T.)

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rogram   矼aCanDelF2� Rev.  矱duardo Riera          � Data �29.12.2001	潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噮o 砎alidacao da exclusao dos Documentos de Saida              	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   矱xpL1: Indica se o documento pode ser excluido              	潮�
北�          �                                                            	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros矱xpN1: Alias da tabela                                   (OPC)潮�
北�          矱xpN2: Recno da linha da tabela                          (OPC)潮�
北�          矱xpA3: Array com os Recnos do SD2                        (OPC)潮�
北�          矱xpA4: Array com os Recnos do SE1                        (OPC)潮�
北�          矱xpA5: Array com os Recnos do SE2                        (OPC)潮�
北�          矱xpC6: Origem a ser considerado na comparacao com registros  潮�
北�          �       gerados no modulo financeiro (Opcional)               潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     	潮�
北媚哪哪哪哪哪哪穆哪哪哪哪履哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� PROGRAMADOR  � DATA   � BOPS �  MOTIVO DA ALTERACAO                     潮�
北媚哪哪哪哪哪哪呐哪哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�              �        �      �                                          潮�
北滥哪哪哪哪哪哪牧哪哪哪哪聊哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
Static Function MaCanDelF2(cAlias,nRegSF2,aRegSD2,aRegSE1,aRegSE2,cOrigFin)

Local aArea			:= GetArea()
Local aAreaSF2 		:= SF2->(GetArea())
Local aAreaSD2 		:= SD2->(GetArea())
Local aAreaSE2 		:= SE2->(GetArea())
Local aAreaSE1 		:= SE1->(GetArea())
Local aAreaSB6 		:= SB6->(GetArea())
Local aLockSE1 		:= {}
Local aLockSE2 		:= {}
Local aLockSC5 		:= {}
Local aLockSB2 		:= {}
Local aAreaSIX 		:= {}
Local lRetorno 		:= .T.
Local lQuery   		:= .F.
Local dDtDigit 		:= dDataBase
Local cAliasSD2		:= "SD2"
Local cAliasSE1		:= "SE1"
Local cAliasSE2		:= "SE2"
Local cPrefixo 		:= ""
Local cMunic   		:= PadR(GetMv("MV_MUNIC"),Len(SE2->E2_FORNECE))
Local cEstado		:= SuperGetMv( "MV_ESTADO" , .F. )
Local nExcNfs		:= SuperGetMv( "MV_EXCNFS",,180 )
Local nTpPrz		:= SuperGetMv( "MV_TIPOPRZ",,1 )
Local lVldSbt		:= SuperGetMv( "MV_VLDSBT",,.T. )
Local cSerie   		:= ""
Local cNumero  		:= ""
Local cClieFor 		:= ""
Local cLoja    		:= ""
Local cTipo    		:= ""
Local cEspecie		:= ""
Local cMensagem		:= ""
Local cTipoNfs		:= ""
Local cMunSP    	:= "3550308"
Local cMunSalv    	:= "2927408"
Local cLojaISS 		:= PadR("00",Len(SE2->E2_LOJA))
Local lMa520SE1		:= ExistBlock("MA520SE1")
Local lMa520SE2		:= ExistBlock("MA520SE2")
Local lCondVenda	:= .F.
Local cUniao   		:= PadR(GetMV("MV_UNIAO"),Len(SE2->E2_FORNECE))
Local cLojaIRF 		:= Padr( "00", Len(SE2->E2_LOJA ))
Local lFreteEmb		:= .F. //-- Desabilitado devido a utiliza玢o do GFE. Ser� revisto futuramente
Local nHoras   		:= 0
Local nSpedExc 		:= GetNewPar("MV_SPEDEXC",24)
Local cTipoParc		:= MVNOTAFIS
Local cIndex		:= ''
Local cMsg	 		:= ''
Local cKey      	:= ''
Local cCondicao 	:= ''
Local lDocRelac 	:= .F.
Local lExcnfs		:= .T.
Local lLegMunSp 	:= .F.		// Legislacao apenas do Mun. de Sp (permite exclus鉶 de nota ate 180 dias da emissao)
Local lLegMunBA		:= .F.		// Legislacao apenas do Mun. de BA (permite exclus鉶 de nota ate o ultimo dia do mes subsequente da emissao)
Local lLegMun       := .F.
Local lProcAdm      := .F.
Local nInd      	:= 0
Local nCountSE1 	:= 0
Local lPriParAdtBx 	:= .F.
Local nValorAdtFR3 	:= 0
Local dDataR 		:= CTOD("01/" + StrZero(Month(SF2->F2_EMISSAO),2) + Str(Year(SF2->F2_EMISSAO)),"DD/MM/YYYY")
Local dDataR1       := CTOD("01/" + StrZero(Month(SF2->F2_EMISSAO),2) + Str(Year(SF2->F2_EMISSAO)),"DD/MM/YYYY")
Local dDtVenISS		:= ''

Local aMunic 	:= {}
Local cMunEst 	:= ''
Local nPosMunic := 0

#IFDEF TOP
	Local aStruSD2 := {}
	Local aStruSE1 := {}
	Local aStruSE2 := {}
	Local cQuery   := ""
	Local nX       := 0
	Local cAliasAux:= "cAliasAux"
	Local cQuerySD2:= ""
	Local lAlvoCERTO := .F.
	Local cQrySD2	:= ""
	Local cAliasTmp	:= "cAliasTmp"
#ENDIF


aAdd(aMunic,{"SP","S鉶 Bernardo do Campo","3548708"})
aAdd(aMunic,{"AL","Macei�","2704302"})
aAdd(aMunic,{"CE","Fortaleza","2304400"})
aAdd(aMunic,{"RN","Natal","2408102"})
aAdd(aMunic,{"SP","S鉶 Paulo","3550308"})
aAdd(aMunic,{"BA","Salvador","2927408"})
aAdd(aMunic,{"PR","Londrina","4113700"})
aAdd(aMunic,{"GO","Goi鈔ia","5208707"})
aAdd(aMunic,{"PE","Recife","2611606"})
aAdd(aMunic,{"PI","Teresina","2211001"})
aAdd(aMunic,{"RS","Porto Alegre","4314902"})
aAdd(aMunic,{"PA","Parauapebas","1505536"})
aAdd(aMunic,{"MG","Belo Horizonte","3106200"})
aAdd(aMunic,{"SP","Guarulhos","3518800"})
aAdd(aMunic,{"MS","Campo Grande","5002704"})
aAdd(aMunic,{"DF","Bras韑ia","5300108"})
aAdd(aMunic,{"RJ","Rio de Janeiro","3304557"})
aAdd(aMunic,{"AL","Rio Largo","2707701"})
aAdd(aMunic,{"RO","Porto Velho","1100205"})
aAdd(aMunic,{"SE","Aracaju","2800308"})


//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Posicionando registros                                         �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If nRegSF2 <> Nil
	dbSelectArea("SF2")
	MsGoto(nRegSF2)
EndIf
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Inicializa os parametros da Rotina                             �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
DEFAULT cAlias  := "SF2"
DEFAULT aRegSD2 := {}
DEFAULT aRegSE1 := {}
DEFAULT aRegSE2 := {}
DEFAULT cOrigFin:= "MATA460"

cSerie  := (cAlias)->F2_SERIE
cNumero := (cAlias)->F2_DOC
cClieFor:= (cAlias)->F2_CLIENTE
cLoja   := (cAlias)->F2_LOJA
cEspecie:= (cAlias)->F2_ESPECIE
cTipo   := (cAlias)->F2_TIPO
dDtdigit := IIf((cAlias)->(FieldPos('F2_DTDIGIT'))>0 .And. !Empty((cAlias)->F2_DTDIGIT),(cAlias)->F2_DTDIGIT,(cAlias)->F2_EMISSAO)
cPrefixo := IIf(Empty((cAlias)->F2_PREFIXO) .Or. SuperGetMv("MV_CMPDEVC",.F.,.F.),&(GetMv("MV_1DUPREF")),(cAlias)->F2_PREFIXO)

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//砎erifica se existe documentos relacionados a nota, caso existir n鉶 ser� poss韛el a exclus鉶   �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
If !(cTipo $ "C/I/P/D")
  	#IFDEF TOP
	cQuerySD2 := "SELECT D2_NFORI,D2_SERIORI "
	cQuerySD2 += "FROM "+RetSqlName("SD2")+" SD2 "
	cQuerySD2 += "WHERE D2_FILIAL = '"+xFilial("SF2")+"' AND D2_NFORI = '"+cNumero+"' AND D2_SERIORI = '"+cSerie+"' AND D2_TIPO IN ('C','I','P') AND D_E_L_E_T_=' ' "
	cQuerySD2 += "ORDER BY D2_FILIAL,D2_NFORI,D2_SERIORI"
	cQuerySD2 := ChangeQuery(cQuerySD2)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuerySD2),cAliasAux,.T.,.T.)
	IF cPaisLoc<>"PER" .And. cAliasAux->(!EOF())
		lRetorno 	:= .F.
		lDocRelac 	:= .T.
	EndIf
	cAliasAux->(DbCloseArea())

	#ELSE
	DbSelectArea("SD2")
	DbSetOrder(10)
	If DbSeek(xFilial("SF2")+cNumero+cSerie) .AND. cPaisLoc<>"PER"
		While !SD2->(EOF()) .AND. SD2->D2_FILIAL == xFilial("SF2") .AND. SD2->D2_NFORI==cNumero .AND. SD2->D2_SERIORI == cSerie
		    If SD2->D2_TIPO $ ('C/I/P')
				lRetorno  := .F.
				lDocRelac := .T.
			EndIf
			SD2->(DbSkip())
		EndDo
	EndIf
	RestArea(aAreaSD2)

   	#ENDIF
Endif
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Verificando se encontrou documentos relacionados                                �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If lDocRelac
	//Documento: XXXXXX Serie:XXX n鉶 p骴e ser excluido.
	//Verifique documentos relacionados.
	Alert(STR0015+': '+cNumero+' '+STR0016+': '+cSerie+' '+STR0017+'.'+CRLF+;
	      STR0018+'.')
EndIf
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//|Validacao para verificar se possivel a exclusao de NF Servi鏾 pra SP CAPITAL e Salvador BA|
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If lRetorno .AND. cPaisLoc == "BRA" .AND. SD2->(FieldPos('D2_ESTOQUE')) > 0 // Verifica se o campo D2_ESTOQUE existe pois o mesmo � criado por update
	#IFDEF TOP
	    cQrySD2 := " SELECT D2_DOC,D2_SERIE,D2_CLIENTE,D2_CF,D2_ESTOQUE,D2_TES,D2_LOJA,D2_CODISS,SD2.R_E_C_N_O_,F4_ISSST,F3_TIPO, F2_NFSUBST, F2_SERSUBS "
		cQrySD2 += " FROM "+RetSqlName("SD2")+" SD2 "
   		cQrySD2 += " INNER JOIN "+RetSqlName("SF2")+" SF2 ON SF2.F2_FILIAL = '" + xFilial("SF2") + "' AND SF2.F2_DOC = SD2.D2_DOC AND SF2.F2_SERIE = SD2.D2_SERIE AND SF2.D_E_L_E_T_ = '' "
		cQrySD2 += " INNER JOIN "+RetSqlName("SF4")+" SF4 ON SF4.F4_FILIAL = '" + xFilial("SF4") + "' AND SF4.F4_CODIGO = SD2.D2_TES AND SF4.D_E_L_E_T_ = '' "
		cQrySD2 += " INNER JOIN "+RetSqlName("SF3")+" SF3 ON SF3.F3_FILIAL = '" + xFilial("SF3") + "' AND SF3.F3_NFISCAL = SD2.D2_DOC AND SF3.F3_SERIE = SD2.D2_SERIE AND SF3.F3_CLIEFOR = SD2.D2_CLIENTE AND SF3.F3_LOJA = SD2.D2_LOJA AND SF3.D_E_L_E_T_ = '' "
//		cQrySD2 += " INNER JOIN "+RetSqlName("SF3")+" SF3 ON SF3.F3_FILIAL = '" + xFilial("SF3") + "' AND SF3.F3_NFISCAL = SD2.D2_DOC AND SF3.F3_SERIE = SD2.D2_SERIE AND SF3.F3_CLIEFOR = SD2.D2_CLIENTE AND SF3.F3_LOJA = SD2.D2_LOJA AND SF3.F3_TIPO = 'S' AND SF3.D_E_L_E_T_ = '' "
		cQrySD2 += " WHERE SD2.D2_FILIAL = '"+xFilial("SF2")+"' AND SD2.D2_DOC = '"+cNumero+"' AND SD2.D2_SERIE = '"+cSerie+"' AND SD2.D2_CLIENTE = '"+cClieFor+"' AND SD2.D2_LOJA = '"+cLoja+"' AND SD2.D_E_L_E_T_ = '' "
        //?????
 		If cEstado == "BA" .AND. Alltrim(SM0->M0_CODMUN) == aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Salvador"}),3]
 			cQrySD2 += " AND SF2.F2_NFSUBST = '' AND SF2.F2_SERSUBS = '' "
 		EndIf
 		cQrySD2 := ChangeQuery(cQrySD2)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQrySD2),cAliasTmp,.T.,.T.)
			While cAliasTmp->(!EOF())
			   //Valida鏰o de Nf servi鏾
			    If ((cAliasTmp->F3_TIPO == "S") .AND. ;
			    	cAliasTmp->D2_ESTOQUE == "N" .AND. ;
				    !Empty(cAliasTmp->D2_CODISS) .AND.;
				    cAliasTmp->F4_ISSST == "1" )
		   				lExcNfs := .F.
				Else
				    //Notas que nao sao de servico, mas TES de todos os itens da nf nao controla estoque
				    //exclus鏰o permitida sem regras
				    If (cAliasTmp->D2_ESTOQUE == "N")
						lExcNfs := .T.
				   		Exit
				   	EndIf
				EndIf
				cAliasTmp->(dBskip())

			EndDo
			cAliasTmp->(dBCloseArea())
	#ELSE
		dBSelectArea("SD2")
		dBSetorder(3)
		dBSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA)//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
		While ( !Eof() .And. xFilial("SD2") == SD2->D2_FILIAL .And. cNumero == SD2->D2_DOC .And. cSerie == SD2->D2_SERIE .And. cClieFor == SD2->D2_CLIENTE .And. cLoja == SD2->D2_LOJA )
			If !Empty(SD2->D2_CODISS);
			   	.AND. SD2->D2_ESTOQUE == "N";
				.AND. (Posicione("SF4",1,xFilial("SF4")+SD2->D2_TES,"F4_ISSST") == "1");
				.AND. (Posicione("SF3",4,xFilial("SF3")+SD2->D2_CLIENTE+SD2->D2_LOJA+SD2->D2_DOC+SD2->D2_SERIE,"F3_TIPO") == "S")

				lExcNfs := .F.
			Else
			    //Notas que nao sao de servico, mas TES de todos os itens da nf nao controla estoque
			    //exclus鏰o permitida sem regras
				If (SD2->D2_ESTOQUE == "N")
			   		lExcNfs := .T.
			    EndIf
			EndIf
			If !lExcNfs	.And. ((cEstado == "BA" .AND. Alltrim(SM0->M0_CODMUN) == aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Salvador"}),3]) .OR.;
			                    (cEstado == "PR" .AND. Alltrim(SM0->M0_CODMUN) == aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Londrina"}),3]))
			  	If(Empty(Posicione("SF2",1,xFilial("SF2")+SD2->D2_DOC+SD2->D2_SERIE,AllTrim("F2_NFSUBST")))) .AND.;
			 	(Empty(Posicione("SF2",1,xFilial("SF2")+SD2->D2_DOC+SD2->D2_SERIE,"F2_SERSUBS")))
					lExcNfs := .F.
				Else
					lExcNfs := .T.
				EndIf
			EndIf
		SD2->(dBSkip())
		EndDo
	#ENDIF
EndIf

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Verificando o Fechamento Fiscal                                �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If lRetorno .And. !FisChkDt(dDtDigit)
	lRetorno := .F.
EndIf

If lRetorno .And. "SPED"$cEspecie .And. ((cAlias)->F2_FIMP$"TS") //verificacao apenas da especie como SPED e notas que foram transmitidas ou impressoo DANFE
	nHoras := SubtHoras(IIF(SF2->(FieldPos("F2_DAUTNFE")) <> 0 .And. !Empty(SF2->F2_DAUTNFE),SF2->F2_DAUTNFE,dDtdigit),IIF(SF2->(FieldPos("F2_HAUTNFE")) <> 0 .And. !Empty(SF2->F2_HAUTNFE),SF2->F2_HAUTNFE,SF2->F2_HORA),dDataBase, substr(Time(),1,2)+":"+substr(Time(),4,2) )
	If nHoras > nSpedExc
		MsgAlert("N鉶 foi possivel excluir a(s) nota(s), pois o prazo para o cancelamento da(s) NF-e � de " + Alltrim(STR(nSpedExc)) +" horas")
		lRetorno := .F.
    EndIf
EndIf

If lRetorno .And. lFreteEmb
	aAreaSIX := SIX->(GetArea())
	SIX->(DbSetOrder(1))
	If	SIX->(DbSeek("DUA9"))
		dbSelectArea("DAK")
		dbSetOrder(1)
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Contrato de Carreteiro para a carga da nota fiscal             �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If	MsSeek(xFilial("DAK")+(cAlias)->F2_CARGA+(cAlias)->F2_SEQCAR)
			dbSelectArea("DTY")
			dbSetOrder(5)
			If	MsSeek(OsFilial("DTY",DAK->DAK_FILIAL)+"2"+DAK->DAK_IDENT)
				Aviso("SIGAOMS",STR0014,{"Ok"}) //"Nao e permitido excluir o documento, ja existe Contrato de Carreteiro gerado"
				lRetorno := .F.
			EndIf
			If	lRetorno
				dbSelectArea("DUA")
				dbSetOrder(9)
				If	MsSeek(OsFilial("DUA",DAK->DAK_FILIAL)+"2"+DAK->DAK_IDENT)
					Aviso("SIGAOMS",STR0014,{"Ok"}) //"Nao e permitido excluir o documento, ja existe Contrato de Carreteiro gerado"
					lRetorno := .F.
				EndIf
			EndIf
		EndIf
	EndIf
	RestArea(aAreaSIX)
EndIf

nPosMunic := aScan(aMunic,{|x| Alltrim(x[3])==AllTrim(SM0->M0_CODMUN)})

If lRetorno .And. !lExcNfs .And. (nPosMunic > 0)

	cMunEst := aMunic[nPosMunic,2] +' - '+ aMunic[nPosMunic,1]

	//Verifica se o municipio tem legislacao especial
	If (aScan(aMunic,{|x| Alltrim(x[3])==AllTrim(SM0->M0_CODMUN)}) <> 0 .And. ;
		(aScan(aMunic,{|x| Alltrim(x[1])==AllTrim(cEstado)}) <> 0))
		lLegMun := .T.
	EndIf

	dbSelectarea("SE2")
   	dbSetOrder(1)

	//Busca a data de vencimento ISS
  	DbSeek(xFilial("SE2")+cPrefixo+cNumero+" "+"TX "+cMunic+"00")
	While (!SE2->(Eof()) .And. ((xFilial("SE2")+cPrefixo+cNumero+" "+"TX "+cMunic+"00") == ;
	                              (SE2->E2_FILIAL + SE2->E2_PREFIXO + SE2->E2_NUM + SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE + SE2->E2_LOJA)))
		If (AllTrim(SE2->E2_NATUREZ) == "ISS")
			dDtVenISS = SE2->E2_VENCREA
		EndIf
		SE2->(DbSkip())
	End


	If lRetorno .And. lLegMun
		If (nTpPrz == 1)
			dDataR := UltDia(StrZero(Month(dDataR),2), StrZero(Year(dDataR),4)) + nExcNfs
			cMsg   := STR0025 + cMunEst +  STR0028 + str(nExcNfs) + STR0029 + CHR(13)+CHR(10)+ STR0026 + DtOC(dDataR) //"O prazo para exclus鉶 de NF de servi鏾 para o munic韕io de XXXXX � de ate o dia XX do mes subsequente da emissao." " Data Limite "
		Else
			If (nTpPrz == 2)
				dDataR := SF2->F2_EMISSAO+nExcNfs
                cMsg := STR0025 + cMunEst + STR0030 + str(nExcNfs) + STR0031 + CHR(13)+CHR(10)+ STR0026 + DtOC(dDataR)  //"O prazo para exclus鉶 de NF de servi鏾 para o munic韕io de XXXXXXXX � de ate XX dias a partir da sua emiss鉶." " Data Limite "
			EndIf
		EndIf

	      //Salvador e Londrina
		If (Alltrim(cEstado) == "BA" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Salvador"}),3] == Alltrim(SM0->M0_CODMUN)) .OR.;
			(Alltrim(cEstado) == "PR" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Londrina"}),3] == Alltrim(SM0->M0_CODMUN))
			dDataR := dDataR1+40  // sempre caira no proximo mes
			If MSDATE() > UltDia(StrZero(Month(dDataR),2), StrZero(Year(dDataR),4))
				Aviso("SIGAFAT",STR0025 + cMunEst +  STR0027 + CHR(13)+CHR(10)+ STR0026 + DtOC(UltDia(StrZero(Month(dDataR),3), StrZero(Year(dDataR),4))),{"Ok"},2)//"O prazo para exclus鉶 de NF de servi鏾 para o munic韕io de Salvador - BA � de ate o ultimo dia do mes subsequente da emissao. " Data Limite "
				lRetorno:= .F.
			Else
		   		//Vencimento do ISS ja expirado somente por processo administrativo
				If (!Empty(dDtVenISS) .And. (MSDATE() > dDtVenISS))
			    	lProcAdm = .T.
			 	EndIf
			EndIf
		Else
			//tratamento para o municipio de Aracaju se maior que 72 horas(3dias), se menor n鉶 pode ter recolhido ISS
	   		If (Alltrim(cEstado) == "SE" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Aracaju"}),3] == Alltrim(SM0->M0_CODMUN))
 	   			If (MSDATE()> dDataR)
	   				Aviso("SIGAFAT",cMsg,{"Ok"},2)
					lRetorno:= .F.
	   			Else
			   		//Vencimento do ISS ja expirado somente por processo administrativo
					If (!Empty(dDtVenISS) .And. (MSDATE() > dDtVenISS))
				    	lProcAdm = .T.
				 	EndIf
			   	EndIf
			Else
				//Tratamento para Porto Velho e Rio Largo sempre por processo administrativo)
				If (Alltrim(cEstado) == "RO" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Porto Velho"}),3] == Alltrim(SM0->M0_CODMUN)) .OR.;
					(Alltrim(cEstado) == "AL" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Rio Largo"}),3] == Alltrim(SM0->M0_CODMUN))
				   	lProcAdm = .T.
				Else
					//Tratamento para Rio de Janeiro por processo administrativo)
					If ((Alltrim(cEstado) == "RJ" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Rio de Janeiro"}),3] == Alltrim(SM0->M0_CODMUN)))
						If ((!Empty(dDtVenISS) .And. (MSDATE() > dDtVenISS)) .Or. ;
							(MSDATE() > dDataR))
		              	    If ((Empty((cAlias)->F2_NFSUBST)) .AND.;
						  		(Empty((cAlias)->F2_SERSUBS)))
					 				If(lVldSbt)
										If !(MsgYesNo(STR0032)) //"Esta nota est� sem substituta. Confirma a exclus鉶?"
											lRetorno:= .F.
										Else
									   		lProcAdm = .T.
										EndIf
									Else
									   	lProcAdm = .T.
	                                EndIf
	         			 	EndIf
						EndIf
					Else
						If MSDATE()> dDataR
							Aviso("SIGAFAT",cMsg,{"Ok"},2)
							lRetorno:= .F.
						Else
							//TipoPrz==1
					 	    If(((Alltrim(cEstado) == "AL" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Macei�"}),3] == Alltrim(SM0->M0_CODMUN)) .OR.;
					          	(Alltrim(cEstado) == "CE" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Fortaleza"}),3] == Alltrim(SM0->M0_CODMUN)) .OR.;
				              	(Alltrim(cEstado) == "RN" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Natal"}),3] == Alltrim(SM0->M0_CODMUN)) .OR.;
				              	(Alltrim(cEstado) == "GO" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Goi鈔ia"}),3] == Alltrim(SM0->M0_CODMUN)) .OR.;
				              	(Alltrim(cEstado) == "PE" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Recife"}),3] == Alltrim(SM0->M0_CODMUN)) .OR.;
				              	(Alltrim(cEstado) == "PI" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Piau�"}),3] == Alltrim(SM0->M0_CODMUN)) .OR.;
				              	(Alltrim(cEstado) == "RS" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Porto Alegre"}),3] == Alltrim(SM0->M0_CODMUN)) .OR.;
				              	(Alltrim(cEstado) == "PA" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Parauapebas"}),3] == Alltrim(SM0->M0_CODMUN)) .OR.;
				              	(Alltrim(cEstado) == "MG" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Belo Horizonte"}),3] == Alltrim(SM0->M0_CODMUN)) .OR.;
				              	(Alltrim(cEstado) == "SP" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Guarulhos"}),3] == Alltrim(SM0->M0_CODMUN)) .OR.;
				              	(Alltrim(cEstado) == "MS" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Campo Grande"}),3] == Alltrim(SM0->M0_CODMUN)) .OR.;
				              	(Alltrim(cEstado) == "DF" .And. aMunic[aScan(aMunic,{|x| Alltrim(x[2])=="Bras韑ia"}),3] == Alltrim(SM0->M0_CODMUN))))
								//Vencimento do ISS ja expirado somente por processo administrativo
								If (!Empty(dDtVenISS) .And. (MSDATE() > dDtVenISS))
							    	lProcAdm = .T.
							 	Else
				              	    If ((Empty((cAlias)->F2_NFSUBST)) .AND.;
								  		(Empty((cAlias)->F2_SERSUBS)))
							 				If(lVldSbt)
												If !(MsgYesNo(STR0032)) //"Esta nota est� sem substituta. Confirma a exclus鉶?"
													lRetorno:= .F.
												Else
											   		lProcAdm = .T.
												EndIf
											Else
											   	lProcAdm = .T.
			                                EndIf
			         			 	EndIf
			         			 EndIf
							Else
								//tipoprz==2
							 	//Vencimento do ISS ja expirado somente por processo administrativo
								If (!Empty(dDtVenISS) .And. (MSDATE() > dDtVenISS))
								   	lProcAdm = .T.
								EndIf
						 	EndIf
					  	EndIf
					EndIf
				EndIf
			Endif
		EndIf
	Endif
Endif
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Verificando o Fechamento dos Estoques�
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If lRetorno .And. dDtDigit<=If(FindFunction("MVUlmes"),MVUlmes(),GetMV("MV_ULMES")) .And. !lLegMun
	Help( " ", 1, "FECHTO" )
	lRetorno := .F.
EndIf
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Verificando as pendencias de localizacoes                      �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If lRetorno .And. cPaisLoc<>"BRA" .And. !Empty((cAlias)->F2_PEDPEND)
	dbSelectArea("SC5")
	dbSetOrder(1)
	If MsSeek(xFilial("SC5")+(cAlias)->F2_PEDPEND)
		Help(" ",1,"A520PEND",,RetTitle("F2_DOC")+" "+cSerie+"/"+cNumero+Chr(13)+Chr(10)+RetTitle("C9_PEDIDO")+" "+(cAlias)->F2_PEDPEND,4,2)
		lRetorno := .F.
	EndIf
EndIf
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Verificando retornos                                           �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If lRetorno
	If !Empty(SF2->F2_CARGA) .And. !Empty(SF2->F2_SEQCAR)
		DbSelectArea("DAK")
		DbSetOrder(1)
		//Nao permite a exclusao se houve retorno
		If MsSeek(xFilial("DAK")+SF2->F2_CARGA+SF2->F2_SEQCAR)
			If DAK->DAK_ACEFIN<>"2"
				Help(" ",1,"OMS320JAFIN") //"Acerto financeiro ja efetuado"
				lRetorno := .F.
			Else
				If DAK->DAK_ACECAR<>"2"
					Help(" ",1,"OMS320JAAC") //Carga ja encerrada
					lRetorno := .F.
				Endif
			Endif
		Endif
	Endif
Endif
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Verificando as integracoes com o modulo Financeiro             �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁

If lRetorno .And. !Empty(SF2->F2_DUPL)
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Verificando as Notas de Debito ao Fornecedor                   �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	If lRetorno .And. (cAlias)->F2_TIPO=="D"
		dbSelectArea("SE2")
		dbSetOrder(6)
		#IFDEF TOP
			If TcSrvType()<>"AS/400"
				aStruSE2 := SE2->(dbStruct())
				cAliasSE2:= "MACANDELNF"

				lQuery := .T.
				cQuery := "SELECT SE2.*,SE2.R_E_C_N_O_ SE2RECNO "
				cQuery += "FROM "+RetSqlName("SE2")+" SE2 "
				cQuery += "WHERE SE2.E2_FILIAL='"+xFilial("SE2")+"' AND "
				cQuery += "SE2.E2_PREFIXO='"+cPrefixo+"' AND "
				cQuery += "SE2.E2_NUM='"+(cAlias)->F2_DUPL+"' AND "
				cQuery += "SE2.E2_FORNECE='"+cClieFor+"' AND "
				cQuery += "SE2.E2_LOJA='"+cLoja+"' AND "
				cQuery += "SE2.D_E_L_E_T_=' ' "

				cQuery := ChangeQuery(cQuery)

				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSE2,.T.,.T.)

				For nX := 1 To Len(aStruSE2)
					If aStruSE2[nX][2] <> "C"
						TcSetField(cAliasSE2,aStruSE2[nX][1],aStruSE2[nX][2],aStruSE2[nX][3],aStruSE2[nX][4])
					EndIf
				Next nX
			Else
		#ENDIF
			MsSeek(xFilial("SE2")+cClieFor+cLoja+cPrefixo+(cAlias)->F2_DUPL)
		#IFDEF TOP
			EndIf
		#ENDIF
		dbSelectArea(cAliasSE2)
		While ( !Eof() .And. xFilial("SE2") == (cAliasSE2)->E2_FILIAL .And.;
				cClieFor == (cAliasSE2)->E2_FORNECE .And.;
				cLoja == (cAliasSE2)->E2_LOJA .And.;
				cPrefixo == (cAliasSE2)->E2_PREFIXO .And.;
				(cAlias)->F2_DUPL == (cAliasSE2)->E2_NUM .And.;
				lRetorno )
			If (cAliasSE2)->E2_TIPO $ MV_CPNEG .And. AllTrim((cAliasSE2)->E2_ORIGEM) $ "MATA460N|MATA466N"

				If !FaCanDelCP(cAliasSE2,cOrigFin)
					lRetorno := .F.
					Exit
				Else
					AAdd(aLockSE2,(cAliasSE2)->E2_PREFIXO+(cAliasSE2)->E2_NUM+(cAliasSE2)->E2_PARCELA+(cAliasSE2)->E2_TIPO+(cAliasSE2)->E2_FORNECE+(cAliasSE2)->E2_LOJA)
					AAdd(aRegSE2,IIf(lQuery,(cAliasSE2)->SE2RECNO,(cAliasSE2)->(RecNo())))
				EndIf
			EndIf
			dbSelectArea(cAliasSE2)
			dbSkip()
		EndDo
		If lQuery
			dbSelectArea(cAliasSE2)
			dbCloseArea()
			dbSelectArea("SE2")
		EndIf
	EndIf

	//-- SIGATMS = Retorna Tipo do Titulo (E1_TIPO) com base no parametro MV_TMSTIPT
	If IntTms() .And. nModulo==43 .And. FindFunction("TmsTpTit")
		TmsTpTit(@cTipoParc)
	EndIf


	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Verificando os titulos a receber                               �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	dbSelectArea("SE1")
	dbSetOrder(2)
	#IFDEF TOP
		If TcSrvType()<>"AS/400"
			aStruSE1 := SE1->(dbStruct())
			cAliasSE1:= "MACANDELNF"

			lQuery := .T.
			cQuery := "SELECT SE1.*,SE1.R_E_C_N_O_ SE1RECNO "
			cQuery += "FROM "+RetSqlName("SE1")+" SE1 "
			cQuery += "WHERE SE1.E1_FILIAL='"+xFilial("SE1")+"' AND "
			cQuery += "SE1.E1_PREFIXO='"+cPrefixo+"' AND "
			cQuery += "SE1.E1_NUM='"+(cAlias)->F2_DUPL+"' AND "
			cQuery += "SE1.E1_CLIENTE='"+cClieFor+"' AND "
			cQuery += "SE1.E1_LOJA='"+cLoja+"' AND "
			cQuery += "SE1.D_E_L_E_T_=' ' "

			cQuery := ChangeQuery(cQuery)

			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSE1,.T.,.T.)

			For nX := 1 To Len(aStruSE1)
				If aStruSE1[nX][2] <> "C"
					TcSetField(cAliasSE1,aStruSE1[nX][1],aStruSE1[nX][2],aStruSE1[nX][3],aStruSE1[nX][4])
				EndIf
			Next nX
		Else
	#ENDIF
		MsSeek(xFilial("SE1")+cClieFor+cLoja+cPrefixo+(cAlias)->F2_DUPL)
	#IFDEF TOP
		EndIf
	#ENDIF
	dbSelectArea(cAliasSE1)

	#IFDEF TOP
		If cPaisLoc $ "BRA|MEX" .and. FunName() = "MATA521A"

    	    // 1- Tem apenas Adiantamento ...

			lAlvoCERTO := .F.

			if (cAlias)->F2_TIPO != "D"
				if lRetorno .And. (cAliasSE1)->(!Eof())
					if (cAliasSE1)->E1_VALOR <> (cAliasSE1)->E1_SALDO
						if A410UsaAdi((cAlias)->F2_COND)
							If AliasInDic("FR3") .And. AliasInDic("FIE")

								cQ := "SELECT SUM(FR3_VALOR) AS FR3_VALOR "
								cQ += "FROM "+RetSqlName("FR3")+" "
								cQ += "WHERE FR3_FILIAL = '"+xFilial("FR3")+"' "
								cQ += "AND FR3_CART = 'R' "
								cQ += "AND FR3_TIPO IN "	+FormatIn(MVRECANT,"/")+" "
								cQ += "AND FR3_CLIENT = '"	+SF2->F2_CLIENTE+"' "
								cQ += "AND FR3_LOJA = '"	+SF2->F2_LOJA+"' "
								cQ += "AND FR3_DOC = '"		+SF2->F2_DOC+"' "
								cQ += "AND FR3_SERIE = '"	+SF2->F2_SERIE+"' "
								cQ += "AND D_E_L_E_T_= ' ' "

								cQ := ChangeQuery(cQ)

								dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQ),"TRBFR3",.T.,.T.)

								TcSetField("TRBFR3","FR3_VALOR","N",TamSX3("FR3_VALOR")[1],TamSX3("FR3_VALOR")[2])

								nValorAdtFR3 := TRBFR3->FR3_VALOR

								TRBFR3->(dbCloseArea())

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//� compara o valor baixado para o titulo ( E1_VALOR - E1_SALDO ), com o valor dos adiantamentos. Se o valor for igual, continua a exclusao   �
//� do documento, se o valor for diferente eh porque houveram outras baixas para o titulo, neste caso, nao eh possivel excluir o documento,   �
//� primeiro deve-se excluir estas outras baixas no Financeiro.  												                                           �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪睦哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪睦哪哪哪哪哪�
								//Para o M閤ico os adiantamentos s鉶 baixados e n鉶 compensados. Portanto se houver adiantamentos apenas estorna a baixa.
								If (cPaisLoc != "MEX" .AND. (cAliasSE1)->(E1_VALOR-E1_SALDO) = nValorAdtFR3) .OR. (cPaisLoc == "MEX" .AND. nValorAdtFR3 > 0)
									If !ApMsgYesNo(STR0020 + CRLF+ STR0021) //"Por tratar-se de condi玢o de pagamento com Adiantamento, a exclus鉶 do Documento de Sa韉a tamb閙 ir� excluir a compensa玢o do(s) t韙ulo(s) de adiantamento associado(s) a este Documento de Saida no momento da sua gera玢o."#CRLF#"Deseja continuar?"
										lRetorno := .F.
						   			Endif
						   		Else
									lRetorno := .F.
							   		Help(" ",1,"FA040BAIXA")
								Endif

		                    	lAlvoCERTO := .T.
							Endif
						Endif
					Endif
				Endif
			Endif

			If !Empty((cAliasSE1)->E1_BAIXA)	  .And.(cAliasSE1)->E1_SALDO = 0  .And. !lAlvoCERTO
				lRetorno := .F.
		   		Help(" ",1,"FA040BAIXA")
            Elseif !Empty((cAliasSE1)->E1_BAIXA) .And.(cAliasSE1)->E1_VALOR <> (cAliasSE1)->E1_SALDO .And. !lAlvoCERTO
	   			lRetorno := .F.
				Help(" ",1,"BAIXAPARC")
			Endif

		Endif

		dbSelectArea(cAliasSE1)

	#ENDIF

	While ( !Eof() .And. xFilial("SE1") == (cAliasSE1)->E1_FILIAL .And.;
			cClieFor == (cAliasSE1)->E1_CLIENTE .And.;
			cLoja == (cAliasSE1)->E1_LOJA .And.;
			cPrefixo == (cAliasSE1)->E1_PREFIXO .And.;
			(cAlias)->F2_DUPL == (cAliasSE1)->E1_NUM .And.;
			lRetorno )

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� se for nota fiscal com adiantamento compensado, valida se a nota fiscal tem somente uma parcela no contas a receber                                          �
		//� se for somente 1 parcela, segue o cancelamento e nao valida se o titulo estah baixado, pois a compensacao desta parcela vai ser desfeita na rotina MaDelNfs  �
		//� se for mais de uma parcela, valida as parcelas a partir da segunda, para checar se hah alguma parcela baixada                                                �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪睦哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪睦哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁

		//	Criterio "!Empty(SE1->E1_BAIXA)" alterado:
		//  1- Exclusao da NFS sem baixa - Campo E1_BAIXA" esta com a data de baixa
		//  2- Exclusao da NFS com cancelamento de baixa - Campo E1_BAIXA" esta vazio
		//  If !Empty((cAliasSE1)->E1_BAIXA) .and. (cAliasSE1)->E1_VALOR != (cAliasSE1)->E1_SALDO  //tem baixa para o adiantamento


		#IFDEF TOP

		If cPaisLoc == "BRA" .and. FunName() = "MATA521A"
			If (cAlias)->F2_TIPO != "D"
				If nCountSE1 = 0
					If A410UsaAdi((cAlias)->F2_COND) .and. AliasInDic("FR3") .and. AliasInDic("FIE")
		   				If (cAliasSE1)->E1_VALOR != (cAliasSE1)->E1_SALDO  //tem baixa para o adiantamento
		   					lPriParAdtBx := .T.
		   				Endif
			   		Endif
			   	Endif
		   	Endif
		Endif

		#ENDIF

		If (cAliasSE1)->E1_TIPO $ IIf(cPaisLoc == "BRA",cTipoParc,cEspecie)

			If IIf((cPaisLoc == "BRA" .and. FunName() = "MATA521A" .and. lPriParAdtBx),.F.,!FaCanDelCR(cAliasSE1,cOrigFin))
				lRetorno := .F.
				Exit
			Else
				AAdd(aLockSE1,(cAliasSE1)->E1_CLIENTE+(cAliasSE1)->E1_LOJA+(cAliasSE1)->E1_PREFIXO+(cAliasSE1)->E1_NUM+(cAliasSE1)->E1_PARCELA+(cAliasSE1)->E1_TIPO)
				AAdd(aRegSE1,IIf(lQuery,(cAliasSE1)->SE1RECNO,(cAliasSE1)->(RecNo())))
			EndIf
		EndIf

		//
		// Template de GEM - Gestao de Empreendimentos Imobiliarios
		//
		// Verifica se a condicao de pagamento tem vinculacao com uma condicao de venda
		//
		If ExistTemplate("GMCondPagto")
			lCondVenda := ExecTemplate("GMCondPagto",.F.,.F.,{(cAlias)->F2_COND,(cAliasSE1)->E1_TIPO } )

			If lCondVenda
				If IIf((cPaisLoc == "BRA" .and. FunName() = "MATA521A" .and. lPriParAdtBx),.F.,!FaCanDelCR(cAliasSE1,cOrigFin))
					lRetorno := .F.
					Exit
				Else
					AAdd(aLockSE1,(cAliasSE1)->E1_CLIENTE+(cAliasSE1)->E1_LOJA+(cAliasSE1)->E1_PREFIXO+(cAliasSE1)->E1_NUM+(cAliasSE1)->E1_PARCELA+(cAliasSE1)->E1_TIPO)
					AAdd(aRegSE1,IIf(lQuery,(cAliasSE1)->SE1RECNO,(cAliasSE1)->(RecNo())))
				EndIf
			EndIf

			lCondVenda := .F.

		EndIf
		If lMa520SE1 .And. lRetorno
			ExecBlock("MA520SE1",.F.,.F.)
		Endif
		lPriParAdtBx := .F.
		nCountSE1++

		dbSelectArea(cAliasSE1)
		dbSkip()
	EndDo
	If lQuery
		dbSelectArea(cAliasSE1)
		dbCloseArea()
		dbSelectArea("SE1")
	EndIf
EndIf
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Verifica se a NFS gerou Imposto ICMS ST(Contas a Pagar)     �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If cPaisloc=="BRA" .And. SF2->(FieldPos("F2_NFICMST"))>0
	If !Empty(SF2->F2_NFICMST)//Caso nao seja vazio, gerou imposto ICMS ST
		DbSelectArea("SE2")
		SE2->(DbsetOrder(1))//Indice E2_FILIAL+E2_PREFIXO+E2_NUM+E2_SERIE+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA
		SE2->(DbGoTop())
		If DbSeek(xFilial("SE2")+SF2->F2_NFICMST)
			Do While SE2->(!Eof()) .And. SE2->E2_PREFIXO+SE2->E2_NUM==SF2->F2_NFICMST
				//Se o titulo sofreu pagamento nao permitir excluir a NFS
				If !Empty(SE2->E2_BAIXA).And. SE2->E2_SALDO<>SE2->E2_VALOR .And. ALLTRIM(SE2->E2_TIPO)=="TX"
					cMensagem:=" N鉶 � poss韛el excluir esse documento pelo fato "+CHR(10)+CHR(13)
					cMensagem+="de que existe um t韙ulo a pagar de imposto "+CHR(10)+CHR(13)
					cMensagem+="( "+SE2->E2_NUM+"/"+SE2->E2_PREFIXO+") baixado total ou parcialmente."+CHR(10)+CHR(13)
					cMensagem+="Para excluir esse documento, ser� necess醨io "+CHR(10)+CHR(13)
					cMensagem+="primeiramente estornar esse t韙ulo atrav閟 "+CHR(10)+CHR(13)
					cMensagem+="do m骴ulo financeiro."
					Help(" ",1,"NAOEXCNFS","NAOEXCNFS",cMensagem,1,0)
					lRetorno := .F.
				ElseIf !Empty(SE2->E2_NUMBOR) .And. ALLTRIM(SE2->E2_TIPO)=="TX"
						cMensagem:=" N鉶 � poss韛el excluir esse documento pelo fato "+CHR(10)+CHR(13)
						cMensagem+="de que existe um t韙ulo a pagar de imposto "+CHR(10)+CHR(13)
						cMensagem+="( "+SE2->E2_NUM+"/"+SE2->E2_PREFIXO+") em Border�."+CHR(10)+CHR(13)
						cMensagem+="Para excluir esse documento, ser� necess醨io "+CHR(10)+CHR(13)
						cMensagem+="primeiramente estornar esse t韙ulo atrav閟 "+CHR(10)+CHR(13)
						cMensagem+="do m骴ulo financeiro."
						Help(" ",1,"NAOEXCNFS","NAOEXCNFS",cMensagem,1,0)
						lRetorno := .F.
				Endif
				SE2->(DbSkip())
			End
		Endif
	Endif
Endif
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Verificando os itens do documento de Saida                     �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If lRetorno
	dbSelectArea("SD2")
	dbSetOrder(3)
	#IFDEF TOP
		If TcSrvType()<>"AS/400"
			aStruSD2  := SD2->(dbStruct())
			cAliasSD2 := "MACANDELNF"
			lQuery    := .T.

			cQuery := "SELECT SD2.*,SD2.R_E_C_N_O_ SD2RECNO,SF4.F4_PODER3,SF4.F4_ESTOQUE "
			cQuery += "FROM "+RetSqlName("SD2")+" SD2,"
			cQuery += RetSqlName("SF4")+" SF4 "
			cQuery += "WHERE SD2.D2_FILIAL='"+xFilial("SD2")+"' AND "
			cQuery += "SD2.D2_SERIE='"+cSerie+"' AND "
			cQuery += "SD2.D2_DOC='"+cNumero+"' AND "
			cQuery += "SD2.D2_CLIENTE='"+cClieFor+"' AND "
			cQuery += "SD2.D2_LOJA='"+cLoja+"' AND "
			cQuery += "SD2.D2_TIPO='"+cTipo+"' AND "
			cQuery += "SD2.D_E_L_E_T_= ' ' AND "
			cQuery += "SF4.F4_FILIAL='"+xFilial("SF4")+"' AND "
			cQuery += "SF4.F4_CODIGO=SD2.D2_TES AND "
			cQuery += "SF4.D_E_L_E_T_= ' '"

			cQuery += "ORDER BY "+SqlOrder(SD2->(IndexKey()))

			cQuery := ChangeQuery(cQuery)

			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD2,.T.,.T.)

			For nX := 1 To Len(aStruSD2)
				If aStruSD2[nX][2] <> "C"
					TcSetField(cAliasSD2,aStruSD2[nX][1],aStruSD2[nX][2],aStruSD2[nX][3],aStruSD2[nX][4])
				EndIf
			Next nX
		Else
	#ENDIF
		MsSeek(xFilial("SD2")+cNumero+cSerie+cClieFor+cLoja)
	#IFDEF TOP
		EndIf
	#ENDIF
	While ( !Eof() .And. xFilial("SD2") == (cAliasSD2)->D2_FILIAL .And.;
			cNumero == (cAliasSD2)->D2_DOC .And.;
			cSerie == (cAliasSD2)->D2_SERIE .And.;
			cClieFor == (cAliasSD2)->D2_CLIENTE .And.;
			cLoja == (cAliasSD2)->D2_LOJA .And. lRetorno )

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Verificando se for remito de transferencia que ja teve entrada   �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If cPaisLoc !="BRA" .And. (cAliasSD2)->D2_TIPODOC == "54" .And. (cAliasSD2)->D2_QTDAFAT != (cAliasSD2)->D2_QUANT
			Help(" ",1,"NAOEXCLREM")
			lRetorno := .F.
			Exit
		EndIf
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Verificando os embarques do modulo de exportacao - SIGAEEC     �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If (cAliasSD2)->(FieldPos("D2_PREEMB"))>0
			If !Empty((cAliasSD2)->D2_PREEMB) .And. NMODULO <> 29
				Help(" ",1,"MTA520DEL")
				lRetorno := .F.
				Exit
			EndIf
		EndIf
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Verificando se este documento possui itens devolvidos          �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If (cAliasSD2)->D2_QTDEDEV <> 0 .Or. (cAliasSD2)->D2_VALDEV<>0
			Help(" ",1,"NAOEXCL")
			lRetorno := .F.
			Exit
		EndIf
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Verifica se eh um remito ja faturado (Localizacoes)            �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If (cAliasSD2)->D2_QTDEFAT > 0
			Help(" ",1,"NAOEXCLREM")
			lRetorno := .F.
			Exit
		EndIf

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Verifica se as notas n鉶 foram geradas pelo faturamento        �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If (cAliasSD2)->D2_ORIGLAN $ "LF|LO"
		    Aviso(OemtoAnsi(STR0011),OemtoAnsi(STR0012),{OemtoAnsi(STR0013)})
			lRetorno := .F.
			Exit
		Endif

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Verifica o Servico do WMS    						         	  �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If cPaisLoc <> "BRA" .And. !LocIntDCF(cAliasSD2,.F.)
			lRetorno := .F.
			Exit
		EndIf
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Verificando os saldos do poder de terceiros                    �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If !lQuery
			dbSelectArea("SF4")
			dbSetOrder(1)
			MsSeek(xFilial("SF4")+(cAliasSD2)->D2_TES)
		EndIf
		If (IIf(lQuery,(cAliasSD2)->F4_PODER3=="R",SF4->F4_PODER3=="R"))
			dbSelectArea("SB6")
			dbSetOrder(1)
			If MsSeek(xFilial("SB6")+(cAliasSD2)->D2_COD+cClieFor+cLoja+(cAliasSD2)->D2_IDENTB6)
				If SB6->B6_QUANT <> CalcTerc((cAliasSD2)->D2_COD,cClieFor,cLoja,(cAliasSD2)->D2_IDENTB6,(cAliasSD2)->D2_TES)[1]
					Help(" ",1,"A520NPODER")
					lRetorno := .F.
					Exit
				EndIf
			EndIf
		EndIf
		If (IIf(lQuery,(cAliasSD2)->F4_ESTOQUE=="S",SF4->F4_ESTOQUE=="S"))
			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
			//� Verifica se o produto est� sendo inventariado  �
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
			If BlqInvent((cAliasSD2)->D2_COD,(cAliasSD2)->D2_LOCAL)
				Help(" ",1,"BLQINVENT",,(cAliasSD2)->D2_COD+" Almox: "+(cAliasSD2)->D2_LOCAL,1,11)
				lRetorno := .F.
				Exit
			EndIf
        EndIf
		If (SC9->(FieldPos("C9_NUMSEQ"))<>0 .And. !Empty(SC9->C9_NUMSEQ) )
			dbSelectArea("SC9")
			dbSetOrder(7)
			If MsSeek(xFilial("SC9")+(cAliasSD2)->D2_COD+(cAliasSD2)->D2_LOCAL+(cAliasSD2)->D2_NUMSEQ) .And. SC9->C9_BLEST == "ZZ" .And. !Empty(SC9->C9_NUMSEQ)
				Help(" ",1,"A520NEST")
				lRetorno := .F.
				Exit
			EndIf
		EndIf
		If lRetorno
			If aScan(aLockSB2,(cAliasSD2)->D2_COD+(cAliasSD2)->D2_LOCAL)==0
				AAdd(aLockSB2,(cAliasSD2)->D2_COD+(cAliasSD2)->D2_LOCAL)
			EndIf
			If aScan(aLockSC5,(cAliasSD2)->D2_PEDIDO)==0
				AAdd(aLockSC5,(cAliasSD2)->D2_PEDIDO)
			EndIf
		EndIf
		AAdd(aRegSD2,IIf(lQuery,(cAliasSD2)->SD2RECNO,(cAliasSD2)->(RecNo())))
		dbSelectArea(cAliasSD2)
		dbSkip()
	EndDo
	If lQuery
		dbSelectArea(cAliasSD2)
		dbCloseArea()
		dbSelectArea("SD2")
	EndIf
EndIf
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Verifica os documentos de Origem                               �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If SF2->(FieldPos("F2_NEXTSER"))<>0 .And. !Empty(SF2->F2_NEXTDOC)
	dbSelectArea("SF2")
	dbSetOrder(6)
	If MsSeek(xFilial("SF2")+SF2->F2_SERIE+SF2->F2_DOC)
		Help(" ",1,"MA521NFORI")
		lRetorno := .F.
	EndIf
EndIf
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Efetuando o travamento dos registros                           �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If lRetorno .And. !InTransact()
	If MultLock("SF2",{(cAlias)->F2_DOC+(cAlias)->F2_SERIE+(cAlias)->F2_CLIENTE+(cAlias)->F2_LOJA},1) .And.;
			MultLock("SB2",aLockSB2,1) .And.;
			MultLock("SC5",aLockSC5,1) .And.;
			MultLock("SE1",aLockSE1,2) .And.;
			MultLock("SE2",aLockSE2,1) .And.;
			MultLock(IIf((cAlias)->F2_TIPO$"DB","SA2","SA1"),{(cAlias)->F2_CLIENTE+(cAlias)->F2_LOJA},1)
	Else
		MsUnLockAll()
		lRetorno := .F.
	EndIf
EndIf

//Verifica se a factura esta "amarrada" a alguma solicitacao, caso esteja nao
//permite o seu cancelamento...
If lRetorno .And. (cPaisLoc <> "BRA") .And. SuperGetMv('MV_SOLNCP')
	aAreaSCU := SCU->(GetArea())
	SCU->(dbSetOrder(3))
	If SCU->(MsSeek(xFilial()+SF2->F2_CLIENTE+SF2->F2_LOJA+SF2->F2_DOC+SF2->F2_SERIE))
		Help(" ",1,"MA055007")
		lRetorno :=	.F.
	EndIf
	RestArea(aAreaSCU)
EndIf

If lRetorno
	If ExistBlock("M521CDEL")
		lRetorno := ExecBlock("M521CDEL",.F.,.F.)
	Endif

	If lProcAdm
		lRetorno := T521Tela(SF2->F2_DOC,SF2->F2_SERIE,"     ",SF2->F2_CLIENTE,SF2->F2_LOJA,"S",SF2->F2_TIPO)
    EndIf

Endif

RestArea(aAreaSF2)
RestArea(aAreaSD2)
RestArea(aAreaSE2)
RestArea(aAreaSE1)
RestArea(aAreaSB6)
RestArea(aArea)
Return(lRetorno)

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rogram   矼aDelNFS  � Rev.  矱duardo Riera          � Data �30.12.2001	潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噮o 矱storno da Preparacao dos Documentos de Saida              	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   矱xpL1: Indica se o documento pode ser excluido              	潮�
北�          �                                                            	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros矱xpA1: Array com os Recnos do SD2                        (OPC)潮�
北�          矱xpA2: Array com os Recnos do SE1                        (OPC)潮�
北�          矱xpA3: Array com os Recnos do SE2                        (OPC)潮�
北�          矱xpL4: Mostra lancto contabil                            (OPC)潮�
北�          矱xpL5: Aglutina lancto contabil                          (OPC)潮�
北�          矱xpL6: Contabiliza On-Line                               (OPC)潮�
北�          矱xpL7: Pedido em carteira                                (OPC)潮�
北�          矱xpL8: Indica se estou apagando um remito                (OPC)潮�
北�          矱xpL9: Usado para o controle de localizacao fisica.           潮�
北�          �       para forcar o parametro (MV_PDEVLOC)                   潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                       潮�
北媚哪哪哪哪哪哪穆哪哪哪哪履哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� PROGRAMADOR  � DATA   � BOPS �  MOTIVO DA ALTERACAO                     潮�
北媚哪哪哪哪哪哪呐哪哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� Norbert Waage�16/05/07�125161矨tualizacao do status do orcamento do     潮�
北�              �        �      砊elevendas(SIGATMK), apos exclusao da NF. 潮�
北滥哪哪哪哪哪哪牧哪哪哪哪聊哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
Static Function MaDelNfs(aRegSD2,aRegSE1,aRegSE2,lDigita,lAglutina,lContab,lCarteira,lRemito,nPDevLoc,cCodDiario)

Local aArea     := GetArea()
Local aCusto    := {}
Local aCT5      := {}
Local aSd2Carga := {}
Local aRotas    := {}
Local aPedido   := {}
Local nX        := 0
Local nHdlPrv   := 0
Local nTotalCtb := 0
Local nRegSF2   := 0
Local lQuery    := .F.
Local lMSd2520T := ExistTemplate("MSD2520")
Local lMSd2520  := ExistBlock("MSD2520")
Local lM521Cart := ExistBlock("M521CART")
Local lMs520Del := Existblock("MS520DEL")
Local lHeader   := .F.
Local lDetProva := .F.
Local lLctPad30 := VerPadrao("630")	// Credito de Estoque / Debito de C.M.V.
Local lLctPad35 := VerPadrao("635")	// Debito de Cliente  / Credito de Venda
Local lLctPad41 := VerPadrao("641") // Itens de rateio.
Local cLoteCtb  := ""
Local cArqCtb   := ""
Local c630      := Nil
Local c635      := Nil
Local c641      := Nil
Local cAliasSC9 := "SC9"
Local cDepTrf   := GetNewPar("MV_DEPTRANS","95")  // Dep.transferencia
Local lSelLote  := GetNewPar("MV_SELLOTE","2") == "1"
Local lFreteEmb := .F.
Local aAreaTmp
Local aAreaSC5
Local aAreaSC6
Local aAreaSC9
Local aAreaSD2
Local nPrcVen
#IFDEF TOP
	Local cQuery := ""
#ENDIF
Local cPedRem    := ""
Local cItPedRem  := ""
Local cSeqPedRem := ""
Local lRelibWMS  := (SuperGetMV('MV_WMSRELI', .F., '1')=='2')
Local cEndRelWms := ''
Local cEndAnt    := ''
Local cServAnt   := ''
Local cSeekSDB   := ''
Local cFilcar    := ""
Local cBlock     := 'Oms521Car(aSd2Carga,aRotas,cFilCar)'
Local bBlock     := {||.T.}
Local cRetPE     := ''
Local lContinua := .T.
//Gestao de Contratos
Local aContrato  := {}
Local aAreaSD1   := {}
Local aCtbDia    := {}
Local lCtbInTran := IIf(FindFunction("CTBINTRAN") .And. CTBINTRAN(0,.F.),.T.,.F.)	// Verifica se contabilizacao pode ser executada dentro da transacao
Local lIntACD	 := SuperGetMV("MV_INTACD",.F.,"0") == "1"
Local aEmpBN     := {}
Local lAtuSldNat := FindFunction("AtuSldNat") .AND. AliasInDic("FIV") .AND. AliasInDic("FIW")
Local aAreaAt	 := {}
Local lMontaVol  := SuperGetMV('MV_WMSVEMB',.F.,.F.)

//Venda Direta
Local lAuto		 := .F.
Local cFOrcPai 	 := ""
Local cNOrcPai	 := ""
Local aPedBkp	 := {}
Local lIntGC	 := IIf((SuperGetMV("MV_VEICULO",,"N")) == "S",.T.,.F.)

Local oMdl		 := Nil
Local oMdlCarga  := Nil
Local lIntGFE    := SuperGetMv("MV_INTGFE",,.F.)
Local cCarga	 := ""
Local cAliasSF2  := ""
Local aStruModel := {}
Local aFieldValue:= {}
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//砊ratamento para e-Commerce      �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
Local lECommerce := SuperGetMV("MV_LJECOMM",,.F.) .AND. GetRpoRelease("R5")
Local aRegSC5    := {}     //Ira gravar s pedidos e-Commerce para liberar no final da rotina
Local lLiberOk   := .F.    //Variavel utilizada para liberar o pedido no final da rotina

DEFAULT lDigita    := .F.
DEFAULT lAglutina  := .F.
DEFAULT lContab    := .F.
DEFAULT lCarteira  := .T.
DEFAULT lRemito    := .F.
DEFAULT cCodDiario := ""
// PRIVATE lAnulaSF3  := .F.  //Determina se anula ou exclui o registro no Livro Fiscal(MaFisAtuSF3) - Localizacoes

lAnulaSF3  := IIf( Type("lAnulaSF3")=="U",.F.,lAnulaSF3)

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//� Se o parametro de Reliberacao do WMS (MV_WMSRELI) estiver ativo, ativa tb o parametro de Selecao de Lotes do Faturamento (MV_SELLOTE) �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
lSelLote := If(!lRelibWMS, lSelLote, .T.)

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Verifica se o documento foi contabilizado                    �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If lContab .And. !Empty(SF2->F2_DTLANC)
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Verifica o numero do lote contabil                           �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	dbSelectArea("SX5")
	dbSetOrder(1)
	If MsSeek(xFilial()+"09FAT")
		cLoteCtb := AllTrim(X5Descri())
	Else
		cLoteCtb := "FAT "
	EndIf
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Executa um execblock                                         �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	If At("EXEC",Upper(X5Descri())) > 0
		cLoteCtb := &(X5Descri())
	EndIf
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Inicializa o arquivo de contabilizacao                       �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	nHdlPrv:=HeadProva(cLoteCtb,"CTBANFS",cUserName,@cArqCtb)
	If nHdlPrv <= 0
		HELP(" ",1,"SEM_LANC")
	Else
		lHeader := .T.
	EndIf
EndIf
If FindFunction("MaEnvEAI")
	oMdl := MaEnvEAI(,,5,"MATA521",,,.F.)
EndIf
Begin Transaction
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Se for processo de adiantamento e o titulo estiver baixado   �
	//� exclui a compensacao                                         �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	#IFDEF TOP
		If cPaisLoc == "BRA" .and. FunName() = "MATA521A"
			If Len(aRegSE1) > 0
				If A410UsaAdi(SF2->F2_COND) .and. AliasInDic("FR3") .and. AliasInDic("FIE")
					SE1->(MsGoto(aRegSE1[1]))
					If SE1->(Recno()) = aRegSE1[1]
				//
				//		Criterio "!Empty(SE1->E1_BAIXA)" alterado:
				//		1- Exclusao da NFS sem baixa - Campo E1_BAIXA" esta com data
				//		2- Exclusao da NFS com cancelamento de baixa - Campo E1_BAIXA" esta vazio
				//		If !Empty(SE1->E1_BAIXA) .and. SE1->E1_VALOR != SE1->E1_SALDO
				//
						If SE1->E1_VALOR != SE1->E1_SALDO
							If !A521CCompAd(aRegSE1)
								Aviso(STR0007,STR0022 + CRLF + STR0023,{"Ok"}) //"Aten玢o"#"N鉶 foi poss韛el excluir a compensa玢o associada ao t韙ulo deste Documento de Sa韉a."#"N鉶 ser� poss韛el excluir o Documento de Sa韉a."
								DisarmTransaction()
								RestArea(aArea)

								Return(.F.)
							Endif
						Endif
					Endif
				Endif
			Endif
		// Para o Mexico faz a baixa simples ao inves da compensa玢o pois n鉶 h� t韙ulo.
		ElseIf cPaisLoc == "MEX" .AND. A410UsaAdi(SF2->F2_COND) .AND. AliasInDic("FR3") .AND. AliasInDic("FIE")
			If !A521CBxAdt()
				Aviso("Aten玢o","N鉶 foi poss韛el excluir a baixa do adiantamento associado ao Documento de Sa韉a." + CRLF + "N鉶 ser� poss韛el excluir o Documento de Sa韉a.",{"OK"}) //"Aten玢o"#"N鉶 foi poss韛el excluir a baixa do adiantamento associado ao Documento de Sa韉a."#"N鉶 ser� poss韛el excluir o Documento de Sa韉a."#OK
				DisarmTransaction()
				RestArea(aArea)
				Return(.F.)
			Endif
		Endif
	#ENDIF

	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Verifica se a NFS gerou Imposto ICMS ST                      �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	If cPaisLoc=="BRA"
		DbSelectArea("SE2")
		SE2->(DbsetOrder(1))//Indice E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA
		SE2->(DbGoTop())
		If SF2->(FieldPos("F2_NFICMST"))>0 .AND. !Empty(SF2->F2_NFICMST)//Caso nao seja vazio, gerou imposto ICMS ST
			If DbSeek(xFilial("SE2")+SF2->F2_NFICMST)
				Do While SE2->(!Eof()).And. SE2->E2_PREFIXO+SE2->E2_NUM==SF2->F2_NFICMST
						If SE2->E2_ORIGEM=="MATA460A" .And. Alltrim(SE2->E2_TIPO)=="TX"
							RecLock("SE2")
							SE2->(dbDelete())
							SE2->(MsUnLock())
						Endif
					SE2->(DbSkip())
				End
			Endif
		EndIf
		If SF2->(FieldPos("F2_NTFECP"))>0 .AND. !Empty(SF2->F2_NTFECP)//Caso nao seja vazio, gerou imposto ICMS ST
			If DbSeek(xFilial("SE2")+SF2->F2_NTFECP)
				Do While SE2->(!Eof()).And. SE2->E2_PREFIXO+SE2->E2_NUM==SF2->F2_NTFECP
						If SE2->E2_ORIGEM=="MATA460A" .And. Alltrim(SE2->E2_TIPO)=="TX"
							RecLock("SE2")
							SE2->(dbDelete())
							SE2->(MsUnLock())
						Endif
					SE2->(DbSkip())
				End
			Endif
		Endif
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		//� Exclus鉶 dos Titulos gerados pela TPDP - PB   �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		If DbSeek(xFilial("SE2")+SF2->F2_SERIE+SF2->F2_DOC) .And. Alltrim(SE2->E2_NATUREZ)=="TPDP"
			Do While SE2->(!Eof()).And. SE2->E2_PREFIXO+SE2->E2_NUM==SF2->F2_SERIE+SF2->F2_DOC
				If AllTrim(SE2->E2_ORIGEM)=="MATA460" .And. Alltrim(SE2->E2_TIPO)=="TX" .And. Alltrim(SE2->E2_NATUREZ)=="TPDP"
					RecLock("SE2")
					SE2->(dbDelete())
					SE2->(MsUnLock())
				Endif
				SE2->(DbSkip())
			End
		EndIf
	Endif
	If ExistTemplate("GEMXEXCON",,.T.)
		ExecTemplate("GEMXEXCON",.F.,.F.,{aRegSD2,aRegSE1})
	EndIf
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Posiciona Registros                                            �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	dbSelectArea("SF2")
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Verifica se a NFS gerou Guia ICMS ST                         �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	DbSelectArea("SF6")
	SF6->(DbsetOrder(3))//Indice F6_FILIAL+F6_OPERNF+F6_TIPODOC+F6_DOC+F6_SERIE+F6_CLIFOR+F6_LOJA
	SF6->(DbGoTop())
	If DbSeek(xFilial("SF6")+"2"+SF2->F2_TIPO+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA)
	   While !SF6->(Eof()) .AND. xFilial("SF6") == SF2->F2_FILIAL .AND. SF6->F6_OPERNF=="2" .AND.;
		SF6->F6_TIPODOC == SF2->F2_TIPO .AND. SF6->F6_DOC== SF2->F2_DOC .AND.;
		SF6->F6_SERIE == SF2->F2_SERIE .AND. SF6->F6_CLIFOR==SF2->F2_CLIENTE .AND.;
		SF6->F6_LOJA==SF2->F2_LOJA
			RecLock("SF6")
			SF6->(dbDelete())
			SF6->(MsUnLock())
	   		SF6->(DbSkip())
		EndDo
	Endif
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Verifica se a NFS gerou Complemento da Guia                  �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	If cPaisLoc=="BRA".And. SF2->(FieldPos("F2_NFICMST"))>0
		If ChkFile("CDC")
			DbSelectArea("CDC")
			CDC->(DbSetOrder(1))//Indice CDC_FILIAL+CDC_TPMOV+CDC_DOC+CDC_SERIE+CDC_CLIFOR+CDC_LOJA+CDC_GUIA+CDC_UF
			If DbSeek(xFilial("CDC")+"S"+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA+SF2->F2_NFICMST+SF2->F2_EST)
				RecLock("CDC")
				CDC->(dbDelete())
				CDC->(MsUnLock())
			Endif
		Endif
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Exclusao da tabela CDL (Complemento de Exportacao) �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If ChkFile("CDL")
			aAreaAt:=GetArea()
			DbSelectArea("CDL")
			CDL->(DbSetOrder(1))
			If DbSeek(xFilial("CDL")+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA)//+SF2->F2_NFICMST+SF2->F2_EST)
				While !Eof() .And. xFilial("CDL")+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA ==;
			    		CDL_FILIAL+CDL_DOC+CDL_SERIE+CDL_CLIENT+CDL_LOJA
					RecLock("CDL")
					CDL->(dbDelete())
					CDL->(MsUnLock())
					CDL->(DbSkip())
				EndDo
			Endif
			RestArea(aAreaAt)
		Endif
	Endif
	dbSelectArea("SF2")
	If SF2->F2_TIPO$"DB"
		dbSelectArea("SA2")
		dbSetOrder(1)
		MsSeek(xFilial("SA2")+SF2->F2_CLIENTE+SF2->F2_LOJA)
	Else
		dbSelectArea("SA1")
		dbSetOrder(1)
		MsSeek(xFilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA)
	EndIf
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Executa os lancamentos contabeis ( 635 ) - Cabecalho         �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	If lLctPad35 .And. lHeader
		lDetProva := .T.
		nTotalCtb += DetProva(nHdlPrv,"635","MATA520",cLoteCtb,,,,,@c635,@aCT5)
	EndIf
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Cancelamento dos titulos financeiros gerados                   �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	For nX := 1 To Len(aRegSE1)
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Posiciona nos titulos financeiros                              �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		SE1->(MsGoto(aRegSE1[nX]))
		FaAvalSE1(2,"MATA520",,nX)
		If lAtuSldNat
			AtuSldNat(SE1->E1_NATUREZ, SE1->E1_VENCREA, SE1->E1_MOEDA, If(SE1->E1_TIPO$MVRECANT+"/"+MV_CRNEG,"3","2"), "R", SE1->E1_VALOR, SE1->E1_VLCRUZ, If(SE1->E1_TIPO$MVABATIM,"+","-"),,FunName(),"SE1", SE1->(Recno()),0)
		Endif
		RecLock("SE1")
		SE1->(dbDelete())
		FaAvalSE1(3,"MATA520")
	Next nX
	For nX := 1 To Len(aRegSE2)
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Posiciona nos titulos financeiros                              �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		SE2->(MsGoto(aRegSE2[nX]))
		FaAvalSE2(2,"MATA520")
		RecLock("SE2")
		SE2->(dbDelete())
		FaAvalSE2(3,"MATA520")
	Next nX
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Cancelamento dos itens do documento de saida                   �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	For nX := 1 To Len(aRegSD2)
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Posiciona registros                                            �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		SD2->(MsGoto(aRegSD2[nX]))
		RecLock( "SD2", .F. )

		If aScan(aPedBkp,SD2->D2_PEDIDO) == 0
			aAdd(aPedBkp,SD2->D2_PEDIDO)
		EndIf

		dbSelectArea("SF4")
		dbSetOrder(1)
		MsSeek(xFilial("SF4")+SD2->D2_TES)

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		//� Apaga movimentacao no SD3 Qdo Documento de transferencica       �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		If cPaisLoc != "BRA" .And. SD2->D2_TIPODOC == '54'
			SD3->(DbSetOrder(3))   //D3_FILIAL+D3_COD+D3_LOCAL+D3_NUMSEQ
			If SD3->(MsSeek(xFilial('SD3')+SD2->D2_COD+cDepTrf+SD2->D2_NUMSEQ))
				If !(FindFunction("LocTranSB2") .And. LocTranSB2(2))
					// Apaga transferencia RE4
					RecLock("SD3",.F.)
					DbDelete()
					MsUnlock()
				EndIf
			EndIf
		EndIf

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//矨tualiza saldo no armazem de poder de terceiros                         �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If FindFunction("TrfSldPoder3")
			TrfSldPoder3(SD2->D2_TES,"SD2",SD2->D2_COD,.T.)
		EndIf

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Estorna os dados vinculados ao Pedido de venda                 �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If !Empty(SD2->D2_PEDIDO) .And. Iif(cPaisloc=="BRA",Empty(SF2->F2_NFORI),.T.)
			dbSelectArea("SC5")
			dbSetOrder(1)
			MsSeek(xFilial("SC5")+SD2->D2_PEDIDO)

			RecLock("SC5")
			MaAvalSC5("SC5",6)

			dbSelectArea("SC6")
			dbSetOrder(1)
			MsSeek(xFilial("SC6")+SD2->D2_PEDIDO+SD2->D2_ITEMPV+SD2->D2_COD)

			RecLock("SC6")
			MaAvalSC6("SC6",6,"SC5",,,,,,,,"SD2",lRemito)

			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
			//� Integracao com Average                                         �
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
			If GetNewPar("MV_EECFAT",.F.)
				If FindFunction("AE100STATUS")
					AE100STATUS(SC5->C5_PEDEXP,SC5->C5_NUM)
				EndIf
			EndIf

			If !Empty(SF2->F2_CARGA) .And. !Empty(SF2->F2_SEQCAR)
				AAdd(aSd2Carga,{SD2->D2_PEDIDO, SD2->D2_ITEMPV, SD2->D2_COD, SF2->F2_CARGA, SF2->F2_SEQCAR, SC6->C6_ENDPAD, "3", SF2->F2_SEQENT })
			Endif

			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
			//� Estorno dos itens do pedido liberado                           �
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
			dbSelectArea("SC9")
			dbSetOrder(1)
			#IFDEF TOP
				If TcSrvType()<>"AS/400"
					cAliasSC9 := "MADELNFS"
					lQuery    := .T.
					cQuery := "SELECT C9_FILIAL,C9_PEDIDO,C9_ITEM,C9_PRODUTO,C9_BLCRED,C9_BLEST,C9_REMITO,C9_SEQUEN,C9_ITEMREM,C9_NFISCAL,C9_SERIENF,C9_BLOQUEI"+Iif(SC9->(FieldPos("C9_IDDCF")) > 0,",C9_IDDCF","")+",C9_CARGA,R_E_C_N_O_ SC9RECNO "
					cQuery += "FROM "+RetSqlName("SC9")+" SC9 "
					cQuery += "WHERE SC9.C9_FILIAL='"+xFilial("SC9")+"' AND "
					cQuery += "SC9.C9_PEDIDO='"+SD2->D2_PEDIDO+"' AND "
					cQuery += "SC9.C9_ITEM='"+SD2->D2_ITEMPV+"' AND "
					cQuery += "SC9.C9_PRODUTO='"+SD2->D2_COD+"' AND "
					If cPaisLoc == "BRA" .Or. !IsRemito(1,'SD2->D2_TIPODOC')
						cQuery += "SC9.C9_NFISCAL='"+SD2->D2_DOC+"' AND "
						cQuery += "SC9.C9_SERIENF='"+SD2->D2_SERIE+"' AND  "
					Else
						cQuery += "SC9.C9_REMITO ='"+SD2->D2_DOC+"' AND "
						cQuery += "SC9.C9_SERIREM='"+SD2->D2_SERIE+"' AND  "
					Endif
					cQuery += "SC9.D_E_L_E_T_=' ' "
					cQuery += "ORDER BY "+SqlOrder(SC9->(IndexKey()))

					cQuery := ChangeQuery(cQuery)

					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC9,.T.,.T.)

				Else
			#ENDIF
					MsSeek(xFilial("SC9")+SD2->D2_PEDIDO+SD2->D2_ITEMPV)
			#IFDEF TOP
				EndIf
			#ENDIF
			While !Eof() .And. xFilial("SC9") == (cAliasSC9)->C9_FILIAL .And.;
					SD2->D2_PEDIDO == (cAliasSC9)->C9_PEDIDO .And.;
					SD2->D2_ITEMPV == (cAliasSC9)->C9_ITEM

				If SD2->D2_COD == (cAliasSC9)->C9_PRODUTO

					If  lECommerce

      					SC5->(dbSetOrder(1))
						If  SC5->(dbSeek(xFilial("SC5")+(cAliasSC9)->C9_PEDIDO))

							//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
							//矯aso seja pedido e-Commerce n鉶 excluir� o SC9.                          �
							//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
					    	If !( Empty(SC5->C5_ORCRES) ) .AND. SL1->( FieldPos("L1_ECFLAG") > 0 ) .AND. (Posicione("SL1",1,xFilial("SL1")+SC5->C5_ORCRES,"L1_ECFLAG")=="1") .And. (Ascan(aRegSC5, SC5->(Recno())) <= 0)
						    	aadd(aRegSC5, SC5->(Recno()))
							EndIf
						EndIf
					EndIf

					SC6->(dbSetOrder(1))
					SC6->(dbSeek(xFilial("SC6")+(cAliasSC9)->(C9_PEDIDO+C9_ITEM+C9_PRODUTO)))

					aEmpBN := If(FindFunction("A410CarBen"),A410CarBen(SC9->C9_PEDIDO,SC9->C9_ITEM),{})
					If !Empty(aEmpBN)
						A410LibBen(2,aEmpBN[1,1],aEmpBN[1,2],SC9->C9_QTDLIB,SC9->C9_QTDLIB2)
					EndIf
					//谀哪哪哪哪哪哪哪哪哪哪哪哪哪�
					//矨tualiza o campo B2_QEMPN  �
					//滥哪哪哪哪哪哪哪哪哪哪哪哪哪�
					FatAtuEmpN("+",.T.,cAliasSC9)
					//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
					//砅ara as notas fiscais sem remito�
					//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
					If (cAliasSC9)->C9_BLCRED=="10" .And. (cAliasSC9)->C9_BLEST=="10" .And. Empty(SD2->D2_REMITO) .And.;
						SD2->D2_DOC == (cAliasSC9)->C9_NFISCAL .And. SD2->D2_SERIE == (cAliasSC9)->C9_SERIENF
						If lQuery
							SC9->(MsGoto((cAliasSC9)->SC9RECNO))
						EndIf

						If lMontaVol .And. FindFunction('TMSChkVer') .And. TMSChkVer('11','R5')
							//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
							//矱storna montagem de Volume      �
							//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
							If !Empty((cAliasSC9)->C9_IDDCF) .And. FindFunction('Wma390EstN') .And. AliasIndic('DCS') .And. AliasIndic('DCT') .And. AliasIndic('DCU') .And. AliasIndic('DCV')
								Wma390EstN (IIf(!Empty((cAliasSC9)->C9_CARGA),(cAliasSC9)->C9_CARGA,(cAliasSC9)->C9_PEDIDO),(cAliasSC9)->C9_PRODUTO,(cAliasSC9)->C9_IDDCF,IIf(!Empty((cAliasSC9)->C9_CARGA),'2','1'),(cAliasSC9)->C9_SEQUEN)
							EndIf
						EndIf

						RecLock("SC9")
						MaAvalSC9("SC9",12)
						SC9->(dbDelete())
						MsUnLock()

					//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
					//砅ara as notas fiscais com remito previo, so limpar os campos de bloqueio �
					//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
					ElseIf (cAliasSC9)->C9_BLCRED=="10" .And. (cAliasSC9)->C9_BLEST=="10" .And. !Empty(SD2->D2_REMITO).And.;
						SD2->D2_DOC == (cAliasSC9)->C9_NFISCAL .And. SD2->D2_SERIE == (cAliasSC9)->C9_SERIENF
						If lQuery
							SC9->(MsGoto((cAliasSC9)->SC9RECNO))
						EndIf

						RecLock("SC9")
						C9_BLEST	:=	Space(Len(C9_BLEST  ))
						C9_BLCRED	:=	Space(Len(C9_BLCRED ))
						C9_NFISCAL	:=	Space(Len(C9_NFISCAL))
						C9_SERIENF	:=	Space(Len(C9_SERIENF))
						MsUnLock()
					//谀哪哪哪哪哪哪哪哪哪�
					//砅ara os remitos.   �
					//滥哪哪哪哪哪哪哪哪哪�
					ElseIf Empty((cAliasSC9)->C9_BLCRED+(cAliasSC9)->C9_BLEST) .And.;
						(cAliasSC9)->C9_REMITO+(cAliasSC9)->C9_ITEMREM+(cAliasSC9)->C9_SEQUEN == SD2->D2_DOC+SD2->D2_ITEM+SD2->D2_SEQUEN

						If lQuery
							SC9->(MsGoto((cAliasSC9)->SC9RECNO))
						EndIf

						RecLock("SC9")
						MaAvalSC9("SC9",12,,,,,,,,.T.)
						SC9->(dbDelete())
						MsUnLock()
					Endif
					If	IntDL(SC9->C9_PRODUTO) .And. !Empty(SC9->C9_SERVIC) .And. FindFunction("WmsAtzSDB")
						WmsAtzSDB('6')
					EndIf
				EndIf
				dbSelectArea(cAliasSC9)
				dbSkip()
			EndDo
			If lQuery
				dbSelectArea(cAliasSC9)
				dbCloseArea()
				dbSelectArea("SC9")
			EndIf
		ElseIf !Empty(SD2->D2_REMITO)
			aAreaTmp	:=	GetArea()
			aAreaSD2	:=	SD2->(GetArea())
			SD2->(DbSetOrder(3))
			cPedRem		:= ""
			cItPedRem	:= ""
			cSeqPedRem	:= ""
			If SD2->(MSSeek(xFilial("SD2")+SD2->D2_REMITO+SD2->D2_SERIREM+SD2->D2_CLIENTE+SD2->D2_LOJA+SD2->D2_COD+SD2->D2_ITEMREM))
				cPedRem		:= SD2->D2_PEDIDO
				cItPedRem	:= SD2->D2_ITEMPV
				cSeqPedRem	:= SD2->D2_SEQUEN
			Endif
			RestArea(aAreaSD2)
			If !Empty(cPedRem)
				aAreaSC5	:=	SC5->(GetArea())
				SC5->(DbSetOrder(1))
				If SC5->(MSSeek(xFilial("SC5")+cPedRem))

					RecLock("SC5")
					MaAvalSC5("SC5",6)

					aAreaSC6 :=	SC6->(GetArea())
					SC6->(dbSetOrder(1))
					If SC6->( MsSeek(xFilial("SC6")+cPedRem+cItPedRem+SD2->D2_COD) )
						RecLock("SC6")
						MaAvalSC6("SC6",6,"SC5",,,,,,,,"SD2",lRemito)

						aAreaSC9	:=	SC9->(GetArea())
						SC9->(DBSetOrder(1))
						If SC9->(MSSeek(xFilial("SC9")+cPedRem+cItPedRem+cSeqPedRem+SD2->D2_COD, .F.))
								AtuSA1Nf('SF2','SD2',SD2->D2_TIPO,'C',.T.,.T.,-1)
								//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
								//砅ara as notas fiscais com remito previo, so limpar os campos de bloqueio �
								//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
								RecLock("SC9")
								C9_BLEST	:=	Space(Len(C9_BLEST  ))
								C9_BLCRED	:=	Space(Len(C9_BLCRED ))
								C9_NFISCAL	:=	Space(Len(C9_NFISCAL))
								C9_SERIENF	:=	Space(Len(C9_SERIENF))
								MsUnLock()
							Endif
							RestArea(aAreaSC9)
						EndIf
						RestArea(aAreaSC6)
					Endif
					RestArea(aAreaSC5)
				Endif
			RestArea(aAreaTMP)
		EndIf
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Estorna os dados referentes a devolucao de compra              �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If SF2->F2_TIPO == "D"
			dbSelectArea("SD1")
			dbSetOrder(1)
			If MsSeek(xFilial("SD1")+SD2->D2_NFORI+SD2->D2_SERIORI+SD2->D2_CLIENTE+SD2->D2_LOJA+SD2->D2_COD+SD2->D2_ITEMORI)
				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�13哪哪哪哪哪哪哪哪哪哪哪哪�
				//� Estorna da baixa do CQ                                         �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
//				MaCQ2SD2(.T.)
				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
				//� Estorna o item da nota fiscal de entrada                       �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
				RecLock("SD1")
				SD1->D1_QTDEDEV := Max(0,SD1->D1_QTDEDEV-SD2->D2_QUANT)
				SD1->D1_VALDEV  := Max(0,SD1->D1_VALDEV-SD2->D2_TOTAL)
				MsUnLock()

				If cPaisLoc <> "BRA"   //SOMENTE LOCALIZACOES
					//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
					//矱storna tambem os campos QTDEDEV e VALDEV das notas ou remitos associados        �
					//砤a nota ou remito original aqui posicionado.                                     �
					//矷sso garante que futuras notas de credito ou remitos de devolucao considerem o   �
					//硈aldo a devolver corretamente.                                                   �
					//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
					If "MATA102" $ Funname()
						// Pesquisa pela nota gerada pelo remito original
						cSeekSD1 := SD1->D1_FORNECE+SD1->D1_LOJA+SD1->D1_SERIE+SD1->D1_DOC+SD1->D1_ITEM
						DBSelectArea("SD1")
						DBSetOrder(10)
						If MsSeek(xFilial("SD1")+cSeekSD1 ,.F.)
							RecLock("SD1", .F.)
							SD1->D1_QTDEDEV := Max(0,SD1->D1_QTDEDEV-SD2->D2_QUANT)
							SD1->D1_VALDEV  := Max(0,SD1->D1_VALDEV-SD2->D2_TOTAL)
							MsUnlock()
						EndIf
						//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
						//� Na exclusao de uma devolucao de remito de entrada, atualiza a quantida-�
						//� a classificar do remito de entrada.                                    �
						//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
						If SD2->D2_TIPODOC == "61" .And. Alltrim(SD2->D2_ESPECIE) == "RCD"
							aAreaSD1 := SD1->(GetArea())
							DBSelectArea("SD1")
							DBSetOrder(1)
							If MsSeek(xFilial("SD1")+SD2->D2_NFORI+SD2->D2_SERIORI+SD2->D2_CLIENTE+SD2->D2_LOJA+SD2->D2_COD+SD2->D2_ITEMORI)
								RecLock("SD1",.F.)
								SD1->D1_QTDACLA := SD1->D1_QTDACLA + SD2->D2_QUANT
								MsUnLock()
							EndIf
							RestArea(aAreaSD1)
						EndIf
					Elseif "MATA466" $ Funname()
						// Pesquisa, se houver, o remito vinculado aa nota original
						If !Empty( SD1->D1_REMITO + SD1->D1_SERIREM )
							cSeekSD1 := SD1->D1_REMITO+SD1->D1_SERIREM+SD1->D1_FORNECE+SD1->D1_LOJA+SD1->D1_COD+SD1->D1_ITEMREM
							DBSelectArea("SD1")
							DBSetOrder(1)
							If MsSeek(xFilial("SD1")+cSeekSD1 ,.F.)
								RecLock("SD1", .F.)
								SD1->D1_QTDEDEV := Max(0,SD1->D1_QTDEDEV-SD2->D2_QUANT)
								SD1->D1_VALDEV  := Max(0,SD1->D1_VALDEV-SD2->D2_TOTAL)
								MsUnlock()
							EndIf
						EndIf
					EndIf
				EndIf
				If ( lLctPad30 .And. lLctPad41 .And. lHeader )
					dbSelectArea("SDE")
					dbSetOrder(1)
					MsSeek(xFilial("SDE")+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA+SD1->D1_ITEM)
					While ( !Eof() .And. ;
							xFilial("SDE") == SDE->DE_FILIAL .And.;
							SD1->D1_DOC == SDE->DE_DOC .And.;
							SD1->D1_SERIE == SDE->DE_SERIE .And.;
							SD1->D1_FORNECE == SDE->DE_FORNECE .And.;
							SD1->D1_LOJA == SDE->DE_LOJA .And.;
							SD1->D1_ITEM == SDE->DE_ITEMNF)

						nTotalCtb += DetProva(nHdlPrv,"641","MATA520",cLoteCtb,,,,,@c641,@aCT5)

						dbSelectArea("SDE")
						dbSkip()
					EndDo
				EndIf
			EndIf
		EndIf
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Estorno dos lancamentos de Poder de Terceiro                   �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If SF4->F4_PODER3<>"N"
			MaAtuSB6("SD2",4)
		EndIf

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//矱storna os arquivos de Gerenciamento de Projetos - 2:Estorno,3:Exclusao �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If IntePms()		// Integracao PMS
			PmsWriteD2(2,"SD2")     // Estorna os custos no Projeto AF9/AFJ.
			PMsWriteD2(3,"SD2")    //  Deleta na tabela "AFS".
		EndIf

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Estorno das Demandas                                           �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If SF4->F4_ESTOQUE == "S" .And. (Empty(SD2->D2_REMITO).Or.SD2->D2_TPDCENV $ "1A")
			If !(SD2->D2_TIPO $ "DBCIP")
				dbSelectArea("SB3")
				dbSetOrder(1)
				If ( MsSeek(xFilial("SB3")+SD2->D2_COD) )
					RecLock("SB3")
				Else
					RecLock("SB3",.T.)
					SB3->B3_FILIAL := xFilial("SB3")
					SB3->B3_COD    := SD2->D2_COD
				EndIf
				FieldPut(FieldPos("B3_Q"+StrZero(Month(SD2->D2_EMISSAO),2)),FieldGet(FieldPos("B3_Q"+StrZero(Month(SD2->D2_EMISSAO),2)))-SD2->D2_QUANT)
				SB3->B3_MES := SD2->D2_EMISSAO
				MsUnLock()
			EndIf
		Endif
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Executa os lancamentos contabeis ( 635 ) - Cabecalho         �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If lLctPad30 .And. lHeader
			dbSelectArea("SB1")
			dbSetOrder(1)
			MsSeek(xFilial("SB1")+SD2->D2_COD)
			lDetProva := .T.
			nTotalCtb += DetProva(nHdlPrv,"630","MATA520",cLoteCtb,,,,,@c630,@aCT5)
		EndIf

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Estorno de carga do OMS                                        �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If !Empty(SF2->F2_CARGA)
			aRotas := {}
			OsAvalDAI("DAI",3,@aRotas,.F.,,@cFilcar,@oMdlCarga)
		EndIf

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Estorno da transferencia da base instalada - Field Service     �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If SF4->F4_ESTOQUE == "S" .And. SF4->F4_ATUTEC == "S"
			MaEstNfAA3()
		EndIf

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Exclui a amarracao com os conhecimentos                      �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		MsDocument( "SF2", SF2->( RecNo() ), 2, , 3 )

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Grava os lancamentos nas contas orcamentarias SIGAPCO    �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		PcoDetLan("000101","01","MATA520",.T.)

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Exclui a Nota Fiscal - antes de atualizar o estoque por causa  �
		//� da INTEGRIDADE REFERENCIAL - NAO REMOVER ESTA ORDEM            �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		SD2->(dbDelete())
		SD2->(FkCommit())
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Estorno do estoque baixado na Saida                            �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If SF4->F4_ESTOQUE == "S" .And. (Empty(SD2->D2_REMITO).Or.SD2->D2_TPDCENV $ "1A")

			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
			//� Armazena a tes original para integridade referencial pois      �
			//� a tes eh trocada para uma de entrada para o estorno da nota    �
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
			aCusto      := PegaCusD2()
			SB2->(B2AtuComD2(aCusto,1,,Iif(cPaisLoc <> "BRA",!Empty(SD2->D2_PEDIDO).Or.(nPDevLoc == 1.And.Localiza(SD2->D2_COD)),Nil),nPDevLoc,,.T.))

			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
			//� Volta a TES original para a integridade referencial validar    �
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		Endif
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Estorna o Servico do WMS (DCF)                           �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If cPaisLoc <> "BRA"
			LocIntDCF('SD2',.T.)
		EndIf

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		//矱storna saldo do contrato SIGAGCT                                      �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		If SC6->( FieldPos("C6_ITEMED") ) > 0 .And. !Empty(SC6->C6_ITEMED)
			CtaAvalGCT(2,aContrato,SC5->C5_MDCONTR,SC5->C5_MDPLANI,SC6->C6_ITEMED,SD2->D2_QUANT,,SC5->C5_MDNUMED,SD2->D2_TOTAL)
		EndIf

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		//矨tualiza o orcamento do Televendas, se foi originado a partir�
		//砫ele no modulo Call Center (SIGATMK)                         �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		If !Empty(SD2->D2_PEDIDO)
			TkAtuTlv(SD2->D2_PEDIDO,1)
		EndIf

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		//� Integracao com o ACD		  				  	  �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		If lIntACD .And. FindFunction("CBMSD2520")
			cRetPE := CBMSD2520()
			cBlock += If(ValType(cRetPE)=="C",cRetPE,"")
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Executa execblock                                              �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		ElseIf	lMSd2520T
			cRetPE := ExecTemplate("MSD2520",.F.,.F.)
			cBlock += If(ValType(cRetPE)=="C",cRetPE,"")
		EndIf

		If nModulo == 72
			KEXF850()
		EndIf

		If	lMSd2520
			ExecBlock("MSD2520",.F.,.F.)
		EndIf

		//-- CodBlock a ser avaliado na gravacao do SC9
		bBlock := &('{||'+cBlock+'}')

		If lM521Cart
			lCarteira := ExecBlock("M521CART",.F.,.F.)
		EndIf
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Liberar pedido de venda                                        �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If !lCarteira .And. !Empty(SD2->D2_PEDIDO) .And. Empty(SD2->D2_REMITO) .And. Iif(cPaisloc=="BRA",Empty(SF2->F2_NFORI),.T.)
			If lSelLote

				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
				//� Procura o ultimo endereco do Produto antes do faturamento      �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
				cEndRelWms := ''
				If IntDL(SD2->D2_COD) .And. lRelibWMS
					SDB->(dbSetOrder(1)) //-- DB_FILIAL+DB_PRODUTO+DB_LOCAL+DB_NUMSEQ+DB_DOC+DB_SERIE+DB_CLIFOR+DB_LOJA+DB_ITEM
					If SDB->(MsSeek(cSeekSDB:=xFilial('SDB')+SD2->D2_COD+SD2->D2_LOCAL+SD2->D2_NUMSEQ, .F.))
						Do While !SDB->(Eof()) .And. cSeekSDB == SDB->DB_FILIAL+SDB->DB_PRODUTO+SDB->DB_LOCAL+SDB->DB_NUMSEQ
							If SDB->DB_ESTORNO == 'S' .And. SDB->DB_ATUEST = 'S' .And. SDB->DB_TM <= '500'
								cEndRelWms := SDB->DB_LOCALIZ
								Exit
							EndIf
							SDB->(dbSkip())
						EndDo
					EndIf
				EndIf

				RecLock("SC6")
				nPrcVen         := SC6->C6_PRCVEN
				SC6->C6_LOTECTL := SD2->D2_LOTECTL
				SC6->C6_NUMLOTE := SD2->D2_NUMLOTE
				SC6->C6_LOCALIZ := SD2->D2_LOCALIZ
				SC6->C6_DTVALID := SD2->D2_DTVALID
				SC6->C6_NUMSERI := SD2->D2_NUMSERI
				SC6->C6_POTENCI := SD2->D2_POTENCI
				SC6->C6_PRCVEN  := ( (SD2->D2_TOTAL+SD2->D2_DESCZFR) / SD2->D2_QUANT)
				SC6->C6_PRCVEN  := xmoeda(SC6->C6_PRCVEN,SF2->F2_MOEDA,SC5->C5_MOEDA,SF2->F2_EMISSAO,TamSX3("D2_PRCVEN")[2])


				If !Empty(cEndRelWms)
					cEndAnt  := SC6->C6_LOCALIZ
					cServAnt := SC6->C6_SERVIC
					Replace SC6->C6_LOCALIZ With cEndRelWms
					Replace SC6->C6_SERVIC  With ''
				EndIf

				MaLibDoFat(SC6->(RecNo()),SD2->D2_QUANT,.T.,.F.,.F.,.T.,.T.,.F.,,bBlock)

				SC6->C6_LOTECTL := ''//aSaldos[nX][1]
				SC6->C6_NUMLOTE := ''//aSaldos[nX][2]
				SC6->C6_LOCALIZ := ''//aSaldos[nX][3]
				SC6->C6_NUMSERI := ''//aSaldos[nX][4]
				SC6->C6_DTVALID := Ctod('')//aSaldos[nX][7]
				SC6->C6_POTENCI := 0//aSaldos[nX][6]
				SC6->C6_PRCVEN  := nPrcVen

				If !Empty(cEndRelWms)
					Replace SC6->C6_LOCALIZ With cEndAnt
					Replace SC6->C6_SERVIC  With cServAnt
					cEndAnt    := ''
					cServAnt   := ''
					cEndRelWms := ''
				EndIf

			Else
				MaLibDoFat(SC6->(RecNo()),SD2->D2_QUANT,.T.,.F.,.F.,.T.,.T.,.F.,,bBlock)
			EndIf
			If aScan(aPedido,SD2->D2_PEDIDO)==0
				AAdd(aPedido,SD2->D2_PEDIDO)
			EndIf
		EndIf
	Next nX
	If lFreteEmb .And. !Empty(SF2->F2_CARGA) .And. !Empty(SF2->F2_SEQCAR)
		dbSelectArea("DAS")
		dbSetOrder(1)
		If MsSeek(xFilial("DAS")+SF2->F2_CARGA+SF2->F2_SEQCAR)
			OmsRatFre(SF2->F2_CARGA,SF2->F2_SEQCAR,Val(DAS->DAS_RATFRE),DAS->DAS_VALFRE,DAS->DAS_FREAUT)
			OmsFretPV(SF2->F2_CARGA,SF2->F2_SEQCAR,3)
		EndIf
	EndIf
	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Estorna os Livros Fiscais                                      �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	MaFisAtuSF3(2,"S",SF2->(RecNo()))

	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Estorna Registro da tabela CDA se houver                       �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	MAFISCDA(,,.T.,SF2->("S"+F2_ESPECIE+"S"+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA),"S","SF2")

	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Grava os lancamentos nas contas orcamentarias SIGAPCO    �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	PcoDetLan("000101","02","MATA521",.T.)

	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Estorna caucoes do Gestao de Contratos - SIGAGCT               �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	If len(aContrato) > 0
		CtaAbatCauc(2,aContrato[1], aRegSE1, SF2->F2_CLIENTE, SF2->F2_LOJA, SF2->F2_DOC, SF2->F2_SERIE, NIL, SF2->F2_VALBRUT )
	EndIf

	If AliasInDic("AGH")
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//砇otina para tratar a exclusao do rateio de itens da nota fiscal de saida.�
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		aAreaRat := GetArea()
		dbSelectArea("AGH")
		AGH->(dbSetOrder(1)) 	//AGH_FILIAL+AGH_NUM+AGH_SERIE+AGH_FORNEC+AGH_LOJA+AGH_ITEMPD+AGH_ITEM
		If AGH->(dbSeek(xFilial("AGH") + SF2->F2_DOC + SF2->F2_SERIE +  SF2->F2_CLIENTE  + SF2->F2_LOJA ))
			While AGH->(!Eof()) .And. AGH->(AGH_FILIAL+AGH_NUM+AGH_SERIE+AGH_FORNEC+AGH_LOJA) == xFilial("AGH") + SF2->F2_DOC + SF2->F2_SERIE +  SF2->F2_CLIENTE  + SF2->F2_LOJA
				RecLock("AGH",.F.)
				AGH->(dbDelete())
				MsUnLock()
				AGH->(dbSkip())
			EndDo
		EndIf
		RestArea(aAreaRat)
	EndIf

	If lMs520Del
		ExecBlock("MS520DEL",.F.,.F.)
	EndIf

	//Elimina a Nota Fiscal do SIGAGFE
	//se integra玢o com o mesmo estiver ativa
	If !MATA521IPG()
		DisarmTransaction()
		lContinua := .F.
	EndIf

	If lContinua
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Exclui a Nota Fiscal                                           �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		RecLock("SF2")
		SF2->(dbDelete())
		MsUnLock()

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Exclui o cabecalho da carga conforme integridade               �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If !Empty(SF2->F2_CARGA)
			OsAvalDAI("DAI",4,,,,cFilcar,@oMdlCarga)
		EndIf
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Atualiza a Nota de Origem                                      �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If SF2->(FieldPos("F2_NEXTSER"))<>0 .And. !Empty(SF2->F2_NFORI)
			nRegSF2 := SF2->(RecNo())
			dbSelectArea("SF2")
			dbSetOrder(6)
			If !MsSeek(xFilial("SF2")+SF2->F2_SERIORI+SF2->F2_NFORI)
				SF2->(MsGoTo(nRegSF2))
				dbSelectArea("SF2")
				dbSetOrder(1)
				If MsSeek(xFilial("SF2")+SF2->F2_NFORI+SF2->F2_SERIORI)
					RecLock("SF2")
					SF2->F2_NEXTDOC := ""
					SF2->F2_NEXTSER := ""
					MsUnLock()
				EndIf
			EndIf
		EndIf
		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Fecha os lancamentos contabeis                               �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If !Empty(aPedido)
			MaLiberOk(aPedido)
		EndIf

		If lCtbInTran
			If lHeader
				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
				//� Fecha os lancamentos contabeis                               �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
				lHeader   := .F.
				RodaProva(nHdlPrv,nTotalCtb)
				If ( FindFunction( "UsaSeqCor" ) .And. UsaSeqCor() )
					If Empty(cCodDiario)
						cCodDiario :=CtbaVerdia()
					EndIf
					aCtbDia := {{"SF2",SF2->(RECNO()),cCodDiario,"F2_NODIA","F2_DIACTB"}}
				EndIF
				cA100Incl(cArqCtb,nHdlPrv,1,cLoteCtb,lDigita,lAglutina,,,,,,aCtbDia)
			EndIf
		EndIf
	EndIf
End Transaction

If lContinua
	If !lCtbInTran
		If lHeader
			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
			//� Fecha os lancamentos contabeis                               �
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
			lHeader   := .F.
			RodaProva(nHdlPrv,nTotalCtb)
			If ( FindFunction( "UsaSeqCor" ) .And. UsaSeqCor() )
				If Empty(cCodDiario)
					cCodDiario :=CtbaVerdia()
				EndIf
				aCtbDia := {{"SF2",SF2->(RECNO()),cCodDiario,"F2_NODIA","F2_DIACTB"}}
			EndIF
			cA100Incl(cArqCtb,nHdlPrv,1,cLoteCtb,lDigita,lAglutina,,,,,,aCtbDia)
		EndIf
	EndIf

	If ExistBlock("M521DNFS")
		ExecBlock("M521DNFS",.F.,.F.,{aPedido})
	Endif

	If FindFunction("MaEnvEAI")
		If oMdl <> Nil
			//--Exclus鉶 NF SAIDA
			MaEnvEAI(,,5,"MATA521",,,,.F.,oMdl)
		EndIf
		If oMdlCarga <> Nil
			MaEnvEAI(,,5,"OMSA200",,,,.F.,oMdlCarga)
		EndIf
	EndIf

	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Para os pedidos e-Commerce processa a liberacao novamente    �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	SC6->( dbSetOrder(1) )

	For  nX := 1 to Len(aRegSC5)

		lLiberOk  := .T.
	    SC5->( DbGoTo(aRegSC5[nX]) )

		Begin Transaction

	    SC6->( dbSeek(xFilial("SC6")+SC5->C5_NUM) )
	    Do  While !( SC6->(Eof()) ) .And. (SC6->C6_FILIAL+SC6->C6_NUM == xFilial("SC6")+SC5->C5_NUM)
        	MaLibDoFat(SC6->(RecNo()),SC6->C6_QTDVEN,,,.T.,.T.,.F.,.F.)

       		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	   		//砎erifica se Todos os Itens foram Liberados                              �
	   		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
			If  (lLiberOk .And. SC6->C6_QTDVEN > SC6->C6_QTDEMP + SC6->C6_QTDENT .And. AllTrim(SC6->C6_BLQ)<>"R")
				lLiberOk := .F.
			EndIf

			SC6->( dbSkip() )
		EndDo


		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//矨tualiza do C5_LIBEROK                                                  �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If ( lLiberOk )
			RecLock("SC5")
			SC5->C5_LIBEROK := "S"
			SC5->( MsUnlock() )
			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
			//� PCO - Grava o lancamento de liberacao de pedido de venda �
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
			PcoDetLan("000103","02","MATA440")
		EndIf

		End Transaction
	Next nX
EndIf

RestArea(aArea)
Return(.T.)

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rogram   矼ATA521A  � Rev.  矱duardo Riera          � Data �29.12.2001	潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噮o 砇otina de exclusao dos documentos de saida por carga       	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   砃enhum                                                      	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros砃enhum                                                      	潮�
北�          �                                                            	潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     	潮�
北媚哪哪哪哪哪哪穆哪哪哪哪履哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� PROGRAMADOR  � DATA   � BOPS �  MOTIVO DA ALTERACAO                     潮�
北媚哪哪哪哪哪哪呐哪哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�              �        �      �                                          潮�
北滥哪哪哪哪哪哪牧哪哪哪哪聊哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
Static Function MATA521B()

Local aArea     := GetArea()
Local cFilDAK   := ""
Local aIndDAK   := {}
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//矯arga das Variaveis Staticas do Programa                                �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Define Array contendo as Rotinas a executar do programa  �
//� ----------- Elementos contidos por dimensao ------------ �
//� 1. Nome a aparecer no cabecalho                          �
//� 2. Nome da Rotina associada                              �
//� 3. Usado pela rotina                                     �
//� 4. Tipo de Transa噭o a ser efetuada                      �
//�    1 - Pesquisa e Posiciona em um Banco de Dados         �
//�    2 - Simplesmente Mostra os Campos                     �
//�    3 - Inclui registros no Bancos de Dados               �
//�    4 - Altera o registro corrente                        �
//�    5 - Remove o registro corrente do Banco de Dados      �
//�    6 - Altera determinados campos sem incluir novos Regs �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
PRIVATE bFiltraBrw := {|| ""}
PRIVATE bEndFilBrw := {|| Nil}
PRIVATE cCadastro  := OemToAnsi(STR0010) //"Exclusao dos Documento de Saida por carga"
PRIVATE aRotina    := { ;
	{ STR0002,"PesqBrw"  , 0 , 0},; //"Pesquisa"
	{ STR0005,"Ma521MBrow", 0 , 5}} //"Excluir"

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//砎erifica o modelo de interface                                          �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁

Pergunte("MTA521",.F.)
SetKey(VK_F12,{||Pergunte("MTA521",.T.)})

If ExistBlock( "M520FIL" )
	cFilDAK := ExecBlock("M520FIL",.F.,.F.)
EndIf

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//� Ponto de entrada para pre-validar os dados a serem  �
//� exibidos.                                           �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
IF ExistBlock("M520BROW")
   ExecBlock("M520BROW",.F.,.F.)
Endif

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//砇ealiza a Filtragem                                                     �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If !Empty(cFilDAK)
	bFiltraBrw := {|x| FilBrowse("DAK",@aIndDAK,@cFilDAK) }
	Eval(bFiltraBrw)
	DAK->(MsSeek(xFilial()))
Endif

mBrowse(7,4,20,74,"DAK",,"DAK_FEZNF=='1'")
SetKey(VK_F12,Nil)

If !Empty(cFilDAK)
	dbSelectArea("DAK")
	RetIndex("DAK")
	dbClearFilter()
	aEval(aIndDAK,{|x| Ferase(x[1]+OrdBagExt())})
Endif

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//砇estaura a integridade da rotina                                �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
RestArea(aArea)
Return(.T.)

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rogram   砄MS521CAR � Rev.  矵enry Fila             � Data �29.12.2001	潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噮o 砇otina de remontagem de carga                              	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   砃enhum                                                      	潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros矱xpA1 : Array com os campos do SC9 anterior                 	潮�
北�          矱xpA2 : Array com dos dados da carga anterior               	潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     	潮�
北媚哪哪哪哪哪哪穆哪哪哪哪履哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� PROGRAMADOR  � DATA   � BOPS �  MOTIVO DA ALTERACAO                     潮�
北媚哪哪哪哪哪哪呐哪哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�              �        �      �                                          潮�
北滥哪哪哪哪哪哪牧哪哪哪哪聊哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/

Static Function Oms521Car(aSd2Carga,aRotas,cFilCar)

Local nPosPed := 0

If Len(aSd2Carga) > 0
	nPosPed := Ascan(aSd2Carga, {|x| x[1]+x[2]+x[3] == SC9->C9_PEDIDO+SC9->C9_ITEM+SC9->C9_PRODUTO})
	If nPosPed > 0
		If Empty(SC9->C9_BLCRED) .And. Empty(SC9->C9_BLEST) .And. Empty(SC9->C9_REMITO)
			RecLock("SC9",.F.)
				SC9->C9_CARGA  := aSd2Carga[nPosPed][4]
				SC9->C9_SEQCAR := aSd2Carga[nPosPed][5]
				SC9->C9_ENDPAD := aSd2Carga[nPosPed][6]
				SC9->C9_SEQENT := aSd2Carga[nPosPed][8]
			MsUnlock()
			MaAvalSC9("SC9",7,,,,,,aRotas,,,,,,cFilCar)
		EndIf
	EndIf
EndIf

Return



/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rogram   矼aEstNfAA3� Rev.  � Sergio Silveira       � Data �12/08/2002	 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噮o 砇otina de transferencia da base instalada - Estorno NF saida  潮�
北�          硉ransfere o eqto do AA3 para o cliente padrao de devolucao    潮�
北�          砄 SD2 deve estar posicionado.                                 潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   砃enhum                                                        潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros砃enhum                                                        潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                        潮�
北媚哪哪哪哪哪哪穆哪哪哪哪履哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� PROGRAMADOR  � DATA   � BOPS �  MOTIVO DA ALTERACAO                     潮�
北媚哪哪哪哪哪哪呐哪哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�              �        �      �                                          潮�
北滥哪哪哪哪哪哪牧哪哪哪哪聊哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/

Static Function MaEstNfAA3()

Local aArea     := GetArea()
Local aAreaSA1  := SA1->( GetArea() )

Local cAtEstCli := PadR( &( SuperGetMV( "MV_ATESTCL" ) ), Len( SA1->A1_COD ) )
Local cAtEstLoj := PadR( &( SuperGetMV( "MV_ATESTLJ" ) ), Len( SA1->A1_LOJA ) )
Local lM521Atec := ExistBlock("LM521ATEC")
Local lValidCli := .F.

#IFNDEF TOP
	Local cSeekSDB  := ""
#ENDIF

#IFDEF TOP
	Local cQuery    := ""
	Local cAliasQry := ""
#ENDIF

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Verifica se foi definido o cliente / loja de retorno           �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If !Empty( cAtEstCli ) .And. !Empty( cAtEstLoj )

	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//� Verifica se o cliente / loja existe                            �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁

	SA1->( dbSetOrder( 1 ) )

	lValidCli := SA1->( dbSeek( xFilial( "SA1" ) + cAtEstCli + cAtEstLoj ) )

	If lValidCli

		If !( Localiza(SD2->D2_COD) )
			If ( !Empty(SD2->D2_NUMSERI) )
				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
				//� Transfere para o cliente / loja de retorno                     �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
				AtTrfEqpto(SD2->D2_CODFAB,SD2->D2_LOJAFA,SD2->D2_COD,SD2->D2_NUMSERI,cAtEstCli,cAtEstLoj)

				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
				//� Ponto de entrada - Transferencia                               �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
				If lM521Atec
					ExecBlock("M521ATEC",.F.,.F.)
				EndIf
			EndIf
		Else

			#IFDEF TOP

				cAliasQry := "MANFESTAA3"

				cQuery := ""

				cQuery += "SELECT DB_NUMSERI FROM " + RetSqlname( "SDB" ) + " "
				cQuery += "WHERE "
				cQuery += "DB_FILIAL='"   + xFilial( "SDB" )             + "' AND "
				cQuery += "DB_PRODUTO='"  + SD2->D2_COD                  + "' AND "
				cQuery += "DB_LOCAL='"    + SD2->D2_LOCAL                + "' AND "
				cQuery += "DB_NUMSEQ='"   + SD2->D2_NUMSEQ               + "' AND "
				cQuery += "DB_DOC='"      + SD2->D2_DOC                  + "' AND "
				cQuery += "DB_SERIE='"    + SD2->D2_SERIE                + "' AND "
				cQuery += "DB_CLIFOR='"   + SD2->D2_CLIENTE              + "' AND "
				cQuery += "DB_LOJA='"     + SD2->D2_LOJA                 + "' AND "
				cQuery += "DB_NUMSERI<>'" + Space(Len( SDB->DB_NUMSERI)) + "' AND "

				cQuery += "D_E_L_E_T_<>'*' "

				cQuery := ChangeQuery( cQuery )

				dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cAliasQry, .F., .T. )

				While !( cAliasQry )->( Eof() )

					//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
					//� Transfere para o cliente / loja de retorno                     �
					//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
					AtTrfEqpto(SD2->D2_CODFAB,SD2->D2_LOJAFA,SD2->D2_COD, ( cAliasQry )->DB_NUMSERI,cAtEstCli,cAtEstLoj)
   				( cAliasQry )->( dbSkip() )

				EndDo

				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
				//� Fecha a area de trabalho da query                              �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
				( cAliasQry )->( dbCloseArea() )
				dbSelectArea( "SDB" )

			#ELSE

				SDB->( dbSetOrder( 1 ) )

				cSeekSDB := xFilial("SDB")+SD2->D2_COD+SD2->D2_LOCAL+SD2->D2_NUMSEQ+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA
				If ( MsSeek( cSeekSDB ) )

					While !SDB->( Eof() ) .And. cSeekSDB == SDB->DB_FILIAL + SDB->DB_PRODUTO + SDB->DB_LOCAL + SDB->DB_NUMSEQ +;
							SDB->DB_DOC + SDB->DB_SERIE + SDB->DB_CLIFOR + SDB->DB_LOJA

						If !Empty( SDB->DB_NUMSERI )
							//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
							//� Transfere para o cliente / loja de retorno                     �
							//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
							AtTrfEqpto(SD2->D2_CODFAB,SD2->D2_LOJAFA,SD2->D2_COD,SDB->DB_NUMSERI,cAtEstCli,cAtEstLoj)

							//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
							//� Ponto de entrada - Transferencia                               �
							//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
							If lM521Atec
								ExecBlock("M521ATEC",.F.,.F.)
							EndIf
						EndIf

						SDB->( dbSkip() )

					EndDo

				EndIf

			#ENDIF

		EndIf

	EndIf

EndIf

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Restaura as areas de trabalho                                  �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
RestArea( aAreaSA1 )
RestArea( aArea )

Return( .T. )


/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rogram   矨justaSX1 � Rev.  � Marco Bianchi         � Data � 21/07/2008 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噮o 矼odifica Titulo e Help da pergunta 03.                        潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   砃enhum                                                        潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros砃enhum                                                        潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                        潮�
北媚哪哪哪哪哪哪穆哪哪哪哪履哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� PROGRAMADOR  � DATA   � BOPS �  MOTIVO DA ALTERACAO                     潮�
北媚哪哪哪哪哪哪呐哪哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�              �        �      �                                          潮�
北滥哪哪哪哪哪哪牧哪哪哪哪聊哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/

Static Function AjustaSX1()

Local aHelpPor	:= {}
Local aHelpEng	:= {}
Local aHelpSpa	:= {}
Local aArea     := GetArea()
Local aAreaSX1  := SX1->(GetArea())


dbSelectArea("SX1")
dbSeek("MTA521    03")
If AllTrim(X1_PERGUNT) <> "Contabiliza?"

	RecLock("SX1",.F.)
	Replace X1_PERGUNT With "Contabiliza?"
	Replace X1_PERSPA  With "緾ontabiliza?"
	Replace X1_PERENG  With "Contabiliza?"
	MsUnLock()

	AAdd(aHelpPor,"Indica se os lan鏰mentos cont醔eis devem")
	AAdd(aHelpPor,"ser gerados durante a exclus鉶 do docu- ")
	AAdd(aHelpPor,"mento de sa韉a. N鉶 ser� poss韛el ger�- ")
	AAdd(aHelpPor,"lo pela contabiliza玢o Off-Line.")

	AAdd(aHelpSpa,"Indica si los asientos contables deben ")
	AAdd(aHelpSpa,"generarse durante el borrado de la 	  ")
	AAdd(aHelpSpa,"factura. No ser� posible generarlo por ")
	AAdd(aHelpSpa,"la contabilizaci髇 off-line.           ")

	AAdd(aHelpEng,"It indicates that the accounting entries")
	AAdd(aHelpEng,"must be generated during the exclusion  ")
	AAdd(aHelpEng,"of document output. You can not generate")
	AAdd(aHelpEng,"it by the accounting Off-Line.          ")

	PutSX1Help("P.MTA52103.",aHelpPor,aHelpEng,aHelpSpa)

EndIf

If dbSeek("MTA521    04")
	aHelpPor := {}

	AADD(aHelpPor,"Informando em carteira o sistema retorna a ")
	AADD(aHelpPor,"situa玢o dos pedido para n鉶 liberado, ")
	AADD(aHelpPor,"informando apto a faturar sujeita os pedidos ")
	AADD(aHelpPor,"a libera玢o novamente.")

	PutSX1Help("P.MTA52104.",aHelpPor)

EndIf
RestArea(aAreaSX1)
RestArea(aArea)

Return
/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rogram   矼A521VerSC6 � Rev.  � Vendas Clientes       � Data � 26/12/2009 潮�
北媚哪哪哪哪呐哪哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噮o 矲uncao que verifica se existe amarracao no Pedido de venda com  潮�
北�          砅edido de Compra, Caso exista e se jah foi feito recebimento de 潮�
北�          砫e alguma quantidade no pedido de compra o Pedido de venda nao  潮�
北�          硃odera ser cancelado.                                           潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   矻ogico .T. para cancelar - .F. nao Cancela                      潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros砅ARAM01 - Filial da nota de Saida (SF2)                         潮�
北�          砅ARAM02 - Numero do Documento                                   潮�
北�          砅ARAM03 - Serie do Documento                                    潮�
北�          砅ARAM04 - Codigo do Cliente									  潮�
北�          砅ARAM05 - Codigo da Loja 										  潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/

Static Function MA521VerSC6(cFILIAL,cDOC,cSERIE,cCLIENTE,cLOJA)
Local lRet     := .T.
Local aArea    := GetArea()
Local cFilPCom := ""        // Filial do Pedido de Compras
Local cPedCom  := ""        // Numero do Pedido de Compras
Local cProd    := ""        // Cod do Produto
Local cItemPC  := ""        // Item do Pedido de Compra
Local cNumC7   := ""        // Guarda o num para nao correr a Tabela Inteira.


Default cFilial   := ""
Default cDoc      := ""
Default cSerie    := ""
Default cCliente  := ""
Default cLoja     := ""

If SC6->(FieldPos("C6_PEDCOM")) > 0 .AND.  SC6->(FieldPos("C6_ITPC")) > 0 .AND. SC6->(FieldPos("C6_FILPED")) > 0
	If !Empty(cFilial) .AND. !Empty(cDoc) .AND. !Empty(cSerie) .AND. !Empty(cCliente) .AND.  !Empty(cLoja)
		DbSelectArea("SD2")
		DbSetOrder(3)
		If DbSeek(cFilial + cDoc + cSerie + cCliente + cLoja )
			cFilPCom  := SD2->D2_FILIAL
			cProd     := SD2->D2_COD
			cPedCom   := SD2->D2_PEDIDO
			cItemPC   := SD2->D2_ITEM
		    DbSelectArea("SC6")
		    DbSetOrder(2)
	   		If DbSeek(cFilPCom + cProd + cPedCom + cItemPC )
	   		    cFilPCom  := SC6->C6_FILPED
		   		cProd     := SC6->C6_PRODUTO
				cPedCom   := SC6->C6_PEDCOM
				cItemPC   := SC6->C6_ITPC
	   			DbSelectArea("SC7")
				DbSetOrder(4)
				If DbSeek(cFilPCom + cProd + cPedCom + cItemPC )
				    cNumC7 := SC7->C7_NUM
					While !Eof()
						lRet := If(SC7->C7_QUJE > 0, .F., .T. )
						If !lRet .OR. cNumC7 <> SC7->C7_NUM
						   Exit
						EndIf
						SC7->(DbSkip())
					End
				EndIf
			EndIf
		EndIf
	EndIf
EndIf
If !lRet
   Aviso(STR0007,STR0019,{ "Ok" } ) // "ATENCAO", "Documento n鉶 pode ser Excluido, pois esta associado a um Pedido de Compra",
EndIf
RestArea(aArea)
Return (lRet)

/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rogram   矨521CBxAdt  � Rev.  � Vendas CRM            � Data � 29/05/2012 潮�
北媚哪哪哪哪呐哪哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噮o 矯ancela Baixa dos Adiantamentos - Mexico                        潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   矻ogico .T. para sucesso  - .F. falha                            潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros�                                                                潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function A521CBxAdt()
Local lRet 		:= .T.
Local aStrFR3 	:= {}
Local aVetor 	:= {}
Local nX 		:= 0
Local cCpoQry 	:= ""
Local cQ		:= ""
Local nBaixa	:= 1	//Baixa selecionada para cancelar na rotina fina070

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//矯arrega array com titulos compensados nesta nota    �
//砯iscal, da tabela de Documento X Adiantamento       �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
aStrFR3 := FR3->(DbStruct())
For nX := 1 to Len(aStrFR3)
	cCpoQry += aStrFR3[nX][1] +" , "
Next nX

cQ	:= "SELECT "+cCpoQry+" R_E_C_N_O_ AS FR3_RECNO "
cQ += "FROM "+RetSqlName("FR3")+" "
cQ += "WHERE FR3_FILIAL = '"+xFilial("FR3")+"' "
cQ += "AND FR3_CART = 'R' "
cQ += "AND FR3_TIPO IN "+FormatIn(MVRECANT,"/")+" "
cQ += "AND FR3_CLIENT = '"+SF2->F2_CLIENTE+"' "
cQ += "AND FR3_LOJA = '"+SF2->F2_LOJA+"' "
cQ += "AND FR3_DOC = '"+SF2->F2_DOC+"' "
cQ += "AND FR3_SERIE = '"+SF2->F2_SERIE+"' "
cQ += "AND D_E_L_E_T_= ' ' "

cQ := ChangeQuery(cQ)

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQ),"TRBFR3",.T.,.T.)
TcSetField("TRBFR3","FR3_VALOR","N",TamSX3("FR3_VALOR")[1],TamSX3("FR3_VALOR")[2])

While !Eof()
	aVetor 	:= {}
	//Procura uma baixa n鉶 cancelada com o Valor igual ao relacionado ao adiantamento
	DbSelectArea("SE5")
	DbSetOrder(7)
	If MsSeek(XFilial("SE5")+TRBFR3->FR3_PREFIX+TRBFR3->FR3_NUM+TRBFR3->FR3_PARCEL+TRBFR3->FR3_TIPO+SF2->F2_CLIENTE+SF2->F2_LOJA)
		nBaixa := 1
		While !Eof()
			If SE5->E5_SITUACA == 'C'
				DbSkip()
				Loop
			EndIf
			If SE5->E5_VALOR == TRBFR3->FR3_VALOR
				Exit
			EndIf
			nBaixa++
			DbSkip()
		EndDo
	Else
		lRet := .F.
		Exit
	EndIf

	aVetor 	:= {{"E1_PREFIXO"	, TRBFR3->FR3_PREFIX			,Nil},;
				{"E1_NUM"		, TRBFR3->FR3_NUM      			,Nil},;
				{"E1_PARCELA"	, TRBFR3->FR3_PARCEL			,Nil},;
				{"E1_TIPO"	    , TRBFR3->FR3_TIPO				,Nil}}

	MSExecAuto({|x,y| Fina070(x,y,.F.,nBaixa)},aVetor,5)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
		lRet := .F.
		Exit
	Else
		dbSelectArea("FR3")
		dbGoto(TRBFR3->FR3_RECNO)
		RecLock("FR3",.F.)
		DbDelete()
		MsUnlock()
	EndIf
	dbSelectArea("TRBFR3")
	DbSkip()
EndDo

TRBFR3->(dbCloseArea())

Return lRet

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪穆哪哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲uncao    矨521CCompAd � Autor 砊otvs                � Data �22.04.2010潮�
北媚哪哪哪哪呐哪哪哪哪牧哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o 矲az o cancelamento da compensacao do adiantamento           潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   矱xpL1: Indica se a Compensacao foi excluida                 潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros矱xpA1: Array com o Recno dos titulos gerados                潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砄bservacao�                                                            潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�   DATA   � Programador   矼anutencao Efetuada                         潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�          �               �                                            潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
Static Function A521CCompAd(aRegSE1)

Local aArea	:= GetArea()
Local aAreaSE1	:= SE1->(GetArea())
Local lContabiliza := .T.
Local lDigita := .T.
Local lAglutina := .F.
Local aRecRetRA := {}	// Retorno da funcao que carrega os titulos de Adiantamento
Local nCnt := 0 	// Variavel utilizado em loop
Local aRecNoRA := {}	// Recebe o Recno do Titulo de Adiantamento
Local aRecVlrRA := {}	// Recebe o valor limite para compensa玢o do Titulo de Adiantamento
Local cQ := ""
Local aDocCmp := {}
/* estrutura array aDocCmp
//1 - E5_PREFIXO
//2 - E5_NUMERO
//3 - E5_PARCELA
//4 - E5_TIPO
//5 - E5_LOJA
//6 - E5_VALOR
//7 - F2_DOC
//8 - F2_SERIE
//9 - Logico - indica se compensacao foi realizada no momento da geracao do documento de saida
*/
Local nTamPref := TamSX3("E1_PREFIXO")[1]
Local nTamNum := TamSX3("E1_NUM")[1]
Local nTamParc := TamSX3("E1_PARCELA")[1]
Local nTamTipoT := TamSX3("E1_TIPO")[1]
Local nTamLoja := TamSX3("E1_LOJA")[1]
Local nPos := 0
Local aRecnoFR3 := {} // array para guardar o recno dos registros da tabela FR3, referente aos adiantamentos compensados com a nota fiscal, no momento da geracao da nota
Local lRet := .T.
Local aEstorno := {} // array para guardar o conteudo do campo E5_DOCUMEN dos registros usados na compensacao
Local aEstornoTmp := {}
Local aDocCmpTmp := {}
Local nX		:= 0
Local cCpoQry 	:= ""

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//砎erifica se h� ao menos 1 parcela nesta venda�
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
If Len(aRegSE1) >= 1

	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//矯arrega array com titulos compensados nesta nota    �
	//砯iscal                                              �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	cQ	:= "SELECT E5_DOCUMEN,E5_VALOR,E5_NUMERO,E5_PREFIXO,E5_PARCELA,E5_TIPO,E5_CLIFOR,E5_LOJA,E5_SEQ "
	cQ += "FROM "+RetSqlName("SE5")+" "
	cQ += "WHERE E5_FILIAL = '"+xFilial("SE5")+"' "
	cQ += "AND E5_RECPAG = 'R' "
	cQ += "AND E5_SITUACA <> 'C' "
	cQ += "AND E5_DATA = '"+dTos(SF2->F2_EMISSAO)+"' "
	cQ += "AND E5_NUMERO = '"+SF2->F2_DUPL+"' "
	cQ += "AND E5_PREFIXO = '"+SF2->F2_PREFIXO+"' "
	cQ += "AND E5_CLIFOR = '"+SF2->F2_CLIENTEr+"' "
	cQ += "AND E5_LOJA = '"+SF2->F2_LOJA+"' "
	cQ += "AND E5_MOTBX = 'CMP' "
	cQ += "AND E5_TIPODOC = 'CP' "
	cQ += "AND E5_TIPO = '"+MVNOTAFIS+"' "
	cQ += "AND D_E_L_E_T_= ' ' "

	cQ := ChangeQuery(cQ)

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQ),"TRBSE5",.T.,.T.)
	TcSetField("TRBSE5","E5_VALOR","N",TamSX3("E5_VALOR")[1],TamSX3("E5_VALOR")[2])

   While !Eof()
		If !TemBxCanc(TRBSE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ),.T.)
	   	aAdd(aDocCmpTmp,{Subs(TRBSE5->E5_DOCUMEN,1,nTamPref),Subs(TRBSE5->E5_DOCUMEN,nTamPref+1,nTamNum),Subs(TRBSE5->E5_DOCUMEN,nTamPref+nTamNum+1,nTamParc),;
   		Subs(TRBSE5->E5_DOCUMEN,nTamPref+nTamNum+nTamParc+1,nTamTipoT),Subs(TRBSE5->E5_DOCUMEN,nTamPref+nTamNum+nTamParc+nTamTipoT+1,nTamLoja),TRBSE5->E5_VALOR,;
   		SF2->F2_DOC,SF2->F2_SERIE,.F.})
   	Endif
   	dbSkip()
   Enddo

   TRBSE5->(dbCloseArea())

	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
	//矯arrega array com titulos compensados nesta nota    �
	//砯iscal, da tabela de Documento X Adiantamento       �
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
	aStrFR3 := FR3->(dbStruct())
	For nX := 1 to Len(aStrFR3)
		cCpoQry += aStrFR3[nX][1] +" , "
	Next nX

	cQ	:= "SELECT "+cCpoQry+" R_E_C_N_O_ AS FR3_RECNO "
	cQ += "FROM "+RetSqlName("FR3")+" "
	cQ += "WHERE FR3_FILIAL = '"+xFilial("FR3")+"' "
	cQ += "AND FR3_CART = 'R' "
	cQ += "AND FR3_TIPO IN "+FormatIn(MVRECANT,"/")+" "
	cQ += "AND FR3_CLIENT = '"+SF2->F2_CLIENTE+"' "
	cQ += "AND FR3_LOJA = '"+SF2->F2_LOJA+"' "
	cQ += "AND FR3_DOC = '"+SF2->F2_DOC+"' "
	cQ += "AND FR3_SERIE = '"+SF2->F2_SERIE+"' "
	cQ += "AND D_E_L_E_T_= ' ' "

	cQ := ChangeQuery(cQ)

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQ),"TRBFR3",.T.,.T.)
	TcSetField("TRBFR3","FR3_VALOR","N",TamSX3("FR3_VALOR")[1],TamSX3("FR3_VALOR")[2])

   While !Eof()
   	nPos := aScan(aDocCmpTmp,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+Alltrim(Str(x[6]))+x[7]+x[8] == ;
		TRBFR3->(FR3_PREFIX+FR3_NUM+FR3_PARCEL+FR3_TIPO+FR3_LOJA)+Alltrim(Str(TRBFR3->FR3_VALOR))+TRBFR3->(FR3_DOC+FR3_SERIE)})
   	If nPos > 0
	   	aDocCmpTmp[nPos][9] := .T.
	   Endif
	   aAdd(aRecnoFR3,TRBFR3->FR3_RECNO)
   	dbSkip()
   Enddo

   TRBFR3->(dbCloseArea())

	//grava no array aDocCmp soh os adiantamentos que pertencem a compensacao referente a geracao da nota fiscal
	For nCnt:=1 To Len(aDocCmpTmp)
		If aDocCmpTmp[nCnt][9]
			aAdd(aDocCmp,aDocCmpTmp[nCnt])
			aAdd(aRecVlrRA,aDocCmpTmp[nCnt][6])
		Endif
	Next nCnt

   If Len(aDocCmp) > 0
   	//grava array aEstorno com a mesma chave do campo E5_DOCUMEN, para uso na rotina MaIntBxCr
   	For nCnt:=1 To Len(aDocCmp)
	   	aAdd(aEstornoTmp,Alltrim(aDocCmp[nCnt][1]+aDocCmp[nCnt][2]+aDocCmp[nCnt][3]+aDocCmp[nCnt][4]+aDocCmp[nCnt][5]))
   	Next nCnt
   	If Len(aEstornoTmp) > 0
   		aAdd(aEstorno,aEstornoTmp)
   	Endif
   	// grava recno dos adiantamentos compensados
   	dbSelectArea("SE1")
   	dbSetOrder(2) // filial+cliente+loja+prefixo+numero+parcela+tipo
   	For nCnt:=1 To Len(aDocCmp)
	   	If dbSeek(xFilial("SE1")+SF2->F2_CLIENTE+SF2->F2_LOJA+aDocCmp[nCnt][1]+aDocCmp[nCnt][2]+aDocCmp[nCnt][3]+aDocCmp[nCnt][4])
	   		aAdd(aRecnoRA,SE1->(Recno()))
	   	Endif
	   Next nCnt
	   If Len(aRecnoRA) > 0.and. Len(aEstorno) > 0 .and. Len(aRecVlrRA) > 0

			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
			//矯arrega o pergunte da rotina de compensa玢o financeira�
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
			Pergunte("FIN330",.F.)

			lContabiliza 	:= MV_PAR09 == 1
			lDigita			:= MV_PAR07 == 1

			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
			//矱xcluir Compensacao dos valores no Financeiro�
			//哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
			SE1->(MsGoTo(aRegSE1[1]))
			If SE1->(Recno()) = aRegSE1[1]
				lRet := .F.
				lRet := MaIntBxCR(3,{aRegSE1[1]},,aRecNoRA,,{lContabiliza,lAglutina,lDigita,.F.,.F.,.F.},,aEstorno,,,SE1->E1_VALOR,,aRecVlrRA)
			Endif

			Pergunte("MTA521",.F.)

			// busca todas as compensacoes referentes a esta nota fiscal e ajusta o valor compensado para cada pedido de venda
			If Len(aRecnoFR3) > 0 .and. lRet
				SE1->(MsGoTo(aRegSE1[1]))
				If SE1->(Recno()) = aRegSE1[1]

				//
				//		Criterio "!Empty(SE1->E1_BAIXA)" alterado:
				//		1- Exclusao da NFS sem baixa - Campo E1_BAIXA" esta com data
				//		2- Exclusao da NFS com cancelamento de baixa - Campo E1_BAIXA" esta vazio
				//		If SE1->E1_VALOR = SE1->E1_SALDO .and. Empty(SE1->E1_BAIXA) // verifica se o titulo esta em aberto
				//
					If SE1->E1_VALOR = SE1->E1_SALDO // .and. Empty(SE1->E1_BAIXA) // verifica se o titulo esta em aberto
						For nCnt:=1 To Len(aRecnoFR3)
							dbSelectArea("FR3")
							dbGoto(aRecnoFR3[nCnt])
							If Recno() = aRecnoFR3[nCnt]
								SE1->(dbSetOrder(2))
								If SE1->(MsSeek(xFilial("SE1")+FR3->(FR3_CLIENTE+FR3_LOJA+FR3_PREFIXO+FR3_NUM+FR3_PARCELA+FR3_TIPO)))

									//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
									//矨juste do saldo do relacionamento no Financeiro�
									//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
								    FPedAdtGrv("R",4,FR3->FR3_PEDIDO,{{FR3->FR3_PEDIDO,SE1->(RecNo()),(FR3->FR3_VALOR*-1)}},.T.,SF2->F2_DOC,SF2->F2_SERIE)
					   		Endif
							Endif
						Next nCnt

						//exclui registro do titulo principal da tabela FR3
						SE1->(MsGoTo(aRegSE1[1]))
						If SE1->(Recno()) = aRegSE1[1]
							dbSelectArea("FR3")
							dbSetOrder(2)
							If dbSeek(xFilial("FR3")+"R"+SE1->(E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)+SF2->F2_DOC+SF2->F2_SERIE)
								RecLock("FR3",.F.)
								dbDelete()
								MsUnlock()
							Endif
						Endif
					Else
						lRet := .F.
					Endif
				Endif
			Endif
		Endif
	Endif
EndIf

SE1->(RestArea(aAreaSE1))
RestArea(aArea)

Return(lRet)
//-------------------------------------
/*	Modelo de Dados
@author  	Jefferson Tomaz
@version 	P10 R1.4
@build		7.00.101202A
@since 		06/04/2011
@return 		oModel Objeto do Modelo*/
//-------------------------------------
Static Function ModelDef()
Local oModel
Local oStructSF2      := FWFormStruct(1,"SF2")
Local oStructSD2      := FWFormStruct(1,"SD2")
Local oStruRSA1       := Nil
Local oStruDSA1       := Nil
Local oStructSF3      := Nil
Local oStructSX5	  := Nil
Local cCdclfr         := SuperGetMv("MV_CDCLFR",.F.,"1")
Local lIntGFE   := SuperGetMv('MV_INTGFE',,.F.)

If lIntGFE

	oStruRSA1      := FWFormStruct(1,"SA1",{|cCampo| AllTrim(cCampo)+"|" $ "A1_COD|A1_LOJA|A1_NREDUZ|A1_CGC|A1_END|A1_BAIRRO|A1_MUN|A1_EST|A1_COD_MUN|A1_CEP|A1_ENDENT|A1_BAIRROE|A1_CEPE|A1_MUNE|A1_ESTE|"})
	oStruDSA1      := FWFormStruct(1,"SA1",{|cCampo| AllTrim(cCampo)+"|" $ "A1_COD|A1_LOJA|A1_NREDUZ|A1_CGC|A1_END|A1_BAIRRO|A1_MUN|A1_EST|A1_COD_MUN|A1_CEP|A1_ENDENT|A1_BAIRROE|A1_CEPE|A1_MUNE|A1_ESTE|"})
	oStructSF3     := FWFormStruct(1,"SF3",{|cCampo| AllTrim(cCampo)+"|" $ "F3_SERIE|F3_NFISCAL|F3_CLIEFOR|F3_LOJA|F3_DTCANC|"})
	oStructSX5	   := FWFormStruct(1,"SX5")

	oStructSF2:AddField( ;                    // Ord. Tipo Desc.
	"F2_CDCLF"                       , ;      // [01]  C   Titulo do campo
	"Class.frete"                    , ;      // [02]  C   ToolTip do campo
	"F2_CDCLFR"                      , ;      // [03]  C   Id do Field
	'C'                              , ;      // [04]  C   Tipo do campo
	5                                , ;      // [05]  N   Tamanho do campo
	0                                , ;      // [06]  N   Decimal do campo
	NIL                              , ;      // [07]  B   Code-block de valida玢o do campo
	NIL                              , ;      // [08]  B   Code-block de valida玢o When do campo
	NIL                              , ;      // [09]  A   Lista de valores permitido do campo
	NIL                              , ;      // [10]  L   Indica se o campo tem preenchimento obrigat髍io
	NIL                              , ;      // [11]  B   Code-block de inicializacao do campo
	NIL                              , ;      // [12]  L   Indica se trata-se de um campo chave
	NIL                              , ;      // [13]  L   Indica se o campo pode receber valor em uma opera玢o de update.
	NIL                              )        // [14]  L   Indica se o campo � virtual

	oStructSF2:AddField( ;                    // Ord. Tipo Desc.
	"CGC Transp"                     , ;      // [01]  C   Titulo do campo
	"CGC Transp"                     , ;      // [02]  C   ToolTip do campo
	"F2_CGCTRP"                      , ;      // [03]  C   Id do Field
	'C'                              , ;      // [04]  C   Tipo do campo
	14                               , ;      // [05]  N   Tamanho do campo
	0                                , ;      // [06]  N   Decimal do campo
	NIL                              , ;      // [07]  B   Code-block de valida玢o do campo
	NIL                              , ;      // [08]  B   Code-block de valida玢o When do campo
	NIL                              , ;      // [09]  A   Lista de valores permitido do campo
	NIL                              , ;      // [10]  L   Indica se o campo tem preenchimento obrigat髍io
	FwBuildFeature( STRUCT_FEATURE_INIPAD,'Posicione("SA4",1,xFilial("SA4")+SF2->F2_TRANSP,"A4_CGC")' ), ;      // [11]  B   Code-block de inicializacao do campo
	NIL                              , ;      // [12]  L   Indica se trata-se de um campo chave
	NIL                              , ;      // [13]  L   Indica se o campo pode receber valor em uma opera玢o de update.
	.T.                              )        // [14]  L   Indica se o campo � virtual

	oStruRSA1:AddField( ;                    // Ord. Tipo Desc.
	"IBGE Compl"                     , ;      // [01]  C   Titulo do campo
	"Cod.IBGE Compl "                , ;      // [02]  C   ToolTip do campo
	"A1_CDIBGE"                      , ;      // [03]  C   Id do Field
	'C'                              , ;      // [04]  C   Tipo do campo
	7                                , ;      // [05]  N   Tamanho do campo
	0                                , ;      // [06]  N   Decimal do campo
	NIL                              , ;      // [07]  B   Code-block de valida玢o do campo
	NIL                              , ;      // [08]  B   Code-block de valida玢o When do campo
	NIL                              , ;      // [09]  A   Lista de valores permitido do campo
	NIL                              , ;      // [10]  L   Indica se o campo tem preenchimento obrigat髍io
	FwBuildFeature( STRUCT_FEATURE_INIPAD,'TMS120CdUf(SA1->A1_EST, "1") + SA1->A1_COD_MUN' ), ;   // [11]  B   Code-block de inicializacao do campo
	NIL                              , ;      // [12]  L   Indica se trata-se de um campo chave
	NIL                              , ;      // [13]  L   Indica se o campo pode receber valor em uma opera玢o de update.
	.T.                              )        // [14]  L   Indica se o campo � virtual

	oStruDSA1:AddField( ;                    // Ord. Tipo Desc.
	"IBGE Compl"                     , ;      // [01]  C   Titulo do campo
	"Cod.IBGE Compl "                , ;      // [02]  C   ToolTip do campo
	"A1_CDIBGE"                      , ;      // [03]  C   Id do Field
	'C'                              , ;      // [04]  C   Tipo do campo
	7                                , ;      // [05]  N   Tamanho do campo
	0                                , ;      // [06]  N   Decimal do campo
	NIL                              , ;      // [07]  B   Code-block de valida玢o do campo
	NIL                              , ;      // [08]  B   Code-block de valida玢o When do campo
	NIL                              , ;      // [09]  A   Lista de valores permitido do campo
	NIL                              , ;      // [10]  L   Indica se o campo tem preenchimento obrigat髍io
	FwBuildFeature( STRUCT_FEATURE_INIPAD,'TMS120CdUf(SA1->A1_EST, "1") + SA1->A1_COD_MUN' ), ;   // [11]  B   Code-block de inicializacao do campo
	NIL                              , ;      // [12]  L   Indica se trata-se de um campo chave
	NIL                              , ;      // [13]  L   Indica se o campo pode receber valor em uma opera玢o de update.
	.T.                              )        // [14]  L   Indica se o campo � virtual

	oStructSF2:SetProperty( '*', MODEL_FIELD_VALID, FWBuildFeature( STRUCT_FEATURE_VALID, '.T.' ) )
	oStructSF2:SetProperty( '*'         , MODEL_FIELD_WHEN,  NIL )

	oStructSD2:SetProperty( '*', MODEL_FIELD_VALID, FWBuildFeature( STRUCT_FEATURE_VALID, '.T.' ) )
	oStructSD2:SetProperty( '*'         , MODEL_FIELD_WHEN,  NIL )

	oStructSF3:SetProperty( '*', MODEL_FIELD_VALID, FWBuildFeature( STRUCT_FEATURE_VALID, '.T.' ) )
	oStructSF3:SetProperty( '*'         , MODEL_FIELD_WHEN,  NIL )


	oStruDSA1:SetProperty( '*', MODEL_FIELD_VALID, FWBuildFeature( STRUCT_FEATURE_VALID, '.T.' ) )
	oStruDSA1:SetProperty( '*'         , MODEL_FIELD_WHEN,  NIL )

	oStruRSA1:SetProperty( '*', MODEL_FIELD_VALID, FWBuildFeature( STRUCT_FEATURE_VALID, '.T.' ) )
	oStruRSA1:SetProperty( '*'         , MODEL_FIELD_WHEN,  NIL )

EndIf
oModel := MPFormModel():New("MATA521",  /*bPre*/, /*bPost*/, Nil /*bCommit*/, /*bCancel*/)

oModel:AddFields("MATA521_SF2", ,oStructSF2,/*bPre*/,/*bPost*/,/*bLoad*/)
oModel:AddGrid("MATA521_SD2","MATA521_SF2",oStructSD2,/*bLinePre*/, ,/*bPre*/,/*bPost*/,/*bLoad*/)

oModel:SetRelation("MATA521_SD2",{{"D2_FILIAL",'xFilial("SF2")'},{"D2_DOC","F2_DOC"},{"D2_SERIE","F2_SERIE"},;
                                  {"D2_CLIENTE","F2_CLIENTE"},{"D2_LOJA","F2_LOJA"}},"D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA")

If lIntGFE

	oModel:AddFields("MATA521_SF3","MATA521_SF2",oStructSF3,/*bPre*/,/*bPost*/,/*bLoad*/)
	oModel:AddFields("REMETENTE_SA1","MATA521_SF2",oStruRSA1,/*bPre*/,/*bPost*/,/*bLoad*/)
	oModel:AddFields("DESTINATARIO_SA1","MATA521_SF2",oStruDSA1,/*bPre*/,/*bPost*/,/*bLoad*/)
	oModel:AddFields("TIPONF_SX5","MATA521_SF2",oStructSX5,/*bPre*/,/*bPost*/,/*bLoad*/)

	oModel:SetRelation("MATA521_SF3",{{"F3_FILIAL",'xFilial("SF3")'},{"F3_SERIE","F2_SERIE"},{"F3_NFISCAL","F2_DOC"},;
                                  {"F3_CLIEFOR","F2_CLIENTE"},{"F3_LOJA","F2_LOJA"}},"F3_FILIAL+F3_SERIE+F3_NFISCAL+F3_CLIEFOR+F3_LOJA")

	oModel:SetRelation("REMETENTE_SA1",{{"A1_FILIAL",'xFilial("SA1")'},{"A1_CGC","SM0->M0_CGC"}},"A1_FILIAL+A1_CGC")

	oModel:SetRelation("DESTINATARIO_SA1",{{"A1_FILIAL",'xFilial("SA1")'},{"A1_COD","F2_CLIENT"},{"A1_LOJA","F2_LOJENT"}};
	                                  ,"A1_FILIAL+A1_COD+A1_LOJA")

	oModel:SetRelation("TIPONF_SX5",{{"X5_FILIAL",'xFilial("SX5")'},{"X5_TABELA","'MQ'"}, {"X5_CHAVE","F2_TIPO"}},"X5_FILIAL+X5_TABELA+X5_CHAVE")

EndIf

oModel:SetPrimaryKey({"F2_FILIAL", "F2_DOC", "F2_SERIE", "F2_CLIENTE", "F2_LOJA" })
oModel:GetModel("MATA521_SD2"):SetDelAllLine(.T.)

oModel:SetDescription( OemToAnsi(STR0001) )

Return oModel

/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    � T521Tela � Autor � Mary C. Hergert       � Data � 21/11/07 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Monta a dialog da consulta                                 潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros� ExpC1 = Numero do documento                                潮�
北�          � ExpC2 = Serie                                              潮�
北�          � ExpC3 = Especie                                            潮�
北�          � ExpC4 = Cliente/Fornecedor                                 潮�
北�          � ExpC5 = Loja                                               潮�
北�          � ExpC6 = Tipo - entrada / saida                             潮�
北�          � ExpC7 = Indica se o documento e de devol/beneficiamento    潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   � Nenhum						                              潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� Uso      � Mata521                                                    潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function T521Tela(cDoc,cSerie,cEspecie,cClieFor,cLoja,cEntSai,cTpNF)

Local aCmp			:= {}
Local aPaineis		:= {}
Local aPnTree		:= {}
Local aOpcao		:= {}
Local aSize 		:= MsAdvSize()
Local aPnlNF		:= {}
Local aGets			:= {}
Local aMantem		:= {{},{},{},{},{},{},{},{},{},{}}  //Arrays 7 e 8 (Anfavea - Cab / Itens), 9 - Informa珲es Complementares
Local aSugerido		:= {}
Local aObrigat		:= {{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}} //Arrays 16 e 17 (Anfavea - Cab / Itens), 18 - Informa珲es Complementares
Local aGNRE			:= {}
Local aLocal		:= {}
Local aObjects 		:= {}
Local aPosObj		:= {}
Local aInfo			:= {}
Local aPosObj2		:= {}
Local aRessarc		:= {}
Local aImport		:= {}

Local cDescr		:= ""
Local cTab			:= ""

Local lRet			:= .F.
Local lValid		:= .F.
Local lExpInd		:= .F.
Local lRetorno      := .F.

Local nX			:= 0
Local nTop    		:= 0
Local nLeft   		:= 0
Local nBottom 		:= 0
Local nRight  		:= 0

Local oDlg
Local oPanel
Local oPanel3
Local oFont			:= TFont():New("Arial",,14,,.F.)
Local oFont16		:= TFont():New("Arial",,16,,.F.)
Local oFont16b		:= TFont():New("Arial",,16,,.T.)

Local oGrpProc
Local oGetProc


Local nAltSay		:= 10
Local nTamSay		:= 50
Local nAltGet		:= 10
Local nPainel		:= 0
Local nCorDisab		:= CLR_HGRAY
Local nPos			:= 0
Local nOpc			:= 0

Private aHProc		:= {}
Private aCProc		:= {}
Private dDatReceb   := CtoD("  /  /    ")

Private cFormul		:= ""
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//�->Informacoes complementares a gerar:�
//�10 - Processos                       �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Resolve os objetos lateralmente                                        �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
aObjects := {}

AAdd( aObjects, { 72,   40, .T., .T. } )
AAdd( aObjects, { 150,  50, .T., .T. } )

aInfo   := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }


DEFINE FONT oFont NAME "Arial" SIZE 0, -10
DEFINE FONT oFont2 NAME "Arial" SIZE 0, -10

DEFINE MSDIALOG oDlg FROM 00,00 TO 600,750 TITLE STR0034 OF oMainWnd PIXEL //"Complementos por documento fiscal"

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//矼onta o Cabe鏰lho padrao para todos os complementos�
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
T521NF(oFont,nAltSay,nTamSay,nAltGet,cDoc,cSerie,cEspecie,cClieFor,cLoja,cEntSai,cTpNF,/*@aPnlNF,*/oDlg)


//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//矯arrega o aCols e o aHeader dos complementos e das informacoes complementares �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
Processa({|| T521Cols(cDoc,cSerie,cEspecie,cClieFor,cLoja,cEntSai,cTpNF,/*@aCompl,*/@aObrigat,@aMantem)})

// Processos referenciados
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//矼onta o painel onde serao inseridas as informacoes do complemento�
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
oPanel3	:= TPanel():New(100,5,'',oDlg,oDlg:oFont,.T.,.T.,,,360,185,.T.,.T.)
oGrpProc:= TGroup():New(5,5,180,355,STR0046,oPanel3,,,.T.,.T.) //"Informa珲es complementares - processos referenciados"

//谀哪哪哪哪哪哪哪哪�
//矼onta a Getdados �
//滥哪哪哪哪哪哪哪哪�
oGetProc := MsNewGetDados():New(15,10,175,350,GD_INSERT+GD_DELETE+GD_UPDATE,/*LinhaOk*/,/*GetdadosOk*/,/*cIniPos*/,/*aAlter*/,/*.F.*/,990,/*cAmpoOk*/,/*cSuperApagar*/,/*cApagaOk*/,oGrpProc,aHProc,aCProc)
oGetProc:bLinhaOk := &("{|| T521Proc(oGetProc,aObrigat,.F.) }")

aGets := {oGetProc}


ACTIVATE MSDIALOG oDlg ON INIT ;
EnchoiceBar(oDlg,{||(nOpc := 1, lValid := T521Valid(cDoc,cSerie,cEspecie,cClieFor,cLoja,cEntSai,cTpNF,aMantem,aGets,aObrigat,aMantem),;
Iif(lValid,Processa({||lRet := T521Fim(cDoc,cSerie,cEspecie,cClieFor,cLoja,cEntSai,cTpNF,aMantem,aGets)}),.F.),;
Iif(lRet,oDlg:End(),.T.))},;
{||(nOpc:= 0, oDlg:End())})

If ((nOpc == 1)  .And. (lRet))
   lRetorno = .T.
EndIf

Return lRetorno


/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    � T521Cols � Autor � Mary C. Hergert       � Data � 26/11/07 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Monta o aHeader e o aCols dos complementos que devem       潮�
北�          � apresentar informacoes por item - GetDados.                潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros� ExpA1 = Array com os complementos                          潮�
北�          � ExpC2 = Numero da nota fiscal                              潮�
北�          � ExpC3 = Serie da nota fiscal                               潮�
北�          � ExpC4 = Especie da nota fiscal                             潮�
北�          � ExpC5 = Cliente/fornecedor                                 潮�
北�          � ExpC6 = Loja do cliente/fornecedor                         潮�
北�          � ExpC7 = Indicacao de entrada/saida                         潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   � Nao ha.                                                    潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砋so       � Mata521                                                    潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function T521Cols(cDoc,cSerie,cEspecie,cClieFor,cLoja,cEntSai,cTpNF,/*aCompl,*/aObrigat,aMantem)

Local aCampos 	:= {}
Local aHeader	:= {}
Local aCols		:= {}
Local aPermite	:= {}
Local aCabPer	:= {}

Local cTabela	:= ""
Local cCampo	:= ""
Local cAlias	:= ""
Local cArqInd	:= ""
Local cChave	:= ""

Local lQuery	:= .F.
Local lPossui	:= .F.
Local lDocOri	:= CDL->(FieldPos("CDL_DOCORI")) > 0 .AND. CDL->(FieldPos("CDL_SERORI")) > 0
Local lDocExp	:= CDL->(FieldPos("CDL_NFEXP")) > 0 .AND. CDL->(FieldPos("CDL_SEREXP")) > 0 .AND. CDL->(FieldPos("CDL_ESPEXP")) > 0 .AND. CDL->(FieldPos("CDL_EMIEXP")) > 0 .AND. CDL->(FieldPos("CDL_CHVEXP")) > 0  .AND. CDL->(FieldPos("CDL_QTDEXP")) > 0 .And. CDL->(FieldPos("CDL_ITEMNF")) > 0 .And. CDL->(FieldPos("CDL_ITEORI")) > 0 .And. CDL->(FieldPos("CDL_PRDORI")) > 0 .And. CDL->(FieldPos("CDL_PRODNF")) > 0
Local lTabCDT	:= AliasIndic("CDT")
Local lCompCD0	:= AliasIndic("CD0")

Local nX 		:= 10
Local nY 		:= 0
Local nG 		:= 0
Local nCount	:= 1
Local nI		:= 0
Local nScan		:= 0

Local cValidCpoAnt	:= ""
Local cValidCpoNov	:= ""
Local nA					:= 0


aCampos		:= {}
aCols		:= {}
aHeader		:= {}
aPermite 	:= {}
aCabPer		:= {}

// Informacoes complementares - processos referenciados
aCampos := {"CDG_PROCES","CDG_TPPROC","CDG_IFCOMP"}
cTabela := "CDG"


	If Len(aCampos) > 0

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//� Montando aHeader                                             �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		dbSelectArea("SX3")
		dbSetOrder(2)
		For nY := 1 to Len(aCampos)
			If SX3->(dbSeek(aCampos[nY]))

				If X3USO(SX3->X3_USADO)

					cF3 	:= SX3->X3_F3
					cValid	:= SX3->X3_VALID

					aAdd(aHeader,{Alltrim(X3Titulo(SX3->X3_TITULO)),;
						SX3->X3_CAMPO,;
						SX3->X3_PICTURE,;
						SX3->X3_TAMANHO,;
						SX3->X3_DECIMAL,;
						cValid,;
						SX3->X3_USADO,;
						SX3->X3_TIPO,;
						cF3,;
						SX3->X3_CONTEXT})
				Endif
		   		If X3Obrigat(SX3->X3_CAMPO)
					aAdd(aObrigat[nX],{SX3->X3_CAMPO,SX3->X3_TIPO})
				Endif
			Endif
		Next


		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		//矼onta os filtros para cada uma das tabelas para carregar o aCols �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
	   	lPossui := T521Filtro(cTabela,@cArqInd,@cChave,@cAlias,@lQuery,cDoc,cSerie,cEspecie,cClieFor,cLoja,cEntSai,cTpNF)

		If !lPossui
			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
			//砅ara os complementos por item, carrega com o conteudo dos itens do SFT�
			//硄ue permitem o complemento.                                           �
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
			If Len(aPermite) > 0
				For nI := 1 to Len(aPermite)
					aAdd(aCols,Array(Len(aHeader)+1))
					For nY := 1 To Len(aHeader)
						aCols[Len(aCols)][nY] := CriaVar(aHeader[nY][2])
						aCols[Len(aCols)][Len(aHeader)+1] := .F.
						nScan := aScan(aCabPer,{|x| x == Alltrim(aHeader[nY][2])})
						If nScan > 0
							aCols[Len(aCols)][nY] := aPermite[nI][nScan]
						Endif
					Next nY
				Next
			Else
				aAdd(aCols,Array(Len(aHeader)+1))
				For nY := 1 To Len(aHeader)
					aCols[Len(aCols)][nY] := CriaVar(aHeader[nY][2])
					aCols[Len(aCols)][Len(aHeader)+1] := .F.
				Next nY
			Endif
		Else
			nCount := 1
			dbSelectArea(cAlias)
			While !Eof()
				//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪膁�
				//砈era necessario armazenar os complementos de importacao gravados anteriormente.         �
				//矯omo neste tipo de complemento e possivel alterar o numero do documento de importacao   �
				//�(que faz parte da chave), armazena-se os complementos existentes para a atualiza玢o das �
				//砳nformacoes prestadas pelo usuario.                                                     �
				//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪膁�
				If nX == 10 .And. cTabela == "CDG"
					aAdd(aMantem[2],{CDG_PROCES,CDG_TPPROC,.F.})
				Endif
				nCount++

				Aadd(aCols,Array(Len(aHeader)+1))

				For nY :=1 to Len(aHeader)
					cTipo := aHeader[nY][8]
					If cTipo == "D"
						cData := (cAlias)->(FieldGet(FieldPos(aHeader[nY,2])))
						If !Empty(cData)
							#IFDEF TOP
								cData2:= substr(cdata,7,2)+'/'+substr(cdata,5,2)+'/'+substr(cdata,1,4)
							#ELSE
								cData2:= dtoc(cdata)
							#ENDIF
						Else
							cData2:= "  /  /    "
						Endif
						aCols[Len(aCols)][nY] := Ctod(cData2)
					else
						aCols[Len(aCols)][nY] := (cAlias)->(FieldGet(FieldPos(aHeader[nY,2])))
					EndIf
				Next nY
				aCols[Len(aCols)][Len(aHeader)+1] := .F.
				dbSkip()
			EndDo

			//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
			//矨o reabrir a tela de complementos apos exclusao, deve-se verificar os campos que devem ser preenchidos pela	�
			//硆otina, coloca-los em ordem e apresentar na tela todos os itens da nota fiscal novamente						�
			//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		  	If cTabela $ "CD5/CD6"
			  	For nG := 1 To Len(aPermite)
					If aScan(aCols,{|aX|aX[1]==aPermite[nG,7]})==0
						aAdd(aCols,Array(Len(aHeader)+1))
						//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
						//矷mportacao - Itens excluidos sao reabertos com o campo CD5_ITEM preenchido.�
						//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
	                    If cTabela == "CD5"
							aCols[Len(aCols)][1]	:=	aPermite[nG,7]

							For nY := 2 To Len(aHeader)
								aCols[Len(aCols)][nY] := CriaVar(aHeader[nY][2])
								aCols[Len(aCols)][Len(aHeader)+1] := .F.
							Next nY
						//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
						//矯ombustiveis - Itens excluidos sao reabertos com os campos CD6_ITEM e CD6_COD preenchidos.�
						//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
						Elseif cTabela == "CD6"
							aCols[Len(aCols)][1]	:=	aPermite[nG,7]
							aCols[Len(aCols)][2]	:=	aPermite[nG,8]

							For nY := 3 To Len(aHeader)
								aCols[Len(aCols)][nY] := CriaVar(aHeader[nY][2])
								aCols[Len(aCols)][Len(aHeader)+1] := .F.
							Next nY
						Endif

					EndIf
				Next nG
				aSort(aCols,,,{|x,y| x[1]<y[1]})
			 EndIf
		Endif

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		//矲echa as areas montadas para o filtro�
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		T521Close(cTabela,cArqInd,cAlias,lQuery)

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		//砅assa o conteudo do aHeader e do aCols de acordo com o complemento         �
		//矯arrega o aCols com os itens que devem gerar o complemento em notas fiscais�
		//硄ue ainda nao possuam o complemento cadastrado.                            �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�

			// processos referenciados
			aHProc	:=	aHeader
			aCProc	:=	aCols


          endif


Return .T.


/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砊521Filtro� Autor � Mary C. Hergert       � Data � 26/11/07 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Efetua o filtro/query de todos os complementos             潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros� ExpC1 = Nome da tabela                                     潮�
北�          � ExpC2 = Indice criado para codebase                        潮�
北�          � ExpC3 = Alias criado para top                              潮�
北�          � ExpL4 = Indicacao de top/codebase                          潮�
北�          � ExpC5 = Numero da nota fiscal                              潮�
北�          � ExpC6 = Serie da nota fiscal                               潮�
北�          � ExpC7 = Especie da nota fiscal                             潮�
北�          � ExpC8 = Cliente/fornecedor                                 潮�
北�          � ExpC9 = Loja do cliente/fornecedor                         潮�
北�          � ExpCA = Indicacao de entrada/saida                         潮�
北�          � ExpCB = Indica se a NF e de devol./beneficiamento          潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   � Nao ha.                                                    潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砋so       � Mata521                                                    潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function T521Filtro(cTabela,cArqInd,cChave,cAlias,lQuery,cDoc,cSerie,cEspecie,cClieFor,cLoja,cEntSai,cTpNF)

Local aArea		:= GetArea()
Local cWhere	:= ""
Local cCondicao := ""
Local cCampo	:= ""

Local lPossui	:= .F.

#IFDEF TOP
	Local cFrom		:= ""
	Local cOrder	:= ""
#ENDIF

cAlias := cTabela
dbSelectArea(cTabela)

If Left(cTabela,2) $ "CD"
	cCampo	:= SubStr(cTabela,1,3)
Else
	cCampo	:= SubStr(cTabela,2,3)
Endif

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//矼onta a chave e a condicao padrao para todos os filtros�
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
#IFDEF TOP
	cFrom		:= "%" + RetSqlName(cTabela) + " " + cTabela + "%"
	cOrder		:= "%" + SqlOrder((cTabela)->(IndexKey())) + "%"
	cWhere		:= "%" + cTabela + "." + cCampo + "_FILIAL" + " = '" + xFilial(cTabela) + "' AND "
#ELSE
	cChave		:= (cTabela)->(IndexKey())
	cCondicao 	:= cCampo + '_FILIAL == "' + xFilial(cTabela) + '" .AND. '
#ENDIF


//谀哪哪哪哪哪哪哪哪哪哪哪哪目
//矼onta a expressao para TOP�
//滥哪哪哪哪哪哪哪哪哪哪哪哪馁
cWhere		+= "CDG.CDG_TPMOV = '" + cEntSai + "' AND "
cWhere		+= "CDG.CDG_DOC = '" + cDoc + "' AND "
cWhere		+= "CDG.CDG_SERIE = '" + cSerie + "' AND "
cWhere		+= "CDG.CDG_CLIFOR = '" + cClieFor + "' AND "
cWhere		+= "CDG.CDG_LOJA = '" + cLoja  + "' AND "

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//矼onta a expressao para codebase�
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
cCondicao 	+= 'CDG_TPMOV == "' + cEntSai + '" .AND. '
cCondicao 	+= 'CDG_DOC == "' + cDoc + '" .AND. '
cCondicao 	+= 'CDG_SERIE == "' + cSerie + '" .AND. '
cCondicao 	+= 'CDG_CLIFOR == "' + cClieFor + '" .AND. '
cCondicao 	+= 'CDG_LOJA == "' + cLoja + '"'

If !Empty(cWhere) .Or. !Empty(cCondicao)

	#IFDEF TOP
	    If TcSrvType()<>"AS/400"

			lQuery 	:= .T.
			cAlias	:= GetNextAlias()

			cWhere	+= cTabela + ".D_E_L_E_T_= ' ' %"

			BeginSql Alias cAlias

				SELECT *
				FROM %Exp:cFrom%
				WHERE %Exp:cWhere%
				ORDER BY %Exp:cOrder%
			EndSql

			dbSelectArea(cAlias)

		Else
	#ENDIF
			lQuery	:= .F.
			cArqInd	:=	CriaTrab(Nil,.F.)
			IndRegua(cAlias,cArqInd,cChave,,cCondicao,STR0044) //"Selecionado registros"
			#IFNDEF TOP
				DbSetIndex(cArqInd+OrdBagExt())
			#ENDIF
			(cAlias)->(dbGotop())
	#IFDEF TOP
		Endif
	#ENDIF

Endif

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//砎erifica se possui o complemento ou ser� incluido.�
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
Do While !(cAlias)->(Eof())
	lPossui := .T.
	Exit
Enddo

(cAlias)->(dbGotop())

RestArea(aArea)

Return lPossui

/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    � T521Close� Autor � Mary C. Hergert       � Data � 26/11/07 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Fecha as areas abertas pela funcao de filtro               潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros� ExpC1 = Nome da tabela                                     潮�
北�          � ExpC2 = Indice criado para codebase                        潮�
北�          � ExpC3 = Alias criado para top                              潮�
北�          � ExpL4 = Indicacao de top/codebase                          潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   � Nao ha.                                                    潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砋so       � Mata521                                                    潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function T521Close(cTabela,cArqInd,cAlias,lQuery)

If !lQuery
	RetIndex(cTabela)
	dbClearFilter()
	Ferase(cArqInd+OrdBagExt())
Else
	dbSelectArea(cAlias)
	dbCloseArea()
Endif

Return .T.

/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砊521Valid � Autor � Mary C. Hergert       � Data � 26/11/07 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Valida as informacoes apresentadas                         潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros� ExpC5 = Numero da nota fiscal                              潮�
北�          � ExpC6 = Serie da nota fiscal                               潮�
北�          � ExpC7 = Especie da nota fiscal                             潮�
北�          � ExpC8 = Cliente/fornecedor                                 潮�
北�          � ExpC9 = Loja do cliente/fornecedor                         潮�
北�          � ExpCA = Indicacao de entrada/saida                         潮�
北�          � ExpCB = Indica se a NF e de devol./beneficiamento          潮�
北�          � ExpAC = Itens do complemento de medicamentos               潮�
北�          � ExpAD = Itens do complemento de armas de fogo              潮�
北�          � ExpAE = Itens do complemento de veiculos                   潮�
北�          � ExpAF = Itens do complemento de combustiveis               潮�
北�          � ExpAG = Itens do complemento de energia eletrica           潮�
北�          � ExpAH = Itens do complemento de gas canalizado             潮�
北�          � ExpAI = Itens do complemento de comunicacao/telecom.       潮�
北�          � ExpAJ = Complementos sugeridos pelo sistema                潮�
北�          � Exp1K = Array com as guias de recolhimento referenciadas   潮�
北�          � Exp1L = Array com os cupons fiscais referenciados          潮�
北�          � Exp1M = Array com os documentos referenciados              潮�
北�          � Exp1N = Array com os locais de coleta/entrega              潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   � Nao ha.                                                    潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砋so       � Mata521                                                    潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function T521Valid(cDoc,cSerie,cEspecie,cClieFor,cLoja,cEntSai,cTpNF,aGets,aObrigat,aMantem)

Local aCols		:= {}
Local aHeader	:= {}
Local aCabec	:= {"aHProc"}
Local aItem		:= {"aCProc"}

Local lGrava	:= .T.
Local lTabCDT	:= AliasIndic("CDT")

Local nX 		:= 0

For nX := 1 to Len(aCabec)

	//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪��
	//矼onta o aHeader e o aCols generico para efetuar a gravacao�
	//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪��
	aHeader	:= &(aCabec[nX])

	If ValType(aGets[nX]) == "O"
		aCols 	:= aGets[nX]:aCols
	Else
		aCols	:= {}
	Endif

	If ValType(aGets[nX]) == "O"

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		//矱fetua as validacoes de todos os complementos que devem ser      �
		//砱erados para a nota fiscal. Somente apos a validacao de todos os �
		//砪omplementos e que sera efetuada a gravacao.                     �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
		If T521Exist(aCols) .And. !T521Proc(aGets[nX],aObrigat,.T.)
			lGrava := .F.
		Endif
	Endif
Next


Return lGrava


/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砊521Fim   � Autor � Mary C. Hergert       � Data � 26/11/07 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Efetua as gravacoes nas tabelas                            潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros� ExpC5 = Numero da nota fiscal                              潮�
北�          � ExpC6 = Serie da nota fiscal                               潮�
北�          � ExpC7 = Especie da nota fiscal                             潮�
北�          � ExpC8 = Cliente/fornecedor                                 潮�
北�          � ExpC9 = Loja do cliente/fornecedor                         潮�
北�          � ExpCA = Indicacao de entrada/saida                         潮�
北�          � ExpCB = Indica se a NF e de devol./beneficiamento          潮�
北�          � Exp1M = Array com os documentos referenciados              潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   � Nao ha.                                                    潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砋so       � Mata521                                                    潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function T521Fim(cDoc,cSerie,cEspecie,cClieFor,cLoja,cEntSai,cTpNF,aMantem,aGets)

Local aArea		:= GetArea()
Local aCols		:= {}
Local aHeader	:= {}
Local aCabec	:= {"aHProc"}
Local aItem		:= {"aCProc"}
Local aDeleta	:= {}
Local aDel		:= {}
Local aPos		:= {0,0,0,0,0,0}

Local lExiste	:= .F.
Local lRet		:= .F.
Local lAtualiza	:= .T.
Local lComplem	:= .T.
Local lGrava	:= .T.
Local lPassou   := .F.

Local nX 		:= 0
Local nY		:= 0
Local nZ		:= 0
Local nI		:= 0
Local nPos		:= 0
Local nPos2		:= 0
Local nPos4		:= 0
Local nCount	:= 0

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//砈etando o indice das tabelas que serao atualizadas�
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
CDG->(dbSetOrder(1))

//ProcRegua(Len(aCompl))

Begin Transaction

	For nX := 1 to Len(aCabec)

	   //	IncProc(aCompl[nX][1])

		aDeleta := {}
		aDel	:= {}

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪��
		//矼onta o aHeader e o aCols generico para efetuar a gravacao�
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪��
		aHeader	:= &(aCabec[nX])

		If ValType(aGets[nX]) == "O"
			aCols 	:= aGets[nX]:aCols
		Else
			aCols	:= {}
		Endif

		If ValType(aGets[nX]) == "O"

			lRet 		:= .T.

			Do Case

				Case nX  == 1

					//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
					//砈omente efetua o processo de gravacao se existir informacoes no aCols�
					//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
					If T521Exist(aCols)

						nPos	:= aScan(aHeader,{|x| Alltrim(x[2])=="CDG_PROCES"})
						nPos2	:= aScan(aHeader,{|x| Alltrim(x[2])=="CDG_TPPROC"})

						//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
						//砎erifica se existem campos deletados e nao deletados de mesma chave�
						//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
						For nI := 1 to Len(aCols)
							If aCols[nI][Len(aHeader)+1]
								aAdd(aDel,{aCols[nI][nPos],aCols[nI][nPos2]})
							Endif
						Next

						For nI := 1 to Len(aCols)
							If !aCols[nI][Len(aHeader)+1]
								If aScan(aDel,{|x| x[1] == aCols[nI][nPos] .And. x[2] == aCols[nI][nPos2]}) > 0
									aAdd(aDeleta,{aCols[nI][nPos],aCols[nI][nPos2]})
								Endif
							Endif
						Next

						For nY := 1 to Len(aCols)

							lExiste 	:= CDG->(dbSeek(xFilial("CDG")+cEntSai+cDoc+cSerie+cClieFor+cLoja+aCols[nY][nPos]+aCols[nY][nPos2]))
							lAtualiza 	:= .T.

							//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
							//砎erifica se o item nao esta excluido no aCols�
							//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
							If !aCols[nY][Len(aHeader)+1]
								If lExiste
									RecLock("CDG",.F.)
								Else
									RecLock("CDG",.T.)
									CDG->CDG_FILIAL	:= xFilial("CDG")
									CDG->CDG_TPMOV	:= cEntSai
									CDG->CDG_DOC	:= cDoc
									CDG->CDG_SERIE	:= cSerie
									CDG->CDG_CLIFOR	:= cClieFor
									CDG->CDG_LOJA	:= cLoja
									CDG->CDG_CANC   := "S"
									lExiste := .T.
									lPassou := .T.
								Endif
								For nZ := 1 To Len(aHeader)
									CDG->(FieldPut(FieldPos(aHeader[nZ][2]),aCols[nY][nZ]))
									lPassou := .T.
								Next nY

								MsUnLock()
								FkCommit()
							Else
								// Exclusao
								If lExiste .And. aScan(aDeleta,{|x| x[1] == aCols[nY][nPos] .And. x[2] == aCols[nY][nPos2]}) == 0
									If nCount <= 0
						                lAtualiza := .F.
										RecLock("CDG",.F.)
										CDG->(dbDelete())
										MsUnLock()
										FkCommit()
										nCount ++
									Endif
								Endif
							Endif

							//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
							//矨tualiza o array com os documentos que permanecerao na tabela�
							//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
							If lAtualiza
								nPos4 := aScan(aMantem[2],{|x| x[1]+x[2] ==;
										 aCols[nY][nPos]+aCols[nY][nPos2]})
								If nPos4 > 0
									aMantem[2][nPos4][3] := .T.
								Endif
							Endif
						Next
						//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
						//矯omo no processo referenciado o numero e tipo de processo e a informacao complementar          �
						//砯azem parte da chave e e possivel altera-los, apos a atualizacao das informacoes complementares�
						//砮xclui-se as referencias que existiam na base mas nao existem mais devido a alteracao no acols.�
						//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
						For nI := 1 to Len(aMantem[2])
							If !aMantem[2][nI][3]
								If CDG->(dbSeek(xFilial("CDG")+cEntSai+cDoc+cSerie+cClieFor+cLoja+aMantem[2][nI][1]+aMantem[2][nI][2]))
									RecLock("CDG",.F.)
									CDG->(dbDelete())
									MsUnLock()
									FkCommit()
								Endif
							Endif
						Next
					Else
				   		Help("  ",1,"A926ProcObr")
    					lRet := .F.
					Endif
			EndCase
		Endif
	Next

End Transaction

If (!lExiste  .Or. (!lPassou .And. nCount > 0))
   	Help("  ",1,"A926ProcObr")
    lRet := .F.
EndIf


RestArea(aArea)

Return lRet

/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砊521Proc  � Autor � Mary C. Hergert       � Data � 26/11/07 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Efetua as validacoes dos processos referenciados           潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros� ExpO1 = Objeto que contem a get dados                      潮�
北砅arametros� ExpA2 = Array com os campos obrigatorios                   潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   � Nao ha.                                                    潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砋so       � Mata521                                                    潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function T521Proc(oGetProc,aObrigat,lFinal)

Local aCols		:= oGetProc:aCols
Local aPos		:= {}
Local aProcess	:= {}

Local lRet		:= .T.
Local lRepete	:= .F.
Local lObrigat	:= .F.

Local nX		:= 0
Local nI		:= 0
Local nAt		:= oGetProc:nAt

aAdd(aPos,aScan(aHProc,{|x| Alltrim(x[2])=="CDG_IFCOMP"}))
aAdd(aPos,aScan(aHProc,{|x| Alltrim(x[2])=="CDG_TPPROC"}))
aAdd(aPos,aScan(aHProc,{|x| Alltrim(x[2])=="CDG_PROCES"}))

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//砎erifica se algum campo obrigatorio nao foi digitado�
//�(apenas da linha que esta sendo manipulada - aT)    �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If !lFinal .And. !(aCols[nAt][Len(aHProc)+1])
	If T521Obrig(aObrigat,aHProc,aCols[nAt],10)
		lObrigat := .T.
	Endif
Endif

For nX := 1 to Len(aCols)

	If !(aCols[nX][Len(aHProc)+1])

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//砎erifica se algum campo obrigatorio nao foi digitado em todos os itens�
		//�(somente quando for validacao do ok da rotina)                        �
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If lFinal
			lObrigat := T521Obrig(aObrigat,aHProc,aCols[nX],10)
		Endif

		//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
		//砎erifica se o processo + informacao complementar nao foi digitado em outra linha�
		//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
		If aScan(aProcess,{|x| x[1] == aCols[nX][aPos[1]] .And. x[2] == aCols[nX][aPos[2]] .And. x[3] == aCols[nX][aPos[3]]}) > 0
			lRepete := .T.
		Endif
		aAdd(aProcess,{aCols[nX][aPos[1]],aCols[nX][aPos[2]],aCols[nX][aPos[3]]})

	Endif
Next

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//矷nforma se o processo + informacao complementar nao foi digitado em outra linha�
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
If lRepete
	Help("  ",1,"A926Proc")
	lRet := .F.
Endif

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//矷nforma se existe algum campo obrigatorio que nao foi preenchido�
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
If lObrigat
	Help("  ",1,"A926ProcObr")
	lRet := .F.
Endif

Return lRet

/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砊521Exist � Autor � Mary C. Hergert       � Data � 26/11/07 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Verifica se o aCols foi preenchido ou se apenas foi criado 潮�
北�          � em branco                                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros� ExpA1 = Array com os campos do aCols                       潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   � Indicacao da existencia de campos no aCols                 潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砋so       � Mata521                                                    潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function T521Exist(aCols)

Local lExiste	:= .F.

Local nX		:= 0
Local nY		:= 0

For nX := 1 to Len(aCols)

	If lExiste
		Exit
	Endif

	For nY := 1 to Len(aCols[nX])

		If ValType(aCols[nX][nY]) == "C"
			If !Empty(aCols[nX][nY])
				lExiste := .T.
				Exit
			Endif
		Endif

		If ValType(aCols[nX][nY]) == "N"
			If aCols[nX][nY] <> 0
				lExiste := .T.
				Exit
			Endif
		Endif

	Next

Next

Return lExiste

/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    � T521NF   � Autor � Mary C. Hergert       � Data � 26/11/07 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Cria o cabecalho dos complementos (fixo para todos os mode-潮�
北�          � los com os dados da nota fiscal a ser complementada)       潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros� ExpO1 = Painel onde os componentes serao inseridos         潮�
北�          � ExpO2 = Font a ser utilizada                               潮�
北�          � ExpN3 = Altura padrao dos objetos Say                      潮�
北�          � ExpN4 = Tamanho padrao dos objetos Say                     潮�
北�          � ExpN5 = Altura padrao dos objetos Get                      潮�
北�          � ExpC6 = Numero da nota fiscal                              潮�
北�          � ExpC7 = Serie da nota fiscal                               潮�
北�          � ExpC8 = Especie da nota fiscal                             潮�
北�          � ExpC9 = Codigo do cliente/fornecedor                       潮�
北�          � ExpCA = Loja do cliente/fornecedor                         潮�
北�          � ExpCB = Movimento de Entrada ou Saida                      潮�
北�          � ExpCC = Indica se a NF e de devol./beneficiamento          潮�
北�          � ExpAD = Coordenadas dos paineis principais                 潮�
北�          � ExpAE = Painel onde serao montados os dados da NF          潮�
北�          � ExpOF = Dialog principal                                   潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   � Nao ha.                                                    潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砋so       � Mata521                                                    潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function T521NF(oFont,nAltSay,nTamSay,nAltGet,cDoc,cSerie,cEspecie,cClieFor,cLoja,cEntSai,cTpNF,oDlg)

Local aColuna		:= {15,65,145,185,250,298}
Local bSay			:= {|| Nil}
Local bVar			:= {|| Nil}
Local bWhen			:= {|| Nil}

Local cOpcao		:= ""
Local cPesqF3		:= ""

Local nLinSay		:= 19
Local nLinGet		:= 17
Local nTamGet		:= 55
Local nTamGet2		:= 30

Local oGrpNF
Local oPanel

Local   lDatRecb	:= .T.

oPanel	:= TPanel():New(15,5,'',oDlg,oDlg:oFont,.T.,.T.,,,360,75,.T.,.T.)
oGrpNF := TGroup():New(5,5,70,355,STR0042,oPanel,,,.T.,.T.) //"Informa珲es do documento fiscal"

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//砊ipo de documento - entrada/saida�
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
If (cEntSai == "S")
     cOpcao = STR0038 //"Sa韉a"
Else
	 cOpcao = STR0037 //"Entrada"
EndIf

bSay	:= &('{|| "' + STR0036 + '"}') // "Tipo"
TSay():New(nLinSay,aColuna[1],bSay,oGrpNF,,oFont,.F.,.F.,.F.,.T.,,,nTamSay,nAltSay,.F.,.F.,.F.,.F.,.F.)



bVar     := &("{ | u | If( PCount() == 0, cOpcao,cOpcao := u)}")
TGet():New(nLinGet,aColuna[2],bVar,oGrpNF,nTamGet,nAltGet,"@!",,,,,,,.T.,,, bWhen,,,,.T.,,,cDoc)


//谀哪哪哪哪哪哪哪哪哪哪�
//矰ata de Recebimento  �
//滥哪哪哪哪哪哪哪哪哪哪�

If lDatRecb
   If CDT->(FieldPos("CDT_DTAREC")) > 0
		If CDT->(dbSeek(xFilial("CDT")+cEntSai+cDoc+cSerie+cClieFor+cLoja))
			dDatReceb	:=	CDT->CDT_DTAREC
		EndIf

	  	bSay	:= &('{|| "' + "Data Recebimento" + '"}')
		TSay():New(nLinSay,aColuna[5],bSay,oGrpNF,,oFont,.F.,.F.,.F.,.T.,,,nTamSay,nAltSay,.F.,.F.,.F.,.F.,.F.)

		bVar     := &("{|u| If(PCount()== 0,dDatReceb,dDatReceb :=u)}")
		TGet():New(nLinGet,aColuna[6],bVar,oGrpNF,nTamGet,nAltGet,PesqPict("CDT","CDT_DTAREC"),,,,,,,.T.,,,,,,,,,,)

		nLinSay := nLinSay + 18
		nLinGet := nLinGet + 18
	Endif
Endif
lDatRecb := .F.

//谀哪哪哪哪哪哪哪哪哪哪�
//砃umero da nota fiscal�
//滥哪哪哪哪哪哪哪哪哪哪�
bSay	:= &('{|| "' + STR0043 + '"}') // "N鷐ero"
TSay():New(nLinSay,aColuna[1],bSay,oGrpNF,,oFont,.F.,.F.,.F.,.T.,,,nTamSay,nAltSay,.F.,.F.,.F.,.F.,.F.)

bVar     := &("{ | u | If( PCount() == 0, cDoc,cDoc := u)}")
TGet():New(nLinGet,aColuna[2],bVar,oGrpNF,nTamGet,nAltGet,"@!",,,,,,,.T.,,, bWhen,,,,.T.,,,cDoc)

//谀哪哪哪哪哪哪哪哪哪目
//砈erie da nota fiscal�
//滥哪哪哪哪哪哪哪哪哪馁
bSay	:= &('{|| "' + STR0035 + '"}') // "Serie"
TSay():New(nLinSay,aColuna[3],bSay,oGrpNF,,oFont,.F.,.F.,.F.,.T.,,,nTamSay,nAltSay,.F.,.F.,.F.,.F.,.F.)

bVar     := &("{ | u | If( PCount() == 0, cSerie,cSerie := u)}")
TGet():New(nLinGet,aColuna[4],bVar,oGrpNF,nTamGet2,nAltGet,"@!",,,,,,,.T.,,, bWhen,,,,.T.,,,cSerie)

//谀哪哪哪哪哪哪哪哪哪哪目
//矱specie da nota fiscal�
//滥哪哪哪哪哪哪哪哪哪哪馁
bSay	:= &('{|| "' + STR0039 + '"}') // "Esp閏ie"
TSay():New(nLinSay,aColuna[5],bSay,oGrpNF,,oFont,.F.,.F.,.F.,.T.,,,nTamSay,nAltSay,.F.,.F.,.F.,.F.,.F.)

bVar     := &("{ | u | If( PCount() == 0, cEspecie,cEspecie := u)}")
TGet():New(nLinGet,aColuna[6],bVar,oGrpNF,nTamGet2,nAltGet,"@!",,,,,,,.T.,,, bWhen,,,,.T.,,"42")

nLinSay := nLinSay + 18
nLinGet := nLinGet + 18

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//矯liente/Fornecedor da nota fiscal�
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
bSay	:= &('{|| "' + STR0040 + '"}') // "Cliente/fornecedor"
TSay():New(nLinSay,aColuna[1],bSay,oGrpNF,,oFont,.F.,.F.,.F.,.T.,,,nTamSay,nAltSay,.F.,.F.,.F.,.F.,.F.)

bVar     := &("{ | u | If( PCount() == 0, cClieFor,cClieFor := u)}")
TGet():New(nLinGet,aColuna[2],bVar,oGrpNF,nTamGet,nAltGet,"@!",,,,,,,.T.,,, bWhen,,,,.T.,,cPesqF3)

//谀哪哪哪哪哪哪哪哪哪目
//矻oja da nota fiscal �
//滥哪哪哪哪哪哪哪哪哪馁
bSay	:= &('{|| "' + STR0041 + '"}') // "Loja"
TSay():New(nLinSay,aColuna[3],bSay,oGrpNF,,oFont,.F.,.F.,.F.,.T.,,,nTamSay,nAltSay,.F.,.F.,.F.,.F.,.F.)

bVar     := &("{ | u | If( PCount() == 0, cLoja,cLoja := u)}")
TGet():New(nLinGet,aColuna[4],bVar,oGrpNF,nTamGet2,nAltGet,"@!",,,,,,,.T.,,, bWhen,,,,.T.,,)


Return .T.

/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砊521Obrig � Autor � Mary C. Hergert       � Data � 26/11/07 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Verifica se existem campos obrigatorios nao preenchidos    潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros� ExpA1 = Array com os campos obrigatorios                   潮�
北�          � ExpA2 = Array com os campos da get dados                   潮�
北�          � ExpA3 = Array com o conteudo do campo                      潮�
北�          � ExpN4 = Numero que indica o complemento                    潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砇etorno   � .T. para existencia de campos obrigatorios em branco       潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砋so       � Mata521                                                    潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function T521Obrig(aObrigat,aHeader,aCols,nComp)
Local lRet	:= .F.
Local nX	:= 0
Local nPos	:= 0
Local xConteudo
Local lObrigCmp	:=	.F.

For nX := 1 to Len(aObrigat[nComp])
	lObrigCmp	:=	.F.
	nPos := aScan(aHeader,{|x| x[2] == aObrigat[nComp][nX][1]})

	If nPos > 0
		xConteudo	:= aCols[nPos]

		If aObrigat[nComp][nX][2] == "C"
			If Empty(xConteudo)
				lRet := .T.
				lObrigCmp	:=	.T.
			Endif
		ElseIf aObrigat[nComp][nX][2] == "N"
			If xConteudo == 0
				lRet := .T.
				lObrigCmp	:=	.T.
			Endif
		Endif

		If aObrigat[nComp][nX][1] == "CDD_SERREF" .and. lRet
			aCols[2] := "   "
			lRet := .F.
		EndIf

	Endif

Next

Return lRet


//-------------------------------------------------------------------
/*/{Protheus.doc} A521VERPRS
Verifica玢o e marca玢o do registro no MarkBrow e Vincula NFs
@sample   A521VERPRS(cId, cMarca)
@param    cId     - Indica o cId da Acao.
@param    cMarca  - valor de marcacao da markbrow().
@return   lRet (Boolean) - sempre verdadeiro.

@author   Eduardo Vicente
@since    27.02.2013
@version  P11.5
/*/
//-------------------------------------------------------------------

Static Function A521VERPRS(cId,cMarca)

Local aArea		:= GetArea()       //Salva a area atual
Local oMark		:= GetMarkBrow()   //Objeto do Browser Markbrow()
Local cInfMarc	:= If(IsMark("F2_OK", cMarca)," ",cMarca)   //Se ja esta marcado ira desmarcar caso contrario ira marcar.
Local cChave	:= ""              //Chave da nota fiscal vinculada

If cId == "1"
	Reclock("SF2",.F.)
	SF2->F2_OK := cInfMarc
	SF2->( MsUnlock() )

	If  (SF2->(FieldPos("F2_ECVINC1")) > 0) .And. (SF2->(FieldPos("F2_ECVINC2")) > 0)
	    cChave := xFilial("SF2")+PadR(SF2->F2_ECVINC1,Len(SF2->F2_DOC))+PadR(SF2->F2_ECVINC2,Len(SF2->F2_SERIE))

		If  SF2->( dbSeek(cChave) )
			While !( SF2->(Eof()) ) .And. (SF2->F2_FILIAL+SF2->F2_DOC+SF2->F2_SERIE == cChave)
				Reclock("SF2",.F.)
				SF2->F2_OK := cInfMarc
				SF2->( MsUnlock() )

				SF2->( dbSkip() )
			End
		EndIf
	EndIf
EndIf

RestArea(aArea)
oMark:Refresh()
Eval(bFiltraBrw)

Return .T.

//-----------------------------------------------------
/*/Verifica se integra玢o com SIGAGFE para tamb閙 eliminar as Notas Fiscais
@author Felipe Machado de Oliveira
@version P11
@since 18/04/2013
/*/
//------------------------------------------------------
Static Function MATA521IPG()
	Local lRet := .T.
	Local lIntGFE := SuperGetMv("MV_INTGFE",.F.,.F.)
	Local cIntGFE2 := SuperGetMv("MV_INTGFE2",.F.,"2")
	Local cIntNFS := SuperGetMv("MV_GFEI11",.F.,"2")

	//Integra玢o Protheus com SIGAGFE
	If lIntGFE == .T. .And. cIntGFE2 $ "1" .And. cIntNFS == "1"
		If !MATA521ENF()
			lRet := .F.
		EndIf
	EndIf

Return lRet
//-----------------------------------------------------
/*/	Elimina a Nota Fiscal selecionadas no browse
@author Felipe Machado de Oliveira
@version P11
@since 18/04/2013
/*/
//------------------------------------------------------
Static Function MATA521ENF()
Local aAreaGW1 := GetArea("GW1")
Local lRet := .T.
Local oModelGW1 := FWLoadModel("GFEA044")
Local cF2_CDTPDC := ""
Local cEmisDc := ""
Local aArray := {}

Aadd(aArray, AllTrim(SF2->F2_DOC)     + Space( TamSx3("GW1_CDTPDC")[1] -(Len( AllTrim(SF2->F2_DOC))) ) )
Aadd(aArray, AllTrim(SF2->F2_SERIE)   + Space( TamSx3("GW1_SERDC")[1]  -(Len( AllTrim(SF2->F2_SERIE))) ) )
Aadd(aArray, AllTrim(SF2->F2_CLIENTE) + Space( TamSx3("F2_CLIENTE")[1] -(Len( AllTrim(SF2->F2_CLIENTE))) ) )
Aadd(aArray, AllTrim(SF2->F2_LOJA)    + Space( TamSx3("F2_LOJA")[1]    -(Len( AllTrim(SF2->F2_LOJA))) ) )
Aadd(aArray, AllTrim(SF2->F2_TIPO)    + Space( TamSx3("F2_TIPO")[1]    -(Len( AllTrim(SF2->F2_TIPO))) ) )

cF2_CDTPDC := Posicione("SX5",1,xFilial("SX5")+"MQ"+AllTrim(aArray[5])+"S","X5_DESCRI")

If Empty(cF2_CDTPDC)
	cF2_CDTPDC := Posicione("SX5",1,xFilial("SX5")+"MQ"+AllTrim(aArray[5]),"X5_DESCRI")
EndIf

cF2_CDTPDC := AllTrim(cF2_CDTPDC) + Space( TamSx3("GW1_CDTPDC")[1] -(Len( AllTrim(cF2_CDTPDC))) )
cEmisDc := OMSM011COD(,,,.T.,xFilial("SF2"))

dbSelectArea("GW1")
GW1->( dbSetOrder(1) )
GW1->( dbSeek( xFilial("GW1")+cF2_CDTPDC+cEmisDc+aArray[2]+aArray[1] ) )
If !GW1->( Eof() ) .And. GW1->GW1_FILIAL == xFilial("GW1");
					 .And. AllTrim(GW1->GW1_CDTPDC) == AllTrim(cF2_CDTPDC);
					 .And. AllTrim(GW1->GW1_EMISDC) == AllTrim(cEmisDc);
					 .And. AllTrim(GW1->GW1_SERDC) == AllTrim(aArray[2]);
					 .And. AllTrim(GW1->GW1_NRDC) == AllTrim(aArray[1])

	oModelGW1:SetOperation( MODEL_OPERATION_DELETE )
	oModelGW1:Activate()

	If oModelGW1:VldData()
		oModelGW1:CommitData()
	Else
		Help( ,, STR0007,,"Inconsist阯cia com o Frete Embarcador (SIGAGFE): "+CRLF+CRLF+oModelGW1:GetErrorMessage()[6], 1, 0,,,,,.T. ) //"Aten玢o"##"Inconsist阯cia com o Frete Embarcador (SIGAGFE): "##
		lRet := .F.
	EndIf

	oModelGW1:Deactivate()

EndIf

If SuperGetMv("MV_FATGFE",.F.,"2") == "2"
	//Exclui a nota da GW0
	OMSM011GW0()
EndIf

RestArea(aAreaGW1)

Return lRet
