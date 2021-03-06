#INCLUDE "rwmake.ch"
#INCLUDE "Topconn.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �EXPORT05 � Autor �  Saulo Muniz        � Data �  14/11/06   ���
�������������������������������������������������������������������������͹��
���Descricao � Arquivo de exporta��o de dados para Gefco Argentina        ���
���          � Vers�o 1.01  - Lancamento Manual de Credito                ���
�������������������������������������������������������������������������͹��
���Uso       � Gefco                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function EXPORT05()

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
Local oDlg,oGet
Local cFile := Space(200)

Private oGeraTxt

dbSelectArea("CT2")
dbSetOrder(1)

//���������������������������������������������������������������������Ŀ
//� Montagem da tela de processamento.                                  �
//�����������������������������������������������������������������������

@ 200,1 TO 380,380 DIALOG oGeraTxt TITLE OemToAnsi("Gera��o de Arquivo Microsiga -> Gefco Argentina - Vers�o 1.01")
@ 002,10 TO 080,190
@ 10,018 Say " Este programa ira exportar os dados do sistema Microsiga de    "
@ 18,018 Say " acordo com os par�metros definidos pelo usuario, retornando as "
@ 26,018 Say " informa��es para o sistema Sisges.                             "

@ 055,088 BMPBUTTON TYPE 01 ACTION OkGeraTxt()
@ 055,119 BMPBUTTON TYPE 02 ACTION Close(oGeraTxt)
@ 055,150 BMPBUTTON TYPE 05 ACTION Pergunte("GEFM50",.T.) 

Activate Dialog oGeraTxt Centered

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    � OKGERATXT� Autor � AP7 IDE            � Data �  06/11/05   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao chamada pelo botao OK na tela inicial de processamen���
���          � to. Executa a geracao do arquivo texto.                    ���
���          � Arquivo Manual Cr�dito.                                    ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function OkGeraTxt

//���������������������������������������������������������������������Ŀ
//� Cria o arquivo texto                                                �
//�����������������������������������������������������������������������

Private cArqTxt  := "\\geatj1appl1\Protheus8\Protheus_Data\Exportar\ManualCrd.txt"
Private nHdl     := fCreate(cArqTxt)
Private cEOL     := "CHR(13)+CHR(10)"
Private cPathori := "\\geatj1appl1\Protheus8\Protheus_Data\Importar\FaturasAdhoc\Receber\"
Private cSinal   := "-"

If Empty(cEOL)
    cEOL := CHR(13)+CHR(10)
Else
    cEOL := Trim(cEOL)
    cEOL := &cEOL
Endif

If nHdl == -1
    MsgAlert("O arquivo de nome "+cArqTxt+" nao pode ser executado! Verifique os parametros.","Atencao!")
    Return
Endif

Pergunte("GEFM50",.T.)

//����������������������������Ŀ
//� Cabec. do arquivo          �
//������������������������������
xIndice  := "00"
DtPar01  := Gravadata(MV_PAR01,.F.,8) 
DtPar02  := Gravadata(MV_PAR02,.F.,8) 

_FHeader := xIndice + DtPar01 + DtPar02 +  Space(896) + cEOL

fWrite(nHdl,_FHeader,Len(_FHeader))

//���������������������������������������������������������������������Ŀ
//� Inicializa a regua de processamento                                 �
//�����������������������������������������������������������������������

Processa({|| RunCont() },"Processando...")

	If File(cPathori)
       Resposta := MSGBOX("Arquivo texto j� existe, Deseja atualizar o arquivo !","Informa�ao","YESNO")
       If Resposta
		  Ferase(cPathori)             
       Else	      
	      Return
	   Endif	   
	Endif

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    � RUNCONT  � Autor � AP5 IDE            � Data �  06/11/05   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunCont()

