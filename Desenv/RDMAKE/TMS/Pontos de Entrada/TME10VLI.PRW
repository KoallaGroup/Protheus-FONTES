#INCLUDE "PROTHEUS.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TME10VLI �Autor  �  Valdemar Roberto  � Data �  12.07.07   ���
�������������������������������������������������������������������������͹��
���Descricao � Valida a gravacao do registro cujo alias nao � o principal ���
�������������������������������������������������������������������������͹��
���Parametros� Nao se aplica                                              ���
�������������������������������������������������������������������������͹��
���Retorno   � Nao se aplica.                                             ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������͹��
���Analista  �Data    �Bops  �Manutencao Efetuada                      	  ���
���          �        �      �                                         	  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function TME10VLI()

Local aArea    := GetArea()
Local aAreaSA1 := SA1->(GetArea())
Local aAreaDE5 := DE5->(GetArea())
Local aAreaDUO := DUO->(GetArea())
Local aCampos  := PARAMIXB[1] //-- Vetor com os campos que serao gravados
Local cTipReg  := PARAMIXB[2] //-- Tipo de registro
Local lRet     := .F.
Local nCntFor1 := 0
Local nPosCon  := 0
Local nPosDpc  := 0
Local nPosDev  := 0
Local nPosTNF  := 0

If (nPosChv := Ascan(aCampos,{|x| AllTrim(x[2]) == "A1_CGC"})) > 0
	SA1->(DbSetOrder(3))
	IF !(SA1->(MsSeek(xFilial("SA1") + aCampos[nPosChv,3]))) //Se o cliente existir n�o altera
		lRet := .T.
	EndIf
EndIf

DUO->(RestArea(aAreaDUO))
DE5->(RestArea(aAreaDE5))
SA1->(RestArea(aAreaSA1))
RestArea(aArea)

Return lRet