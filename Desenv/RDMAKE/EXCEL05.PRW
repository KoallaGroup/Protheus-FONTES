#include "rwmake.ch"     

User Function EXCEL05()  

SetPrvt("V_PRODUTO,V_PRODUTO1,V_PRODUTO2,V_DT_DE,V_DT_ATE,PEDIDO")
SetPrvt("PEDIDO1,PEDIDO2,")

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � Excel01  � Autor � Saulo Muniz/Fabio     � Data � 29.03.06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Programa p/ gerar cal. da qtde. na planilha de logistica   ���
�������������������������������������������������������������������������Ĵ��
���Uso       �                                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

   v_Emissao := CTOD(Substr(PARAMIXB,1,2) + "/" + Substr(PARAMIXB,4,2) + "/" + Substr(PARAMIXB,7,4),"ddmmyyyy")    // DD/MM/AAAA
   v_Emissao2 := LastDay(v_Emissao)
   cUO := ""

  NQUANTRDVM := 0
  NQUANTILI := 0
  NQUANTRML := 0
  NQUANTRMA := 0
  NQUANT := 0
  

  DBSELECTAREA("SE1")
  //DBSETORDER(6)
  DBGOTOP()
  //DBSEEK("01"+v_Emissao,.T.)

     While !Eof() 

	  If SE1->E1_EMISSAO < v_Emissao .Or. SE1->E1_EMISSAO > v_Emissao2
	     DbSkip()
	     Loop
	  Endif
                                                 
                                                 
             NQUANT++
         
         cUO := SUBSTRING(SE1->E1_CCONT,2,2)         
       
         If cUO == "01" 
  	          NQUANTRDVM++
         ElseIF cUO == "11"
		      NQUANTRML++
         ElseIF cUO == "21"		    
 		      NQUANTILI++
		 ElseIF cUO == "22" 
    	      NQUANTRMA++
		 ElseIF cUO == "23"  	    
    	      NQUANTRMA++

         Endif
         
        DBSKIP()

     EndDo

                                
Return(NQUANTRMA)