Local nTamLin, cLin, cCpo, nReg
Private cNomeAtv


     cTipoReg := Space(2)
     cCliCob  := Space(8)
     cCnpjCob := Space(14)
     cNomCob  := Space(40)
     cCliDest := Space(8)
     cCnpjDest:= Space(14)
     cNomDest := Space(40)
     cFornece := Space(8)
     cNomFor  := Space(40)
     cCnpjFor := Space(14)
     cCodCusto:= Space(10)
     cNomCusto:= Space(40)
     cCodDiv  := Space(1)
     cNomDiv  := Space(20)
     cCodUO   := Space(2)
     cNomUO   := Space(40)
     cCodFil  := Space(3)
     cNomFil  := Space(40)
     cCodAtv  := Space(3)
     cNomAtv  := Space(60)
     cCodPolo := Space(1)
     cNomPolo := Space(40)
     cConta   := Space(20)
     cNomConta:= Space(40)
     cContaGer:= Space(20)
     cNomGeren:= Space(20)
     cTipoDoc := Space(3)
     cCodFatura := Space(6)
     cNumBoleto := Space(12)
     cNumDoc  := Space(9)
     cDtFatura:= Space(8) 
     cDtBoleto:= Space(8)
     cDtDoc   := Space(8)
     cDtContab:= Space(8)
     nValor   := 0
     cImposto := Space(20)
     cCfop    := Space(5)
     cNomCfop := Space(55)
     cRefgefco:= Space(20)
     cCustoPSA:= Space(20)
     cOIPSA   := Space(20)
     cTipoDesp:= Space(3)
     cNomeAtv := Space(60)


nReg := 0

V_CT1     := RETSQLNAME("CT1")
V_CT2     := RETSQLNAME("CT2")
V_CTT     := RETSQLNAME("CTT")

_cFilial  := ""
nValorFil := 0
nTotalG   := 0
_cFilAnt  := ""   
cTipoReg  := "  "

cQuery =  "SELECT * "
cQuery += "FROM "+V_CT1+" AS CT1 ,"+V_CT2+" AS CT2 ,"+V_CTT+" AS CTT "
cQuery += "WHERE (CT2.CT2_DC = '1' OR CT2.CT2_DC = '3') AND "
cQuery += "CT2.CT2_DATA >=" + "'"+DTOS(Mv_Par01)+"'" +  " AND "
cQuery += "CT2.CT2_DATA <=" + "'"+DTOS(Mv_Par02)+"'" +  " AND "
cQuery += "CT2.CT2_CCC = CTT.CTT_CUSTO AND "	
cQuery += "CT2.CT2_CREDIT = CT1.CT1_CONTA AND "	
cQuery += "CT2_ROTINA = 'CTBA102' AND "	
cQuery += "CT2.D_E_L_E_T_ <> '*' " 
cQuery += "ORDER BY CT2.CT2_CREDIT "

TcQuery cQuery Alias "COMCTB" NEW

DbSelectArea("COMCTB")
DbGoTop()         

ProcRegua(RecCount())

_cFilial := COMCTB->CT2_FILIAL
    
