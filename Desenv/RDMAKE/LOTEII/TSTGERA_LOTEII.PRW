#INCLUDE "rwmake.ch"  
#INCLUDE "PROTHEUS.CH"
#INCLUDE "topconn.ch"   
#INCLUDE "tbiconn.ch"     

/*
*----------------------------------------------------------------------------*
* Criado por  : Jesus Oliveira       -          Em: 01/03/2010               *
* Objetivo    : Integra��o dos t�tulos da GEFCO com o SAP da PSA pelo Lote II*
*----------------------------------------------------------------------------*
*/

User Function TSTGEFLT2(pMenu)

  if (pMenu = nil)
  	//Abre o processo para exibir em uma tela tempor�ria o progress bar
  	Processa( {|lEnd| GerarTXT(@lEnd,pMenu)}, "Aguarde...","Gerando arquivo Lote II.", .T. )
  else
  
    //Mensagem de alerta no console para execu��o da rotina em schedule
	RPCSetType(3)  // Nao utilizar licenca
	PREPARE ENVIRONMENT	EMPRESA "01" FILIAL "01" TABLES "SF1", "SD1", "SF2", "SD2", "SA1", "SM0", "SE1", "SE1", "SX6"

    ConOut("Iniciado gera��o do arquivo Lote II - "+dtos(dDatabase)+substr(Time(),1,2)+substr(Time(),4,2)+substr(Time(),7,2)) 
  
  	GerarTXT(pMenu)
	RpcClearEnv()	// Libera o Environment  	
  endif

Return

Static Function GerarTXT(pMenu)
Local _nValorCTRC := 0.00
Local _cMailTo    := GETMV("MV_MAILLT2")
Local _cArquivo	  := ""
Local _aFilADHOC  := Array(18)

  Private cArqTxt := GETMV("MV_CAMLT2")
  Private nHdl    := 0 
  Private cEOL    := "CHR(13)+CHR(10)"
  private sNumLote := GETMV("MV_NLOTE2") 
  private iNumLote := 0 
  private sNumSeq := GETMV("MV_SEQLT2") 
  private iNumSeq := 0 
  private iCod := 0 
  private sPeso := ""
  private sCNPJ := ""
  private sNFs := ""

// Preencho com a filial ADHOC
_aFilADHOC[01] := 5 // Sede
_aFilADHOC[02] := 4 // Beneditinos
_aFilADHOC[03] := 3 // Porto Real
_aFilADHOC[04] := 2 // Barueri
_aFilADHOC[05] := 0 // Pavuna
_aFilADHOC[06] := 1 // Vila Guilherme
_aFilADHOC[07] := 6 // SJP
_aFilADHOC[08] := 7 // Campinas
_aFilADHOC[09] := 10 // Contagem
_aFilADHOC[10] := 13// Sepetiba
_aFilADHOC[11] := 14 // Vila Ol�mpia
_aFilADHOC[12] := 15  // Santos
_aFilADHOC[13] := 4  // RB45
_aFilADHOC[14] := 16  // Sete Lagoas
_aFilADHOC[15] := 17  // Serra
_aFilADHOC[16] := 12 // Nova Pavuna
_aFilADHOC[17] := 18  // Ca�apava
_aFilADHOC[18] := 4  // Porto do Rio

// S� ser� executado o Schedule se n�o for S�bado/Domingo e Feriados Nacionais

If dDataBase <> DataValida(dDataBase)
   	ConOut("Lote II - S�bado/domingo/feriado - rotina abandonada.")
	Return
