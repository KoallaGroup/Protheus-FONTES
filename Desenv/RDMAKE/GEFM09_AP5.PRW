#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 18/10/00

User Function GEFM01()        // incluido pelo assistente de conversao do AP5 IDE em 18/10/00

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//Alert("Realmente consegui compilar de outro local e nao do SERVIDOR")
SetPrvt("XCLILOJA,ARADIO,NRADIO,POS,CNL,XARQ")
SetPrvt("ARQ01,NHDL,TE1,_ACAMPOS,_CNOME,CINDEX")
SetPrvt("CCHAVE,NINDEX,ERROR,_XCLI,_XNAT,VCF")

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    쿒EFM01    � Autor � Alexandre de Almeida  � Data � 05.01.98 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o 쿔mportacao do Documento (Arquivo GEFCCTRC.TXT) criando :    낢�
굇�          �                                                            낢�
굇�          � Titulo a Receber                                          낢�
굇�          � Titulo a Pagar - Seguradora                               낢�
굇�          � Titulo a Pagar - Transportadora                           낢�
굇�          � Registro Livros Fiscais                                   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/
xcliloja:=" "  //VARIAVEL GUARDA O COD DO CLIENTE PARA UTILIZACAO DO SEEK DO SF3
aRadio := {"Conhecimento frete","Notas Fiscais"}
nRadio := 1


@ 000,000 To 250,370 Dialog oDlg Title "GEFCO - IMPORTA�AO DE NOTAS"
//@ 077,010 BITMAP SIZE 165,60 FILE "IMG.BMP"
@ 003,016 To 60,144
@ 010,021 Say OemToAnsi("Este programa tem o objetivo de importar")
@ 022,021 Say OemToAnsi("os arquivos que foram gerados no padrao TXT")
@ 010,152 BmpButton Type 1 Action OBJ()// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> @ 010,152 BmpButton Type 1 Action Execute(OBJ)
@ 030,152 BmpButton Type 2 Action Close(oDlg)
Activate Dialog oDlg Centered
Return


// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> Function OBJ
Static Function OBJ()
@ 0,0 TO 250,450 DIALOG oDlg1 TITLE "IMPORTACAO DE DADOS"
@ 16,80 TO 67,180 TITLE "Importacao de dados"
@ 23,80 RADIO aRadio VAR nRadio
@ 80,100 BUTTON "_Ok" SIZE 35,15 ACTION Import()// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> @ 80,100 BUTTON "_Ok" SIZE 35,15 ACTION Execute(Import)
@ 100,100 BUTTON "_Cancel" SIZE 35,15 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTER

Return

***************
// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> Function Import
Static Function Import()
***************

Processa({|| ProcTxt()},"Processando...")// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==>  Processa({|| Execute(ProcTxt)},"Processando...")
Close(oDlg)
Close(oDlg1)
DbSelectArea("SA2")
DbSetOrder(1)
Fina370(.T.)
Return

****************
// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> Function ProcTxt
Static Function ProcTxt()
****************

pos  := 0
cNL  := CHR(13)+CHR(10)


If nRadio == 1
	xarq:="GEFCCTRC.TXT"
Else
	xarq:="GEFCNOTA.TXT"
Endif


If !File(xarq)
	Msgbox("Arquivo nao existe , verifique seus dados","Mensagem!!!","STOP")