While !Eof() 
    
    IncProc()

    nTamLin  := 913
    cLin     := Space(nTamLin)+cEOL 
    cTipoReg := "01"                        
    cCliCob  := Space(8)
    cCnpjCob := Space(14)
    cNomCob  := Space(40)    
	cSerie   := "1" 
    cFornece := Space(8)
    cNomFor  := Space(40)
    cCnpjFor := Space(14)    
    
    cCodCusto := COMCTB->CT2_CCC + Space(10 - Len(COMCTB->CT2_CCC))
    cNomCusto := COMCTB->CTT_DESC01 + Space(40 - Len(COMCTB->CTT_DESC01))
   
    cCodDiv := Substr(COMCTB->CT2_CCC,1,1)
    cNomDiv := GEFDIVISAO(cCodDiv) + Space(20 - Len(GEFDIVISAO(cCodDiv)))

    cCodUO  := Substr(COMCTB->CT2_CCC,2,2)
    cNomUO  := UO(cCodUO) + Space(40 - Len(UO(cCodUO)))

    cCodFil := Substr(COMCTB->CT2_CCC,4,3)
    cNomFil := GEFFILIAL(cCodFil) + Space(40 - Len(GEFFILIAL(cCodFil)))

    cCodAtv := Substr(COMCTB->CT2_CCC,7,3)
    cNomAtv := Atividade(cCodAtv,cCodUO) + Space(60 - Len(Atividade(cCodAtv,cCodUO)))

    cCodPolo:= Substr(COMCTB->CT2_CCC,10,1)
    cNomPolo:= Polo(cCodPolo) + Space(40 - Len(Polo(cCodPolo)))

    cConta  := COMCTB->CT1_CONTA  + Space(20 - Len(COMCTB->CT1_CONTA ))
	
	dbSelectArea("CT1")
	dbSetOrder(1)
	dbGotop()
	If MsSeek(xFilial()+cConta)
       cNomConta := CT1->CT1_DESC01 + Space(20 - Len(CT1->CT1_DESC01))
    Else
       cNomConta := Space(40)        
    Endif
                                                  
    
	If SubStr(cConta,1,1) == "7" .or. SubStr(cConta,1,1) == "8"
		//Plano Gerencial do Historique

		_cQry := ""	
		_cQry := "SELECT * FROM " + RetSqlName("CTS") + " CTS "
		_cQry += "	WHERE RTRIM(CTS.CTS_CODPLA) = '001' " 
		_cQry += "	  AND RTRIM(CTS.CTS_CT1INI) = '" + Alltrim(cConta) + "' "
		_cQry += "	  AND CTS.CTS_FILIAL =  '" + xFilial("CTS") + "' "
		_cQry += "	  AND CTS.D_E_L_E_T_ <> '*' "                  
		_cQry += "	  ORDER BY CTS_CODPLA, CTS_CONTAG , CTS_CT1INI "                  	
	
	ElseIf SubStr(cConta,1,1) == "1" .or. SubStr(cConta,1,1) == "2"	
		//Plano Gerencial do FINRM 
		//013 1 ou 2
		_cQry := ""	
		_cQry := "SELECT * FROM " + RetSqlName("CTS") + " CTS "
		_cQry += "	WHERE RTRIM(CTS.CTS_CODPLA) = '013' " 
		_cQry += "	  AND '" + Alltrim(cConta) + "' >= RTRIM(CTS.CTS_CT1INI)"
		_cQry += "	  AND '" + Alltrim(cConta) + "' <= RTRIM(CTS.CTS_CT1FIM) "		
		_cQry += "	  AND CTS.CTS_FILIAL =  '" + xFilial("CTS") + "' "
		_cQry += "	  AND CTS.D_E_L_E_T_ <> '*' "                  
		_cQry += "	  ORDER BY CTS_CODPLA, CTS_CONTAG , CTS_CT1INI "  
		
	EndIF                	

	If Select("TCTS") > 0
	   dbSelectArea("TCTS")
	   dbCloseArea()
	EndIf
	
	TCQUERY _cQry ALIAS "TCTS" NEW
	dbSelectArea("TCTS") 
	dbGoTop()	    	

    cContaGer := TCTS->CTS_CONTAG + Space(20 - Len(TCTS->CTS_CONTAG)) 
    cNomGeren := TCTS->CTS_DESCCG + Space(20 - Len(TCTS->CTS_DESCCG)) 
 
    DbSelectArea("COMCTB")

    cTipoDoc   := Space(3)
    cCodFatura := Space(6) 
    cNumBoleto := Space(12)
    cNumDoc    := Space(9)
    cDtFatura  := Space(8)
    cDtBoleto  := Space(8)
    cDtDoc     := IIF(EMPTY(COMCTB->CT2_DATA),Space(8),COMCTB->CT2_DATA)
    cDtContab  := IIF(EMPTY(COMCTB->CT2_DATA),Space(8),COMCTB->CT2_DATA)     
    nValor     := STRZERO(COMCTB->CT2_VALOR * 100,19,0)    
    cImposto   := Space(20)    
    cRefgefco  := Space(20)
    cCustoPSA  := Space(20)
    cOIPSA     := Space(20)
    cTipoDesp  := Space(3)
     
    cLote     := COMCTB->CT2_LOTE + COMCTB->CT2_SBLOTE + COMCTB->CT2_DOC + COMCTB->CT2_LINHA
    cDescLote := Alltrim(COMCTB->CT2_HIST) + Space(120 - Len(Alltrim(COMCTB->CT2_HIST))) 
       
    lManual   := "S"
    FlagProv  := "N"            

	If AllTrim(cConta) $ ("711101",;
				 "711102",; 
				 "711103",; 
				 "711105",; 
			 	 "711106",; 
				 "711107",; 
				 "711108",; 
				 "711202",; 
				 "711203",; 
				 "711204") 
		
		/*******Compras    ********
		711101 FRETE RODOVI�RIO
		711102 FRETE FERROVI�RIO
		711103 FRETE FLUVIAL
		711105 FRETE MAR�TIMO NVOCC
		711106 FRETE A�REO
		711107 ARMAZENAGEM
		711108 PED�GIO SOBRE FRETES
		711202 DESPACHANTES/ADUANA
		711203 OUTROS CUSTOS NVOCC
		711204 CMV DE EMBALAGENS
		******************************/
	    TipoCnt   := "C" //Compras
		       
	Else	
		_cQry := ""	
		_cQry := "SELECT * FROM " + RetSqlName("CTS") + " CTS "
		_cQry += "	WHERE RTRIM(CTS.CTS_CODPLA) = '001' " 
		_cQry += "	  AND RTRIM(CTS.CTS_CT1INI) >= '" + Alltrim(cConta) + "' "
		_cQry += "	  AND RTRIM(CTS.CTS_CT1FIM) <= '" + Alltrim(cConta) + "' "		
		_cQry += "	  AND CTS.CTS_FILIAL =  '" + xFilial("CTS") + "' "
		_cQry += "	  AND CTS.D_E_L_E_T_ <> '*' "                  
		_cQry += "	  ORDER BY CTS_CODPLA, CTS_CONTAG , CTS_CT1INI "  
		
		If Select("TCTS1") > 0
		   dbSelectArea("TCTS1")
		   dbCloseArea()
		EndIf
		
		TCQUERY _cQry ALIAS "TCTS1" NEW
		dbSelectArea("TCTS1") 
		dbGoTop()	    	
	
		If !Eof()
		    TipoCnt   := "V" //Vendas		
		Else
		    TipoCnt   := "G" //Gastos			
		EndIF
	EndIf    
    
    cLin := cTipoReg + cCliCob + cCnpjCob + cNomCob + cCliDest + cCnpjDest + cNomDest + cFornece + cNomFor + cCnpjFor + cCodCusto + cNomCusto + cCodDiv + cNomDiv + cCodUO + cNomUO + cCodFil + cNomFil + cCodAtv + cNomAtv + cCodPolo + cNomPolo + cConta 
    cLin := cLin + cNomConta + cContaGer + cNomGeren + cTipoDoc + cCodFatura + cNumBoleto + cNumDoc + cDtFatura  + cDtBoleto + cDtDoc + cDtContab + nValor + cImposto + cCfop + cNomCfop + cRefgefco + cCustoPSA + cOIPSA + cTipoDesp 
    cLin := cLin + cLote + cDescLote + lManual + FlagProv + TipoCnt + cSinal + cEOL
    nReg++


    //���������������������������������������������������������������������Ŀ
    //� Gravacao no arquivo texto. Testa por erros durante a gravacao da    �
    //� linha montada.                                                      �
    //�����������������������������������������������������������������������
    If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
        If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
            Exit
        Endif
    Endif

	DbSelectArea("COMCTB")
    dbSkip()

