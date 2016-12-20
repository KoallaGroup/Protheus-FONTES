#include "rwmake.ch"   

User Function Gefl99() 


SetPrvt("VALIAS,CCONTA,")

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    : GEFL99  � Autor : Saulo Muniz            � Data :27/06/05 ���
�������������������������������������������������������������������������Ĵ��
���Descricao : Posicionamento da natureza para Lancamento Padrao 500      ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

vAlias := Alias()

DbSelectArea("SI3")
DbSetOrder(1)
DbSeek(xFilial("SI3")+SE1->E1_CCONT)
cConta := SI3->I3_DEB

DbSelectArea(vAlias)

Return(cConta)       
