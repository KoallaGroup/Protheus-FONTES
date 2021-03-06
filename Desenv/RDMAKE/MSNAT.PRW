#include "rwmake.ch"    

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �   MSNAT    � Autor �    Saulo Muniz      � Data � 13.10.06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Define a natureza a ser usada no pedido de vendas           ���
���          �                                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

// Implementada nova regra definida para o ILI - Saulo Muniz 18/10/06

User Function MSNAT()  
Local _aArea := GetArea()

Private _cCusto
Private xUo
Private xNatur
Private xAtvFim
Private xAtvRma
Private xAtvRdvm
Private Resposta

_cCusto := SC5->C5_CCUSTO
xNatur  := ""                              

DbSelectArea("CTT")  // Atualizado para CTB
DbSetOrder(1)	
DbGotop()			
DbSeek(xFilial("CTT")+_cCusto)

xUo      := Substr(Alltrim(_cCusto),2,2)
xAtvFim  := Substr(Alltrim(_cCusto),7,3) 

If CTT->CTT_BLOQ == "1"
   MsgInfo("Centro de custo bloqueado !")
Endif        

If Substr(_cCusto,10,1) == "7" 
   MsgInfo("Centro de custo Intercentro n�o permitido !")
Endif        
 
///////////////////////////////
// Opera��es Fretes Normais  //
///////////////////////////////

//As naturezas utilizadas nesta rotina de faturamento iniciar�o com '6'.
Do Case            

   Case xUo $("01|02")    // Rdvm               
        xNatur := "600" 

   Case xUo $("22|23")    // Rma
        xNatur := "601"     

   Case xUo == "11"       // Rmlap               
        xNatur := "604"               

   Case xUo $("21")       // ILI  
        xNatur := "606"     

   Otherwise
        xNatur := "607"   // Natureza com conta transitoria 

EndCase
	        	            
////////////////////////
// Opera��es Isentas  //
////////////////////////////////////////////////////
// Tratamento de Frete Rma , Rdvm e Rmlap isento  //          
////////////////////////////////////////////////////            
xAtvRma   := "402|404|406|503|504|506|508"            
xAtvRdvm  := "003|004|006|008|012|016"
	            
If xUo $("22|23") .And. xAtvFim $(xAtvRma)   //Rma                
   xNatur := "602"                 
Endif

If xUo $("01|02") .And. xAtvFim $(xAtvRdvm)    //Rdvm
   xNatur := "603"           
Endif	        

If Empty(xNatur)
   MsgInfo("Natureza n�o encontrada !")
Endif                                   

MaFisAlt("NF_NATUREZA",xNatur)

RestArea(_aArea)       
Return(xNatur)