EndDo

If nReg == 0   
   Ferase(cPathori)                   
Endif


//����������������������������Ŀ
//� Rodape do arquivo          �
//������������������������������
tIndice  := "ZZZ"
nQtdReg  := Strzero(nReg,10)
tBrancos := Space(901)

_FTrailler := tIndice + nQtdReg + tBrancos + cEOL
fWrite(nHdl,_FTrailler,Len(_FTrailler))

//���������������������������������������������������������������������Ŀ
//� O arquivo texto deve ser fechado, bem como o dialogo criado na fun- �
//� cao anterior.                                                       �
//�����������������������������������������������������������������������
fClose(nHdl)
Close(oGeraTxt)

Return()


STATIC FUNCTION GEFDIVISAO(cCodDiv)

  Do Case
      Case cCodDiv == "1"
           cNomDiv := "Automotive"
      Case cCodDiv == "2"
           cNomDiv := "Network"
      Case cCodDiv == "3"
           cNomDiv := "Supply"
      Case cCodDiv == "4"
           cNomDiv := "Siege"
      Case cCodDiv == "5"
           cNomDiv := "Informatique"
      Case cCodDiv == "6"
           cNomDiv := "Finance"
       Otherwise   
           cNomDiv := Space(20)      
  EndCase

RETURN(cNomDiv)