EndIf

  // QUERY PARA CONTAR OS REGISTROS
  _CQRY := "SELECT   "
  _CQRY += " count(NUMERO) as QTDE "
  _CQRY += "from "
  _CQRY += " INTERFACE_LOTEII "
		
  TCQUERY _CQRY ALIAS "TINTCnt" NEW
		
  DBSELECTAREA("TINTCnt") ; DBGOTOP()
  nCnt := TINTCnt->QTDE
  DBSELECTAREA("TINTCnt") ; DBCloseArea()
  
  // QUERY PARA PEGAR AS FATURAS NA SE1
  _CQRY := "select "
  _CQRY += " * "
  _CQRY += "from "
  _CQRY += " INTERFACE_LOTEII "
						 
  TCQUERY _CQRY ALIAS "TLOTEII" NEW
	
  DBSELECTAREA("TLOTEII") ; DBGOTOP()  
    
  // Verifico se h� registro para ser envia no arquivo                                   
  If TLOTEII->(Eof())
	if (pMenu = nil)
		MsgAlert("N�o h� registros a serem enviados � PSA.","Atencao!")
		TLOTEII->(dbCloseArea())
  	    Return
	else
		ConOut("N�o h� registros a serem enviados � PSA.")
		TLOTEII->(dbCloseArea())
		Return
	endif  	
  EndIf
	
  //Vari�vel para fazer a quebra de linha 
  If Empty(cEOL)
    cEOL := CHR(13)+CHR(10)
  Else
    cEOL := Trim(cEOL)
	cEOL := &cEOL
  Endif
	
  //Atualiza o n�mero lote
  iNumLote := Val(sNumLote)
  iNumLote := iNumLote+1
  sNumLote := Ltrim(Rtrim(str(iNumLote)))
  //Atualiza o n�mero da sequencia SAP
  iNumSeq := Val(sNumSeq)
  iNumSeq := iNumSeq+1
  sNumSeq := Ltrim(Rtrim(str(iNumSeq)))

	//Cria o arquivo TXT no diret�rio selecionado
	_cArquivo := cArqTxt+"\evdfiA1_"+sNumLote+"_"+dtos(dDatabase)+".dat"
	//nHdl := fCreate(cArqTxt+"\evdfiA1_"+sNumLote+"_"+dtos(dDatabase)+".dat")
	nHdl := fCreate(_cArquivo)
	
	//Se a fun��o for chamada pelo menu exibe caixas de mensagens, caso contr�rio, grava apenas no LOG
	if (pMenu = nil)
		If nHdl == -1
			MsgAlert("O arquivo de nome evdfiA1_"+sNumLote+"_"+dtos(dDatabase)+".dat nao pode ser criado! Verifique os parametros.","Atencao!")
		  Return
		Endif
	else
		If nHdl == -1
			ConOut("O arquivo de nome evdfiA1_"+sNumLote+"_"+dtos(dDatabase)+".dat nao pode ser criado! Verifique os parametros.")
		  Return
		Endif
	endif
		  
	//Se a fun��o for chamada pelo menu exibe caixas de mensagens, caso contr�rio, grava apenas no LOG

	if (pMenu = nil)	  
		//Barra de progresso
		ProcRegua(nCnt)
	endif
		
  //Fa�o a grava��o do cabe�alho do arquivo
  ConOut("Gravando Cabe�alho do Lote II.")
  
  cLin := "00"
  cLin += SubStr(dtos(dDatabase),7,2)+SubStr(dtos(dDatabase),5,2)+SubStr(dtos(dDatabase),1,4)
  cLin += substr(Time(),1,2)+substr(Time(),4,2)+substr(Time(),7,2)
  cLin += StrZero(iNumLote,10)
  cLin += "X"
  cLin += Substr(dtos(dDatabase),1,6)+StrZero(iNumSeq,5)
  cLin := RTrim(cLin) + Space(222)
  cLin += cEOL
  //Se a fun��o for chamada pelo menu exibo as mensagens, caso contr�rio, gravo no LOG
	if (pMenu = nil)
		If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			MsgAlert("Ocorreu um erro na gravacao do lote - "+sNumLote,"Atencao!")
  	  Return
		Endif
	else
		If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			ConOut("Ocorreu um erro na gravacao do lote - "+sNumLote)
			Return
		Endif
	endif

	// QUERY PARA PEGAR AS FATURAS NA SE1
