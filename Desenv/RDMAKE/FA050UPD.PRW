#include "rwmake.ch"      

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    : FA050UPD � Autor : Saulo Muniz            � Data :23/06/05 ���
�������������������������������������������������������������������������Ĵ��
���Descricao : Programa para n�o Lan�ar com c.custo bloquados             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function FA050INC()    
Local aArea	:=	GetArea()
//vAlias := Alias()
xBloq  := " "
xOk    := .T.
xMens  := " "

DbSelectArea("SED")
DbSetOrder(1)
DbSeek(xFilial("SED")+M->E2_NATUREZ)
cConta := SED->ED_CONTA

DbSelectArea("CT1")
DbSetOrder(1)
DbSeek(xFilial("CT1")+cConta)
xObrg  := CT1->CT1_CCOBRG

DbSelectArea("CTT")
DbSetOrder(1)
DbSeek(xFilial("CTT")+M->E2_CCONT)
xBloq := CTT->CTT_BLOQ



 If xBloq == "1" // C.Custo Bloqueado 
    xOk   := .F.  
    xMens := "1"
 Endif 
 
 If Empty(cConta)
    xOk   := .F.  
    xMens := "2" 
 Endif

 If xObrg == "1" .AND. Empty(M->E2_CCONT) // 1= SIM ; 2 = N�O
    xOk   := .F.  
    xMens := "3" 
 Endif


 Do Case
     Case xMens == "1"
          ApMsgAlert("Centro de Custo Bloqueado ! ",'Aten��o !!!')  
     Case xMens == "2"
          ApMsgAlert("Conta cont�bil n�o encontrada ! ",'Aten��o !!!')  
     Case xMens == "3"
          ApMsgAlert("Centro de Custo Obrigat�rio ! ",'Aten��o !!!')  

 Endcase

*------------------------------------------------------------------------------------------------------------*
* Por: J Ricardo - Em: 14/09/2007                                                                            *
* Objetivo: Passar para a fun��o vldCntCC a Conta Contabil contido na tabela Natureza, em vez da Natureza.   *
*------------------------------------------------------------------------------------------------------------*
If xOk
	xOK:=u_vldCntCC(M->E2_CCONT,POSICIONE("SED",1,xFilial("SED")+M->E2_NATUREZ,"ED_CONTA"))
EndIf

//DbSelectArea(vAlias)
RestArea(aArea)
Return(xOk) 