STATIC FUNCTION GEFFILIAL(cCodDiv)

_xFilCtb := cCodDiv

   Do Case
      Case _xFilCtb == "001"
           xFilRet := "MATRIZ"
      Case _xFilCtb == "002"
           xFilRet := "BENEDITINOS"
      Case _xFilCtb == "004"
           xFilRet :="PORTO REAL"
      Case _xFilCtb == "005"
           xFilRet :="BARUERI"
      Case _xFilCtb == "006"
           xFilRet :="PAVUNA"
      Case _xFilCtb == "007"
           xFilRet :="VILA GUILHERME"
      Case _xFilCtb == "008"
           xFilRet :="SAO JOSE DOS PINHAIS"
      Case _xFilCtb == "009"
           xFilRet :="CONTAGEM"
      Case _xFilCtb == "010"
           xFilRet :="CAMPINAS"
      Case _xFilCtb == "011"
           xFilRet :="SEPETIBA"
      Case _xFilCtb == "012"
           xFilRet :="VILA OLIMPIA"
      Case _xFilCtb == "013"
           xFilRet :="SANTOS"
      Case _xFilCtb == "014"
           xFilRet :="RIO BRANCO"
      Case _xFilCtb == "015"  
           xFilRet :="VITORIA"
      Case _xFilCtb == "016"  
           xFilRet :="SETE LAGOAS"
      Case _xFilCtb == "901"  
           xFilRet :="ANTENA - GUARULHOS"
      Case _xFilCtb == "902"  
           xFilRet :="SETE LAGOAS"
      OtherWise	                       
           xFilRet := Space(40)   
   EndCase


Return(xFilRet)


Static Function UO(cCodUO)

   xUO := cCodUO
   
   Do Case
      Case xUO == "01"
           xDesc := "RDVM"
      Case xUO == "02"
           xDesc := "PVNO"     
      Case xUO == "11"
           xDesc := "RMLAP"     
      Case xUO == "21"
           xDesc := "ILI"     
      Case xUO == "22"
           xDesc := "RMA"
      Case xUO == "23"
           xDesc := "ADUANA"         
      Case xUO == "31"
           xDesc := "DIRE��O GERAL"
      Case xUO == "32"
           xDesc := "DFCP"     
      Case xUO == "33"
           xDesc := "DRHCO"     
      Case xUO == "34" 
           xDesc := "DIRE��O COMERCIAL"
      Case xUO == "35"
           xDesc := "QUALIDADE"
      Case xUO == "36"
           xDesc := "MARKETING"         
      Case xUO == "37"
           xDesc := "ADMINISTRATIVO"
      Case xUO == "51"
           xDesc := "INFORMATICA"     
      Case xUO == "61"
           xDesc := "FINANCEIRO CORPORATIVO"     
      OtherWise	                 
        xDesc := Space(40)   
   EndCase

Return(xDesc)