/*
	_CQRY := "select "
	_CQRY += " * "
	_CQRY += "from "
	_CQRY += " INTERFACE_LOTEII  "
						 
	TCQUERY _CQRY ALIAS "TLOTEII" NEW
*/	
	DBSELECTAREA("TLOTEII") ; DBGOTOP()
	iCod := 0
	
	conout("In�cio do Loop de processamento do Lote II. - Total de Registro: " + StrZero(nCnt,10))	
	
	WHILE !EOF() 

	  if (pMenu = nil)
		  //Barra de progresso
		  IncProc()
	  endif

	  //Verifico se o CNPJ da filial existe na tabela SZX, caso n�o, vai retornar vazio e gravo uma errata para o t�tulo
	  if (TLOTEII->CNPJ_EMITENTE != '0000000000000000').and.(TLOTEII->CNPJ_EMITENTE != nil)     
		  //Faz as valida��es necess�rias para os t�tulos que est�o sendgo exportados
		  if U_GEFVALLT2( TLOTEII->NUMERO_SE1				,;
		                   TLOTEII->FILIAL					,;
		                   TLOTEII->PREFIXO					,;
		                   RTrim(TLOTEII->CCPSA)			,;
		                   RTrim(TLOTEII->CONTAPSA)			,;
		                   RTrim(TLOTEII->ORDEMINTERNAPSA)	,;
		                   RTrim(TLOTEII->ORDEMINTERNAPSA)	,;
		                   RTrim(TLOTEII->TIPO_DESPESA)		,;
		                   RTrim(TLOTEII->PROCESSO_RMA)		,;
		                   TLOTEII->NFE               		,;
		                   TLOTEII->F3_ESPECIE             	)  // Se for RPS, carrega o n�mero da NF-e		                   
			
		    //Fa�o a grava��o do registro no arquivo
		    cLin := Trim(TLOTEII->TIPO_REGISTRO)
		    cLin += Trim(TLOTEII->TIPO)
		    cLin += Trim(TLOTEII->NUMERO)
		    cLin += TLOTEII->SERIE
		    cLin += Trim(TLOTEII->CNPJ_EMITENTE)
		    cLin += TLOTEII->TIPO_OPERACAO
		    cLin += Trim(TLOTEII->DATAEMISSAO)
		    cLin += Trim(TLOTEII->VENCIMENTOREAL)
		    cLin += TLOTEII->TIPO_DESPESA
		    cLin += Trim(TLOTEII->DESTINO_DESPESA)
		    cLin += TLOTEII->PROCESSO_RMA
		    cLin += Trim(TLOTEII->FLAG_IRRF)
		    cLin += Trim(TLOTEII->VALOR)
		    cLin += Trim(TLOTEII->BASEICMS)
		    cLin += Trim(TLOTEII->ALIQICMS)
		    cLin += Trim(TLOTEII->VALORICMS)
		    
		    //Executo a fun��o que ir� buscar as NFs e o peso caso o DOC seja CTRC
  			iCod2 := 1
  			sCNPJ := "0000000000000000"
  			sPeso := "000000000000000"
  			sNFs := ""				
		    if (Trim(TLOTEII->TIPO) = "CT") .AND. TLOTEII->PREFIXO <> "CTV" .AND. TLOTEII->PREFIXO <> "CTA"
					// Fun��o que busca as NFs dos CTRCs
					If TLOTEII->FILIAL $ "06|08" // VG e Campinas
						// CONOUT("TMS")
						_CQRY := " select * from BuscarNF_TMS_LoteII where Filial = '"+Trim(TLOTEII->FILIAL)+"' and CTRC = '"+Trim(TLOTEII->NUMERO_SE1)+"' " 
					Else	
						// CONOUT("ADHOC " + StrZero(_aFilADHOC[Val(TLOTEII->FILIAL)],2) + " TITULO : " + Trim(TLOTEII->NUMERO_SE1))
						_CQRY := " select * from BuscarNF_ADHOC_LoteII where Filial = '"+StrZero(_aFilADHOC[Val(TLOTEII->FILIAL)],02) +"' and CTRC = '"+Trim(TLOTEII->NUMERO_SE1)+"' " 
					EndIf	
										
					TCQUERY _CQRY ALIAS "TNFs" NEW		
					DBSELECTAREA("TNFs") ; DBGOTOP()
					
					WHILE !EOF() 				
				    	//Limitado a QTDE de 10 NFs por registro
		  			    if iCod2 <= 10 
					      sNFs := sNFs + TNFs->NotaFiscal
					    endif 
  						sCNPJ := TNFs->CNPJ
				    	sPeso := TNFs->SOMA_PESO
				    	
						DBSELECTAREA("TNFs") ; DBSKIP()
				    	iCod2 := iCod2 + 1
					END			
				  DBSELECTAREA("TNFs") ; DBCloseArea()		  
		    endif
			/* Fim da fun��o que busca as NFs dos CTRCs */ 
		    
			//Limitado a QTDE de 10 NFs por registro, mas se estiver menos, completa com zeros
			For i:=iCod2 to 10
				sNFs := sNFs + "000000"
			Next i 
				
		    cLin += sPeso 
		    cLin += sPeso
		    cLin += TLOTEII->TIPOUNIDADE
		    cLin += TLOTEII->MEIODETRANSPORTE
		    cLin += "000000000000000" // Seria o Valor do Frete, mas no sistema antigo est� zero no codigo fonte
		    cLin += Trim(TLOTEII->VALOR_SEGURO)
		    cLin += Trim(TLOTEII->OUTRAS_DESPESAS)
		    cLin += TLOTEII->CFOP
		    cLin += TLOTEII->CCPSA
		    cLin += TLOTEII->ORDEMINTERNAPSA
		    cLin += Trim(TLOTEII->SERVICO)
		    cLin += Trim(TLOTEII->BENEFICIO_RICMS)
		    cLin += Trim(TLOTEII->ISENCAO_ICMS)
		    cLin += TLOTEII->CONTAPSA
		    cLin += sCNPJ
		    cLin += sNFs // Hoje s� vai at� 10 Notas Fiscais, por limita��o do Layout do Arquivo 
		    cLin += TLOTEII->PREFIXO
		    cLin += Trim(TLOTEII->RECNO_E1)
		    //A despesa s� � preenchida para a Expota��o
		    if (Trim(TLOTEII->TIPO_DESPESA) = "E")
		    	cLin += Trim(TLOTEII->DESPESA)
		    else 
		    	cLin += "000"    
		    endif

		    //Caracter para indicar fim de linha
		    cLin := RTrim(cLin) 
		    cLin += cEOL
		                                           
		    // Acumulo o valor do CTRC
		    _nValorCTRC += (Val(TLOTEII->VALOR)/100)
                  
			// Conta Registro
			iCod++
		
			//Se a fun��o for chamada pelo menu exibo as mensagens, caso contr�rio, gravo no LOG
			if (pMenu = nil)
				//Gravar linha no arquivo TXT
				If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
					If !MsgAlert("Ocorreu um erro na gravacao do lote - "+sNumLote,"Atencao!")
					  Return
				  	Endif
				Endif
				 
				//Incrementa a barra de progress�o
				IncProc("Gravando linha: "+Ltrim(Rtrim(str(iCod))))
			else
				//Gravar linha no arquivo TXT
				If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
					ConOut("Ocorreu um erro na gravacao do lote - "+sNumLote)
 					Return
				Endif
			endif

			//Gravo o resultado na SZP
