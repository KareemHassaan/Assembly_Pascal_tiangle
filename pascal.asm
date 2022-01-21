; project number (4) ----> ( pascal triangle )
;
; This code creidited to the team number __ 
;
; Author:
;              - Kareem Hassaan  
;              

; The code function is generating pascal triangle based on the number of rows enterd by the user

;----------------------------------------------------*******************************************----------------------------------------------

include emu8086.inc                           


org 100h 



DEFINE_SCAN_NUM                                 ;function declaration scaning the number from user and saved it in (CX).
DEFINE_PRINT_NUM_UNS                            ;function declaration printing unsigend-number from(AX).  





call  SCAN_NUM                                  ;scaning Rows number from the user   
                 
                  mov Rows_Nb, cx               ;save the value of Rows number saved in (CX) into (Rows_Nb)

  
Init_New_Row:                                   ;Label for initializing a new Row 

                  mov cx, Rows_Nb               ;save the new value of Rows number (Rows_Nb) into (CX) 
                  mov column_Index, cl          ;assign column_Index
                  mov input_fact_r, 0h          ;assign input_fact_r = 0 each new row , (r --> input of the combination_function)
                                               
                                               
Init_New_Coloumn:                               ;Label for initializing a new coloumn 
                 
                  mov bx, column_Nb             ;save the last coulmn num and the value of n for the factorial_and_combination_function
                  Gotoxy column_Index, bl       ;positioning function for the cursor 
                  mov dx, input_fact_r          ;save the new value of r for the combination_function  
                  
       
call compination_func 
call PRINT_NUM_UNS      
       
                  
                  mov dx, input_fact_r
        
                  inc input_fact_r              ;increment input_fact_r by one
                  inc column_Index              ;increment column_Index by one
                  inc column_Index              ;increment column_Index by one
        
                                               
                  cmp column_Nb, dx             ;comparing the column_Nb by (DX)
                  
jne Init_New_Coloumn                            ;If (ZF)=1 then column_Nb=(DX) continoue the code , else Init_New_Coloumn
   
                  inc column_Nb
                  dec Rows_Nb    
                                                
jnz Init_New_Row                                ;If (CX)=0 then Rows_Nb reached 0 continoue the code , else Init_New_Row

ret 



;factorial subrotine (n!) take its input (n) saved in (CX)  and the result saved in (AX) 

factorial_func    PROC 
    
                  cmp cx, 0                     ;comparing the input rows number from user to be not equal zero 

je single_row                                   ;if the zero flag (ZF)=1 --> (CX)=0 , then jump to single_row , else continoue. 
                 
                  mov ax,1h                     ;AX reg = 1 
                  mov si, dx                             

continoue:
                 
                  mul cx                        ;multpling the AX and CX 
                  dec cx                        ;decrement the CX by 1 

jne continoue                                   ;if the zero flag (CX)!=0 then jump to single_row , else continoue. 
                 
                  mov dx, si
ret
    
single_row:
                  mov ax, 1h                     ;AX reg = 1  
        
ret 
        
factorial_func    ENDP



;compination subrotine (nCr) take its inputs (n and r) saved in (BX and DX) respectivly and the result saved in (AX) 

compination_func  PROC
    
                  mov cx, bx                     ;save the value of n in the cx
call factorial_func                              ;calculate n!
                 
                  mov factorial_n, ax            ;save the result in factorial_n
    
                  mov cx, dx                     ;save the value of r in the cx
call factorial_func                              ;calculate r!
                  
                  mov factorial_r, ax            ;save the result in factorial_r
    
                  sub bx, dx                     ;calculate (n-r) where n --> bx and r --> dx and result --> bx
                  mov cx, bx                     ;save the value of (n-r) in the cx
call factorial_func                              ;calculate (n-r)!
                 
                  mov factorial_n_r, ax          ;save the result in factorial_n_r 
    
                  mov ax, factorial_n
                  cwd 
                  div factorial_n_r              ;AX divided by factorial_n_r result = n!/(n-r)!
                  cwd 
                  div factorial_r                ;AX divided by factorial_r result = n!/((n-r)!*r!)
           
ret                           

compination_func endp 


Rows_Nb       dw 0h                              ;Define word initialized zero for saving the rows number from user
column_Nb     dw 0h                              ;Define word initialized zero for saving the Last coloumn
column_Index  db 0h                              ;Define word initialized zero for saving the column_Index
                                           
input_fact_r  dw 0h                              ;Define word initialized zero for saving the value of r
                                                
factorial_n   dw 0h                              ;Define word initialized zero for saving the value of   n  !
factorial_r   dw 0h                              ;Define word initialized zero for saving the value of   r  !
factorial_n_r dw 0h                              ;Define word initialized zero for saving the value of (n-r)!
           
          
           END 


;----------------------------------------------------*******************************************----------------------------------------------                                