Static Function Atividade(cCodAtv,cCodUO)

  xUO := cCodUO
  cNomeAtv := Space(60) 
 
   If Empty(xUO) .Or. xUO == ""
      cNomeAtv := Space(60)    
   Endif

  
   If xUO == "01" .Or. xUO == "02"  
	   Do Case	    
	      Case cCodAtv == "001"  	      
	           cNomeAtv := "Transporte Rodoviario Nacional"	
	      Case cCodAtv == "002"   
	           cNomeAtv := "Transporte Rodoviario Nacional de Transfer�ncia"
	      Case cCodAtv == "003"  
	           cNomeAtv := "Transporte Rodoviario Exporta��o"
	      Case cCodAtv == "004"   
	           cNomeAtv := "Transporte Maritimo Exporta��o"
	      Case cCodAtv == "005"   
	           cNomeAtv := "Gest�o Nacional"
	      Case cCodAtv == "006"   
	           cNomeAtv := "Gest�o Exporta��o"
	      Case cCodAtv == "007"   
	           cNomeAtv := "Survey Nacional"
	      Case cCodAtv == "008"   
	           cNomeAtv := "Survey Exporta��o"
	      Case cCodAtv == "009"   
	           cNomeAtv := "Tropicaliza��o"
	      Case cCodAtv == "010"   
	           cNomeAtv := "Armazenagem Nacional"
	      Case cCodAtv == "011"   
	           cNomeAtv := "Armazenagem Importa��o"
	      Case cCodAtv == "012"   
	           cNomeAtv := "Armazenagem Exporta��o"
	      Case cCodAtv == "013"  
	           cNomeAtv := "Outros Servi�os Logisticos"
	      Case cCodAtv == "014"  
	           cNomeAtv := "Transporte Mar�tmo Importa��o"
	      Case cCodAtv == "015"  
	           cNomeAtv := "Transporte Rodovi�rio Importa��o"
	      Case cCodAtv == "016"  
	           cNomeAtv := "Desembara�o Exporta��o Rodovi�ria"
	      Case cCodAtv == "017"  
	           cNomeAtv := "Desembara�o Importa��o Rodovi�ria"
	      Case cCodAtv == "101"  
	           cNomeAtv := "PVN - VN"
	      Case cCodAtv == "102"   
	           cNomeAtv := "PVN - VO"
	      OtherWise	           
	           cNomeAtv := Space(60) 
	   EndCase             

   Endif
     
   If xUO == "21"   
	   Do Case
	      Case cCodAtv == "301"   
	           cNomeAtv := "Abastecimento Sincrono"	           
	      Case cCodAtv == "302"   
	           cNomeAtv := "Abastecimento Kanban"
	      Case cCodAtv == "303"   
	           cNomeAtv := "Prepara��o de Kits"
	      Case cCodAtv == "304"    
	           cNomeAtv := "Armazenagem"
	      Case cCodAtv == "305"   
	           cNomeAtv := "Outsourcing"
	      Case cCodAtv == "306"   
	           cNomeAtv := "Prepara��o de Embalagens"
	      Case cCodAtv == "307"   
	           cNomeAtv := "Consultoria Logistica"
	      OtherWise
	           cNomeAtv := Space(60) 
	   EndCase             
        
   Endif
  

   If xUO == "11" 
	   Do Case
	      Case cCodAtv == "201"   
	           cNomeAtv := "Carga Fechada Nacional"              	           
	      Case cCodAtv == "202"   
	           cNomeAtv := "Carga Fechada Internacional" 
	      Case cCodAtv == "203"   
	           cNomeAtv := "Carga Fracionada Nacional" 
	      Case cCodAtv == "204"    
	           cNomeAtv := "Carga Fracionada Internacional"
	      Case cCodAtv == "205"   
	           cNomeAtv := "Lote Nacional"
	      Case cCodAtv == "206"   
	           cNomeAtv := "Intercentro Nacional"
	      Case cCodAtv == "207"   
	           cNomeAtv := "Lote Internacional"
	      Case cCodAtv == "208"   
	           cNomeAtv := "Intercentro Internacional"
	      Case cCodAtv == "209"   
	           cNomeAtv := "Transporte Emergencial"
	      Case cCodAtv == "210"   
	           cNomeAtv := "Gefco Especial"
	      OtherWise
	           cNomeAtv := Space(60) 
	   EndCase             
	             	          
   Endif
   

   If xUO == "22" 
	   Do Case
	      Case cCodAtv == "401"   
	           cNomeAtv := "Importa��o Maritima"	           
	      Case cCodAtv == "402"   
	           cNomeAtv := "Exporta��o Maritima"
	      Case cCodAtv == "403"   
	           cNomeAtv := "Importa��o A�rea"
	      Case cCodAtv == "404"    
	           cNomeAtv := "Exporta��o A�rea"
	      Case cCodAtv == "405"   
	           cNomeAtv := "Gefco Immediate Importa��o"
	      Case cCodAtv == "406"   
	           cNomeAtv := "Gefco Immediate Exporta��o"
	      Case cCodAtv == "407"   
	           cNomeAtv := "Armazenagem"
	      Case cCodAtv == "408"   
	           cNomeAtv := "CKD"
	      Case cCodAtv == "409"   
	           cNomeAtv := "Outsourcing Importa��o"
	      Case cCodAtv == "410"   
	           cNomeAtv := "Outsourcing Exporta��o"
	      OtherWise
	           cNomeAtv := Space(60) 
	   EndCase             

   Endif
   
   If xUO == "23" 
	   Do Case
	      Case cCodAtv == "501"   
	           cNomeAtv := "Desembara�o Importa��o Maritima"
	      Case cCodAtv == "502"   
	           cNomeAtv := "Desembara�o Importa��o A�rea"
	      Case cCodAtv == "503"   
	           cNomeAtv := "Desembara�o Exporta��o Maritima"
	      Case cCodAtv == "504"    
	           cNomeAtv := "Desembara�o Exporta��o A�rea"
	      Case cCodAtv == "505"   
	           cNomeAtv := "Desembara�o Importa��o Rodoviaria"
	      Case cCodAtv == "506"   
	           cNomeAtv := "Desembara�o Exporta��o Rodoviaria"
	      Case cCodAtv == "507"   
	           cNomeAtv := "Outsourcing Importa��o"
	      Case cCodAtv == "508"   
	           cNomeAtv := "Outsourcing Exporta��o"
	      OtherWise
	           cNomeAtv := Space(60) 
	   EndCase             

   Endif
     