/*			
			dbSelectArea("SZP")
			dbSetOrder(3) // Chave
			If !dbSeek(TLOTEII->FILIAL+TLOTEII->NUMERO_SE1+TLOTEII->PREFIXO)
				RecLock("SZP",.T.)
		    	SZP->ZP_FILIAL := TLOTEII->FILIAL // Filial do Documento
		    	SZP->ZP_LOTE := sNumLote //N�mero do Lote sendo gerado
		     	SZP->ZP_DATA := DDATABASE //Data do servidor
		     	SZP->ZP_DOC := TLOTEII->NUMERO_SE1 //Documento
		    	SZP->ZP_PREFIXO := TLOTEII->PREFIXO //Prefixo do documento
			    SZP->ZP_REG := cLin
			    SZP->ZP_ERRATA := ""
				MsUnLock()
				//Caso DOC j� exista, atualizo o campo ERRATA
			Else
				RecLock("SZP",.F.)
		    	SZP->ZP_LOTE := sNumLote //N�mero do Lote sendo gerado
		     	SZP->ZP_DATA := DDATABASE //Data do servidor
			    SZP->ZP_REG := cLin
		    	SZP->ZP_ERRATA := ""
				MsUnLock()
			EndIf
  */
			DbSelectArea("SZP")  // ; dbCloseArea()