Else
	
	********************************************
	* Abre o Arquivo para receber a localizacao     *
	********************************************
	_xloc:=""        //Local de Origem
	Arq02  := xarq
	nHd2   := NIL
	ntam   := 159        // 454 em 16/04/01
	nHd2   := fopen(Arq02)
	cbuffer:= space(ntam)
	nbytes := 0
	nbytes := fRead(nHd2,@cbuffer,ntam)
	_xloc  := substr(cbuffer,15,2)
	Fclose(nHd2)
	
	// criacao do arquivo Log
	//=======================
	Arq01  := "errata.log"
	nHdl   := fCreate(Arq01)
	te1:="Criacao do arquivo de erros gerados pelo sistema de importacao - Data: "+dtoc(ddatabase)+cNL
	fWrite(nHdl,te1,Len(te1))
	te1:="======================================================================================"+cNL
	fWrite(nHdl,te1,Len(te1))
	
	_aCampos:={}
	Aadd(_aCampos,{"INDICE","N",02,0 })
	Aadd(_aCampos,{"NF"    ,"C",06,0 })
	Aadd(_aCampos,{"XDATA" ,"C",08,0 })
	Aadd(_aCampos,{"CDDEST","C",14,0 })
	Aadd(_aCampos,{"CDCLI" ,"C",14,0 })
	Aadd(_aCampos,{"CDFIS" ,"C",03,0 })
	Aadd(_aCampos,{"ALICM" ,"C",05,0 })
	Aadd(_aCampos,{"VLCONT","C",14,0 })
	Aadd(_aCampos,{"ICMTRI","C",14,0 })
	Aadd(_aCampos,{"BASIPI","C",14,0 })
	Aadd(_aCampos,{"VALIPI","C",14,0 })
	Aadd(_aCampos,{"CDTRA" ,"C",14,0 })
	Aadd(_aCampos,{"VLSEG" ,"C",14,0 })
	Aadd(_aCampos,{"VLPTR" ,"C",14,0 })
	Aadd(_aCampos,{"TPDOC" ,"C",03,0 })
	Aadd(_aCampos,{"CC"    ,"C",06,0 })	
	
	_cNome := CriaTrab(_aCampos)
	
	DbUseArea( .T.,,_cNome,"TRA",.F. )
	DbSelectArea("TRA")
	cIndex := CriaTrab(nil,.f.)
	cChave := "NF+CDCLI"
	nIndex :=IndRegua("TRA",cIndex,cChave,,,"Selecionando Registros...TRA")
	IF nRadio == 2
		Append from GEFCNOTA.TXT sdf
	Else
		Append from GEFCCTRC.TXT sdf
	Endif
	DbGotop()
	DbSelectArea("SA1")
	DbSetorder(3)
	DbSelectArea("SA2")
	DbSetorder(3)
	DbSelectArea("SE1")
	DbSetOrder(1)
	DbSelectArea("TRA")
	DbGotop()
	ProcRegua(RecCount())
	
	While !Eof()
		
		If TRA->INDICE == 00
			MSGINFO("Arquivo do Mes " + Substr(TRA->NF,5,2)+"/"+Substr(TRA->NF,1,4))
			DbselectArea("TRA")
			Dbskip()
			Loop
		EndIf
		If TRA->INDICE == 99
			MSGINFO("Total de Registros : " + TRA->NF )
			DbselectArea("TRA")
			Dbskip()
			Loop
		EndIf
		
		error:=0
		
		IncProc()
		DbselectArea("SA1")
		If !(Dbseek(xFilial("SA1")+TRA->CDCLI,.T.))
			pos   := 3
			errata()
			error := 1
		Endif
		
		If nRadio == 1			
			DbSelectArea("SA2")
			If !(DbSeek(xFilial("SA2")+TRA->CDTRA,.T.))
				pos   := 2
				errata()
				error := 1
			EndIf
		EndIf
		
		DbSelectArea("SE1")
		If (DbSeek(xFilial("SE1")+TRA->TPDOC+TRA->NF+" "+"NF "))  //PARA NOTAS FISCAIS
			pos   := 1
			errata()
			error := 1
		Endif
		
		If error == 0
			//xcliloja:=SA1->A1_COD+SA1->A1_LOJA
			Reclock("SE1",.T.)
			SE1->E1_FILIAL  := xFilial("SE1")
			SE1->E1_NATUREZ := SA1->A1_NATUREZ
			SE1->E1_NOMCLI  := SA1->A1_NOME
			SE1->E1_NUM	    := TRA->NF
			SE1->E1_PREFIXO := TRA->TPDOC //Prefixo do titulo (CTL, CTR, CTV etc.)
			SE1->E1_TIPO    := "NF"
			SE1->E1_CLIENTE := SA1->A1_COD
			SE1->E1_LOJA    := SA1->A1_LOJA
			SE1->E1_EMISSAO := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))
			SE1->E1_EMIS1   := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))
			SE1->E1_VENCTO  := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))+30
			SE1->E1_VENCORI := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))+30
			SE1->E1_VENCREA := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))+30
			SE1->E1_VALOR   := Val(Substr(TRA->VLCONT,1,Len(TRA->VLCONT)-2)+"."+Substr(TRA->VLCONT,Len(TRA->VLCONT)-1,2))
			SE1->E1_SALDO   := Val(Substr(TRA->VLCONT,1,Len(TRA->VLCONT)-2)+"."+Substr(TRA->VLCONT,Len(TRA->VLCONT)-1,2))
			SE1->E1_VLCRUZ  := Val(Substr(TRA->VLCONT,1,Len(TRA->VLCONT)-2)+"."+Substr(TRA->VLCONT,Len(TRA->VLCONT)-1,2))
			SE1->E1_FLUXO   := "S"
			SE1->E1_MOEDA   := 1
			SE1->E1_OCORREN := "01"
			SE1->E1_STATUS  := "A"
			SE1->E1_ORIGEM  := "FINA040"
			SE1->E1_SITUACA := "0"
			SE1->E1_CCONT := TRA->CC
			SE1->E1_IPI  := Val(Substr(TRA->VALIPI,1,Len(TRA->VALIPI)-2)+"."+Substr(TRA->VALIPI,Len(TRA->VALIPI)-1,2))
			If TRA->CDFIS == "LIX"
				SE1->E1_ISS   := Val(Substr(TRA->ICMTRI,1,Len(TRA->ICMTRI)-2)+"."+Substr(TRA->ICMTRI,Len(TRA->ICMTRI)-1,2))
			Else
				SE1->E1_VLRICM:= Val(Substr(TRA->ICMTRI,1,Len(TRA->ICMTRI)-2)+"."+Substr(TRA->ICMTRI,Len(TRA->ICMTRI)-1,2))
			Endif
			Msunlock()
			pagar()
			fiscal()
		Endif
		DbselectArea("TRA")
		Dbskip()
	End
