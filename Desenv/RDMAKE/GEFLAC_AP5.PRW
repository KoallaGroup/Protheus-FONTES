#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 18/10/00

User Function GEFLAC()        // incluido pelo assistente de conversao do AP5 IDE em 18/10/00

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//�����������������������������������������������������������������������

SetPrvt("VALIAS,CVALOR,")

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    : GEFL04  � Autor : PEDRO ABREU             � Data :26/11/99 ���
�������������������������������������������������������������������������Ĵ��
���Descricao : Posicionamento da natureza para Lancamento Padrao 510      ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

vAlias := Alias()
DbSelectArea("SE2")
//DbSetOrder(1)
//DbSeek(xFilial("SE2")+SE2->E2_NATUREZ)
//CVALOR := SE2->E2_VALOR+SE2->E2_IRRF+SE2->E2_INSS+SE2->E2_ISS+SE2->E2_PIS+SE2->E2_COFINS+SE2->E2_CSLL    

CVALOR := (SE2->E2_VLCRUZ+SE2->E2_IRRF+SE2->E2_INSS+SE2->E2_ISS+SE2->E2_VRETPIS+SE2->E2_VRETCOF+SE2->E2_VRETCSLL);
           - SE2->E2_XVLRND - SE2->E2_XVLRFRT

DbSelectArea(vAlias)
// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> __Return(cConta)
Return(CVALOR)        // incluido pelo assistente de conversao do AP5 IDE em 18/10/00