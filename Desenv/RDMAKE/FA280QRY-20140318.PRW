#INCLUDE "rwmake.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA280QRY  � Autor � Saulo Muniz        � Data �  18/11/04   ���
�������������������������������������������������������������������������͹��
���Descricao � Destinado a gravacao de dados complementares (especifico   ���
���          � Gefco) na rotina de substituicao Fatura Receber            ���
���          � ( FINA280 )                                                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP7 - Financeiro / Ctas Receber / Faturas Receber (FINA280)���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function FA280QRY
Local aArea:=GetArea()
Local aAreaSA1:=SA1->(GetArea())
//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
//  
Private cCusto := Space(10)
//_mOldArea	:=	Alias()
//_mOldInde	:=	IndexOrd()
//_mOldRecn	:=	Recno()
lRet := ""

// Verifica se existe portador - Saulo Muniz ( 18/07/06 )

lRet := " E1_PORTADO = '' "  
dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xFilial("SA1")+cCli+cLoja)

If SA1->A1_XLIBPG == "2"  //Libera mediante preenchimento do campo SE1->E1_XDTLIB
	lRet+=" AND E1_XDTLIB <> ' ' "
EndIf

//DbSelectArea(_mOldArea)
//DbSetOrder(_mOldInde)
//DbGoto(_mOldRecn)
RestArea(aAreaSA1)
RestArea(aArea)
Return lRet