/*
			//Gravo o FLAG da SE1
			dbSelectArea("SE1")
			dbSetOrder(1) // Chave
			If !dbSeek(TLOTEII->FILIAL+TLOTEII->PREFIXO+TLOTEII->NUMERO_SE1+TLOTEII->PARCELA+TLOTEII->TIPODOC)
			  	ConOut("O t�tulo - "+TLOTEII->NUMERO_SE1+" n�o foi localizado na tabela SE1 para o lote - "+sNumLote)
			Else
				RecLock("SE1",.F.)
		    	SE1->E1_FLGLT2 := sNumLote //N�mero do Lote sendo gerado
				MsUnLock()
			EndIf
			DbSelectArea("SE1")  // ; dbCloseArea()
  */
		  endif  
	  
	  else
/*	  
			//Gravo Erratas na SZP
			dbSelectArea("SZP")
			dbSetOrder(3) // Chave
			If !dbSeek(TLOTEII->FILIAL+TLOTEII->NUMERO_SE1+TLOTEII->PREFIXO)
				RecLock("SZP",.T.)
		    	SZP->ZP_FILIAL := TLOTEII->FILIAL // Filial do Documento
		    	SZP->ZP_LOTE := sNumLote //N�mero do Lote sendo gerado
		     	SZP->ZP_DATA := DDATABASE //Data do servidor
		     	SZP->ZP_DOC := TLOTEII->NUMERO_SE1 //Documento
		    	SZP->ZP_PREFIXO := TLOTEII->PREFIXO //Prefixo do documento
			    SZP->ZP_ERRATA := "O CNPJ desta filial n�o foi criado na tabela SZX."
				MsUnLock()
		  //Caso DOC j� exista, atualizo o campo ERRATA
			Else
				RecLock("SZP",.F.)
		    	SZP->ZP_LOTE := sNumLote //N�mero do Lote sendo gerado
		     	SZP->ZP_DATA := DDATABASE //Data do servidor
		    	SZP->ZP_ERRATA := "O CNPJ desta filial n�o foi criado na tabela SZX."
			MsUnLock()
			EndIf
			DbSelectArea("SZP")  ; dbCloseArea()
*/			
  	  endif
	  
		DBSELECTAREA("TLOTEII") ; DBSKIP()

	END
  //Fa�o a grava��o do rodap� do arquivo
  conout("In�cio do gera��o do rodap� do Lote II.")	
  cLin := "99"
  cLin += StrZero(iCod,10)
  cLin := RTrim(cLin) + Space(248)
  cLin += cEOL
  //Se a fun��o for chamada pelo menu exibo as mensagens, caso contr�rio, gravo no LOG
	if (pMenu = nil)
		If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			MsgAlert("Ocorreu um erro na gravacao do lote - "+sNumLote,"Atencao!")
  	  		Return
		Endif
	else
		If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			ConOut("Ocorreu um erro na gravacao do lote - "+sNumLote)
			Return
		Endif
	endif

  //Fecha o arquivo TXT criado
  fClose(nHdl)                
  DBSELECTAREA("TLOTEII") ; DBCloseArea()
  
  //Atualizo o n�mero do Lote e, do sequencial SAP, somente se houver t�tulos