Return(cNomeAtv)

Static Function Polo(cCodPolo)

	   Do Case
	      Case cCodPolo == "1"   
	           cNomePolo := "Marca AP"
	      Case cCodPolo == "2"   
	           cNomePolo := "Marca AC"
	      Case cCodPolo == "3"   
	           cNomePolo := "DIFA"
	      Case cCodPolo == "4"    
	           cNomePolo := "DLPR"
	      Case cCodPolo == "5"   
	           cNomePolo := "Grupo Gefco"
	      Case cCodPolo == "6"   
	           cNomePolo := "Fora Grupo"
	      Case cCodPolo == "7"   
	           cNomePolo := "Intercentros"
	      OtherWise
	           cNomePolo := Space(40) 
	   EndCase             

Return(cNomePolo)


Static Function StartVar()

     cTipoReg := Space(2)
     cCliCob  := Space(8)
     cCnpjCob := Space(14)
     cNomCob  := Space(40)
     cCliDest := Space(8)
     cCnpjDest:= Space(14)
     cNomDest := Space(40)
     cFornece := Space(8)
     cNomFor  := Space(40)
     cCnpjFor := Space(14)
     cCodCusto:= Space(10)
     cNomCusto:= Space(40)
     cCodDiv  := Space(1)
     cNomDiv  := Space(20)
     cCodUO   := Space(2)
     cNomUO   := Space(40)
     cCodFil  := Space(3)
     cNomFil  := Space(40)
     cCodAtv  := Space(3)
     cNomAtv  := Space(60)
     cCodPolo := Space(1)
     cNomPolo := Space(40)
     cConta   := Space(20)
     cNomConta:= Space(40)
     cContaGer:= Space(20)
     cNomGeren:= Space(20)
     cTipoDoc := Space(3)
     cCodFatura := Space(6)
     cNumBoleto := Space(12)
     cNumDoc  := Space(9)
     cDtFatura:= Space(8) 
     cDtBoleto:= Space(8)
     cDtDoc   := Space(8)
     cDtContab:= Space(8)
     nValor   := 0
     cImposto := Space(20)
     cCfop    := Space(5)
     cNomCfop := Space(55)
     cRefgefco:= Space(20)
     cCustoPSA:= Space(20)
     cOIPSA   := Space(20)
     cTipoDesp:= Space(3)
     cNomeAtv := Space(60)
     
Return