Endif
fClose(nHdl)
If pos == 0
	Alert("Importacao Concluida com Sucesso !!")
	// 	TRA->DBCLOSEAREA()
	DBCLOSEAREA("TRA")
Else
	Alert("Importacao Concluida com OBS. !!")
	Alert("Verificar ERRATA.LOG !!")
	// 	TRA->DBCLOSEAREA()
	DBCLOSEAREA("TRA")
EndIf
Return

**************
// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> Function Pagar
Static Function Pagar()
**************

DbselectArea("SA2")
DbSetOrder(3)
DbSeek(xFilial("SA2")+tra->CDTRA)

DbselectArea("SE2")

If !(Dbseek(xFilial("SE2")+TRA->TPDOC+TRA->NF+"2"+"NF "+SA2->A2_COD+SA2->A2_LOJA))
	
	If TRA->TPDOC == "CTR" .or.  TRA->TPDOC == "CTV"   &&& Modificado Pelo Analista LUIZ FERNANDO
		DbselectArea("SA2")
		DbSetOrder(3)
		DbSeek(xFilial("SA2")+tra->CDTRA)
		
		Reclock("SE2",.T.)
		SE2->E2_FILIAL  := xFilial("SE2")
		SE2->E2_PREFIXO := TRA->TPDOC
		SE2->E2_NUM	 := TRA->NF
		SE2->E2_PARCELA := "2"
		SE2->E2_TIPO	 := "NF"
		SE2->E2_FORNECE := SA2->A2_COD
		SE2->E2_LOJA    := SA2->A2_LOJA
		SE2->E2_NATUREZ := SA2->A2_NATUREZ
		SE2->E2_NOMFOR  := SA2->A2_NOME
		SE2->E2_EMISSAO := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))
		SE2->E2_EMIS1   := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))
		SE2->E2_VENCTO  := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))
		SE2->E2_VENCORI := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))
		SE2->E2_VENCREA := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))
		SE2->E2_VALOR	 := Val(Substr(TRA->VLPTR,1,Len(TRA->VLPTR)-2)+"."+Substr(TRA->VLPTR,Len(TRA->VLPTR)-1,2))
		SE2->E2_SALDO	 := Val(Substr(TRA->VLPTR,1,Len(TRA->VLPTR)-2)+"."+Substr(TRA->VLPTR,Len(TRA->VLPTR)-1,2))
		SE2->E2_VLCRUZ  := Val(Substr(TRA->VLPTR,1,Len(TRA->VLPTR)-2)+"."+Substr(TRA->VLPTR,Len(TRA->VLPTR)-1,2))
		SE2->E2_HIST    := "Titulo a Pagar Transportadora"
		SE2->E2_FLUXO	 := "S"
		SE2->E2_RATEIO  := "N"
		SE2->E2_MOEDA	 := 1
		SE2->E2_OCORREN := "01"
		SE2->E2_ORIGEM  := "FINA050"
		SE2->E2_CCONT := TRA->CC
		SE2->E2_DESDOBR := "N"
	Endif
	Msunlock()
