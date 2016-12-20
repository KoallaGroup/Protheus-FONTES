#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 18/10/00

User Function GEFM08()        // incluido pelo assistente de conversao do AP5 IDE em 18/10/00

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//�����������������������������������������������������������������������

SetPrvt("CCADASTRO,AROTINA,")

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    : GEFM08  � Autor : SAULO                   � Data :18/08/00 ���
�������������������������������������������������������������������������Ĵ��
���Descricao : Programa pesquisa de titulos (pagar)                       ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

DbSelectArea("SE2")
DBSETORDER(10)

cCadastro := "Pesquisar por Valores"

aRotina   := {{"Visualizar" ,'Axvisual'                     ,0,2},;
              {"Pesq. Valor",'ExecBlock("GEFM08A",.F.,.F.)' ,0,5}}

MBrowse(006,001,022,075,"SE2")

Return