//  PUTMV("MV_NLOTE2",sNumLote) 

  if iCod > 0 
//  	PUTMV("MV_SEQLT2",sNumSeq) 
        
  	if (pMenu = nil)
  		MsgInfo("Arquivo gerado com sucesso! Foram exportados "+Ltrim(Rtrim(str(iCod)))+" registros no lote - "+sNumLote, "Informa��o") 
  	
		// EmailCapaLote(iCod, _nValorCTRC, sNumLote, sNumSeq, _cMailTo, _cArquivo)
	else
  		ConOut("Arquivo gerado com sucesso! Foram exportados "+Ltrim(Rtrim(str(iCod)))+" registros no lote - "+sNumLote)
    	// Envia do e-mails de erratas
    
  		// Envia e-mail de capa de Lote
		ConOut("Envio de e-mails de Capa de Lote: " + _cMailTo)
//		EmailCapaLote(iCod, _nValorCTRC, sNumLote, sNumSeq, _cMailTo, _cArquivo)
      
  		ConOut("In�cio de envio de e-mails de erratas.")    
    	//U_GEFMAILLT2(.T.)    	
  		ConOut("Final de envio de e-mails de erratas.")
  	endif
  Else
  	 // N�o foi gerado interface para nenhum t�tulo
  	if (pMenu = nil)
  		MsgInfo("N�o foi gerado interface para nenhum t�tulo", "Informa��o") 
	else
  		ConOut("N�o foi gerado interface para nenhum t�tulo para o Lote: " + sNumLote )
  	endif
  	If File(_cArquivo)
  		fErase(_cArquivo)
  	EndIf	
  EndIf	
return
  
*----------------------------------------------------------------------------------------*
Static Function EmailCapaLote(iCod, _nValorCTRC, sNumLote, sNumSeq, _cMailTo, _cArquivo)
*----------------------------------------------------------------------------------------*

	cAssunto := "Exporta��o Lote II - " + dTOc(dDataBase)
	cAnexo   := _cArquivo
	cCc      := "" 
	cPara    := AllTrim(_cMailTo) // GETMV("MV_MAILLT2")
	cDe      := "atende.ti@gefco.com.br" 
  
	cMsg := "<b>Capa do Lote da Interface Lote II: </b>" + "<BR>"
	cMsg += "<BR>"
	cMsg += "<b>Data Gera��o:</b> " + dTOc(dDataBase)   + "<BR>"
	cMsg += "<b>Lote:</b> " 		+ AllTrim(sNumLote) + "<BR>"
	cMsg += "<b>Seq. Lote:</b> " 	+ AllTrim(sNumSeq)  + "<BR>"
	cMsg += "<b>Qtd. T�tulo:</b> "  + TransForm(iCod,"@E 999,999,999") + "<BR>"
	cMsg += "<b>Valor Total:</b> "	+ Transform(_nValorCTRC,"@E 999,999,999,999.99") + "<BR>"
	
  	cMsg += "<BR>"
  	cMsg += "<BR>"
	cMsg += "Esta � uma mensagem autom�tica do sistema Protheus. Favor n�o responder!"
                
	*---------------------------------------------*
//	U_EnvEmail(cDe,cPara,cCc,cAssunto,cMsg,cAnexo)
	*---------------------------------------------*	 
Return
                                      
//USER Function TstEmail(iCod, _nValorCTRC, sNumLote, sNumSeq, _cMailTo, _cArquivo)
//Return EmailCapaLote(iCod, _nValorCTRC, sNumLote, sNumSeq, _cMailTo, _cArquivo)