Else
	//pos:= 5  //Alteracao Vinicius. O programa estava exibindo a mensagem de que os
	//errata() //titulos da transportadora jah estavam incluidos.
Endif

If TRA->CDFIS == "LIX" .OR. ALLTRIM(TRA->CDFIS) == "CI"
	DbselectArea("SE2")
	If !(Dbseek(xFilial("SE2")+TRA->TPDOC+TRA->NF+" "+"TX "+"MUNIC"))
		Reclock("SE2",.T.)
		SE2->E2_FILIAL  := xFilial("SE2")
		SE2->E2_PREFIXO := IIF(TRA->TPDOC=="CTR","CTR","UNI")
		SE2->E2_NUM     := TRA->NF
		SE2->E2_TIPO    := "TX"
		SE2->E2_FORNECE := "MUNIC"
		SE2->E2_LOJA    := "00"
		SE2->E2_NATUREZ := "ISS"
		SE2->E2_NOMFOR  := "MUNICIPIO"
		SE2->E2_EMISSAO := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))
		SE2->E2_EMIS1   := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))
		SE2->E2_VENCTO  := Ctod("05/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))
		SE2->E2_VENCORI := Ctod("05/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))
		SE2->E2_VENCREA := DataValida(Ctod("05/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4)))
		SE2->E2_VALOR   := Val(Substr(TRA->ICMTRI,1,Len(TRA->ICMTRI)-2)+"."+Substr(TRA->ICMTRI,Len(TRA->ICMTRI)-1,2))
		SE2->E2_SALDO   := Val(Substr(TRA->ICMTRI,1,Len(TRA->ICMTRI)-2)+"."+Substr(TRA->ICMTRI,Len(TRA->ICMTRI)-1,2))
		SE2->E2_VLCRUZ  := Val(Substr(TRA->ICMTRI,1,Len(TRA->ICMTRI)-2)+"."+Substr(TRA->ICMTRI,Len(TRA->ICMTRI)-1,2))
		SE2->E2_HIST    := "Titulo a Pagar ISS"
		SE2->E2_FLUXO   := "S"
		SE2->E2_RATEIO  := "N"
		SE2->E2_MOEDA   := 1
		SE2->E2_OCORREN := "01"
		SE2->E2_ORIGEM  := "FINA040"
		SE2->E2_DESDOBR := "N"
		SE2->E2_CCONT   := TRA->CC
		Msunlock()
	Else
		pos:= 7
		errata()
	Endif
Endif
Return

***************
// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> Function Fiscal
Static Function Fiscal()
***************

DbselectArea("SA1")
If !(Dbseek(xFilial("SA1")+TRA->CDDEST,.T.))
	//   pos:=3
	errata()
	error := 1
Else
	xcliloja:=SA1->A1_COD+SA1->A1_LOJA
Endif

DbSelectArea("SF3")
DbSetOrder(4)

If !(DbSeek(xFilial("SF3")+xcliloja+TRA->NF+TRA->TPDOC))
	Reclock("SF3",.T.)
	SF3->F3_FILIAL	:= xFilial("SF3")
	SF3->F3_REPROC	:= "N"
	SF3->F3_ENTRADA := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))
	SF3->F3_NFISCAL := TRA->NF
	SF3->F3_SERIE   := IIf(_xloc =="MV","CTV","UNI")  //MODIFICADO RICARDO COHEN
	SF3->F3_CLIEFOR := substr(xcliloja,1,6)
	SF3->F3_LOJA    := substr(xcliloja,7,2)
	SF3->F3_CFO     := ALLTRIM(TRA->CDFIS)
	SF3->F3_ESTADO	:= SA1->A1_EST
	SF3->F3_EMISSAO := Ctod(Substr(TRA->XDATA,7,2)+"/"+Substr(TRA->XDATA,5,2)+"/"+Substr(TRA->XDATA,1,4))
	SF3->F3_ALIQICM := Val(Substr(tRA->ALICM,1,Len(TRA->ALICM)-2)+"."+Substr(TRA->ALICM,Len(TRA->ALICM)-1,2))
	SF3->F3_BASEICM := Val(Substr(TRA->VLCONT,1,Len(TRA->VLCONT)-2)+"."+Substr(TRA->VLCONT,Len(TRA->VLCONT)-1,2))
	SF3->F3_VALCONT := Val(Substr(TRA->VLCONT,1,Len(TRA->VLCONT)-2)+"."+Substr(TRA->VLCONT,Len(TRA->VLCONT)-1,2))
	SF3->F3_VALICM	:= Val(Substr(TRA->ICMTRI,1,Len(TRA->ICMTRI)-2)+"."+Substr(TRA->ICMTRI,Len(TRA->ICMTRI)-1,2))
	SF3->F3_ESPECIE := IIF(TRA->TPDOC=="CTR","CTR"," NF")
	SF3->F3_TIPO    := IIf(TRA->CDFIS == "LIX" .OR. ALLTRIM(TRA->CDFIS) == "CI" .OR. ALLTRIM(TRA->CDFIS) == "58" .OR. ALLTRIM(TRA->CDFIS) == "55", "S" , " ")
	SF3->F3_BASEIPI := Val(Substr(TRA->BASIPI,1,Len(TRA->BASIPI)-2)+"."+Substr(TRA->BASIPI,Len(TRA->BASIPI)-1,2))
	SF3->F3_VALIPI	:= Val(Substr(TRA->VALIPI,1,Len(TRA->VALIPI)-2)+"."+Substr(TRA->VALIPI,Len(TRA->VALIPI)-1,2))
	
	If TRA->CDFIS == "LIX" .OR. ALLTRIM(TRA->CDFIS) == "CI" .OR. ALLTRIM(TRA->CDFIS) == "58".OR. ALLTRIM(TRA->CDFIS) == "55"
		SF3->F3_OBSERV := "Incidencia de ISS"
		SF3->F3_CODISS  := ALLTRIM(TRA->CDFIS)
	Else
		SF3->F3_OBSERV := "Incidencia de ICMS"
	EndIf
	Msunlock()
Else
	pos:=6
	errata()
Endif
Return

***************
// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> Function Errata
Static Function Errata()
***************

If pos == 1
	te1:="Titulo ja existente..: "+tra->NF+" "+tra->CDCLI+cNL
	fWrite(nHdl,te1,Len(te1))
Endif
If pos == 2
	te1:="Fornecedor nao existe.: "+tra->CDTRA+" "+" Documento "+tra->NF+cNL
	fWrite(nHdl,te1,Len(te1))
Endif
If pos == 3
	te1:="Cliente Inexistente.: "+tra->CDCLI+" "+" Documento "+tra->NF+cNL
	fWrite(nHdl,te1,Len(te1))
Endif
If pos == 4
	te1:="Titulo da Seguradora ja existe -S00001 - 01"+" Documento "+tra->NF+cNL
	fWrite(nHdl,te1,Len(te1))
Endif
If pos == 5
	te1:="Titulo da Trasportadora existe "+tra->cdtra+"-"+"Documento "+tra->NF+cNL
	fWrite(nHdl,te1,Len(te1))
Endif
If pos == 6
	te1:="Registro Fiscal existe - Documento "+tra->NF+cNL
	fWrite(nHdl,te1,Len(te1))
Endif
If pos == 7
	te1:="Titulo de Iss ja Existe "+tra->NF+cNL
	fWrite(nHdl,te1,Len(te1))
Endif

Return

