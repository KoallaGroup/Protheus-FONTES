#include "rwmake.ch"        

User Function GFAT001()     

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP6 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("XTABDE,XTABPA,MSG,XCHV,XPRCDE,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿛rograma  � GFAT001  � Autor � Saulo Muniz           � Data � 18.01.05 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Rotina de Clonagem de Tabela de TES                        낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢tilizacao� Especifico para Gefco                                      낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

If !File("\SIGAADV\SF4.dbf")
   MsgInfo("Diretorio / Arquivo nao localizado"+CHR(13)+"Abandonando ..."+CHR(13)+"\UTIL\SF4.dbf")
   Return(.f.)
Else	    
    Use \SIGAADV\SF4 New Exclusive Alias TES	
	DbSelectArea("TES")
	//DbSetOrder(1)	
EndIf


dbselectarea("SF4")
dbsetorder(1)
dbgotop()

xTabDe := xFilial()
XTabPa := "  "

@ 200,001 TO 390,410 DIALOG oDlg TITLE "Clonagem de TES para Filiais "
@ 010,010 Say "Da Filial (Origem) :  "
@ 010,060 Get xTabDe Picture "@!"
@ 025,010 Say "Para Filial (Destino) : "
@ 025,060 Get xTabPa Picture "@!" //Valid xTabPa#xTabDe

@ 075,135 BMPBUTTON TYPE 01 ACTION Roda()
@ 075,170 BMPBUTTON TYPE 02 ACTION Close(oDlg)

ACTIVATE DIALOG oDlg CENTERED

Return

//=============//
Static Function Roda()
//=============//  

xCount := 0

Msg:='Confirma Clonagem das TES '
Msg:=Msg+Substr(xTabDe,1)+' Para a Filial '+Substr(xTabPa,1)+' ?'
If MsgBox(Msg,"","YESNO")

	dbselectarea("SF4")
	
	while !Eof() //.And. xFilial() == SF4->F4_FILIAL

		xCount := xCount + 1
        //_campo := FieldGet()				
  
		//Carrega os DADOS DE			
            /*
    		F4_FILIAL   :=
    		F4_CODIGO   :=
            F4_TIPO     :=
            F4_ICM      :=
            F4_IPI      :=
            F4_CREDICM  :=
            F4_CREDIPI  :=
            F4_DUPLIC   :=
            F4_ESTOQUE  :=
            F4_CF       :=
            F4_CFNOVO   :=
            F4_TEXTO    :=
            F4_PODER3   :=
            F4_LFICM    :=
            F4_LFIPI    :=
            F4_DESTACA  :=
            F4_INCIDE   :=
            F4_COMPL    :=
            F4_ISS      :=
            F4_LFISS    :=
            F4_IPIFRET  :=
            F4_CONSUMO  :=
            F4_UPRC     :=
            F4_AGREG    :=
            F4_INCSOL   :=
            F4_CIAP	    :=
            F4_DESPIPI	:=
            F4_ATUTEC	:=
            F4_ATUATF	:=
            F4_TPIPI    :=
            F4_BASEISS  :=
            F4_BSICMST	:=
            F4_CREDST	:=
            F4_STDESC	:=
            F4_DESPICM	:=
            F4_SITTRIB	:=
            F4_PISCOF	:=
            F4_PISCRED  :=
            F4_TESDV    :=
           	F4_TPMOV    :=
       		F4_MOVPRJ   :=
       		F4_IPILICM	:=
       		F4_ICMSDIF	:=
       		F4_TESP3	:=
       		F4_QTDZERO	:=
       		F4_SLDNPT	:=
       		F4_DEVZERO	:=
       		F4_TIPOPER	:=
       		F4_TESENV	:=
       		F4_OBSICM	:=
       		F4_REGDSTA	:=
       		F4_OBSSOL	:=
       		F4_TRFICM	:=
       		F4_PICMDIF	:=
       		F4_BASEPIS  :=            
            */
		//Grava os DADOS PARA
			
          RecLock("TES",.T.)      
          TES->F4_FILIAL := xTabPa
          TES->F4_CODIGO := SF4->F4_CODIGO          
		  MsUnLock()		


		dbskip()
			
	End
    MSGINFO("REGISTROS : "+SUBSTR())
Else
	Help(" ",1,"SEMPED",,"Clonagem Cancelada !!",3,1)

Endif
  /*
  // GRAVA
  For i:=1 to Len(xCount)
  	  RecLock("SF4",.T.)      
      SF4->F4_FILIAL := xTabPa
      SF4->(FieldPut(xCount,_campo))
  Next
  */
Close(oDlg)

Return .t.