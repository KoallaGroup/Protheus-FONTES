#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 18/10/00

User Function GEFL02()        // incluido pelo assistente de conversao do AP5 IDE em 18/10/00

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("VALIAS,CCONTA,CITEM,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴엽�
굇쿑uncao    : GEFL02  � Autor : Ronaldo Pena            � Data :17/09/99 낢�
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴눙�
굇쿏escricao : Posicionamento na conta para retorno do item               낢�
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

vAlias := Alias()

If     ParamIxb == 1
       DbSelectArea("SED")
       DbSetOrder(1)
       DbSeek(xFilial("SED")+SE1->E1_NATUREZ)
       cConta := SED->ED_CONTA
ElseIf ParamIxb == 2
       cConta := "812201"
ElseIf ParamIxb == 3
       cConta := "812202"
ElseIf ParamIxb == 4
       cConta := SED->ED_CONTA
ElseIf ParamIxb == 5
       cConta := "714199"
Endif


//DbSelectArea("SI1")
DbSelectArea("SI1")
DbSetOrder(1)
DbSeek(xFilial("SI1")+cConta)
cItem := SI1->I1_ITEM
DbSelectArea(vAlias)
// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> __Return(cItem)
Return(cItem)        // incluido pelo assistente de conversao do AP5 IDE em 18/10/00

