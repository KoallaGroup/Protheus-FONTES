#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �F280NFT   � Autor � J Ricardo Guimar�es   � Data � 10.09.13 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Ponto de Entrada disparado na rotina de gara��o de fatura    ��
���          �a receber, com o intuito de n�o deixar editar o campo       ���
���          �N�mero de Fatura                                            ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       �                                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
����������������������������������������������������������������������������*/

User Function F280NFT() 
Local lBlqFat := paramixb[1]
If lBlqFat
	lBlqFat := .F.
Else
	lBlqFat := .T.
EndIF
	
Return lBlqFat