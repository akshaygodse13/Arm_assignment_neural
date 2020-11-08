	 AREA     appcode, CODE, READONLY
     EXPORT __main
	 IMPORT printMsg1
     ENTRY 
__main  FUNCTION
	
; SIMPLE NEURAL NETWORK IMPLEMENTATION	
; FINAL OUTPUT IS STORED IN S8

	 VLDR.F32 S1,=1 ;S1 INITIALISED TO 1
	 VLDR.F32 S23,=0.5 ;S23 INITIALISED TO 0.5, USED AS THRESHOLD
	 MOV R4, #1	;TO INCREMENT
	 MOV R5, #0
	 MOV R7, #0		;R7 is used to know which logic you want to implement
	 BAL Switch
	 
Switch					; switch case 
		CMP R7,#0		;For AND Operation 
		BEQ logic_AND
		CMP R7,#1		;For OR Operation
		BEQ logic_OR
		CMP R7,#2		;For NOT Operation
		BEQ logic_NOT
		CMP R7,#3		;For NAND Operation
		BEQ logic_NAND
		CMP R7,#4		;For NOR Operation
		BEQ logic_NOR
		CMP R7,#5       ;For XOR Operation
		BEQ logic_XOR
		CMP R7,#6		;For XNOR Operation
		BEQ logic_XNOR
	
logic_AND
		VLDR.F32 S14,=-0.1  
		VLDR.F32 S11,=0.2
		VLDR.F32 S12,=0.2 
		VLDR.F32 S13,=-0.2
		CMP R5, #0
		BEQ NEXT
		CMP R5, #1
		BEQ NEXT1
		CMP R5, #2
		BEQ NEXT2
		CMP R5, #3
		BEQ NEXT3
		
logic_OR
		VLDR.F32 S14,=-0.1 
		VLDR.F32 S11,=0.7 
		VLDR.F32 S12,=0.7 
		VLDR.F32 S13,=-0.1 
		CMP R5, #0
		BEQ NEXT
		CMP R5, #1
		BEQ NEXT1
		CMP R5, #2
		BEQ NEXT2
		CMP R5, #3
		BEQ NEXT3
		
logic_NOT
		VLDR.F32 S14,=0.5 
		VLDR.F32 S11,=-0.7 
		VLDR.F32 S12,=0 
		VLDR.F32 S13,=0.1 
		CMP R5, #0
		BEQ NEXT
		CMP R5, #1
		BEQ NEXT1
		CMP R5, #2
		BEQ NEXT2
		CMP R5, #3
		BEQ NEXT3
		
logic_NAND
		VLDR.F32 S14,=0.6 
		VLDR.F32 S11,=-0.8 
		VLDR.F32 S12,=-0.8 
		VLDR.F32 S13,=0.3 
		CMP R5, #0
		BEQ NEXT
		CMP R5, #1
		BEQ NEXT1
		CMP R5, #2
		BEQ NEXT2
		CMP R5, #3
		BEQ NEXT3
		
logic_NOR
		VLDR.F32 S14,=0.5 
		VLDR.F32 S11,=-0.7 
		VLDR.F32 S12,=-0.7 
		VLDR.F32 S13,=0.1 
		CMP R5, #0
		BEQ NEXT
		CMP R5, #1
		BEQ NEXT1
		CMP R5, #2
		BEQ NEXT2
		CMP R5, #3
		BEQ NEXT3
		
logic_XOR		
		VLDR.F32 S14,=-5 
		VLDR.F32 S11,=20 
		VLDR.F32 S12,=10 
		VLDR.F32 S13,=1 
		CMP R5, #0
		BEQ NEXT
		CMP R5, #1
		BEQ NEXT1
		CMP R5, #2
		BEQ NEXT2
		CMP R5, #3
		BEQ NEXT3

logic_XNOR
		VLDR.F32 S14,=-5 
		VLDR.F32 S11,=20 
		VLDR.F32 S12,=10 
		VLDR.F32 S13,=1 
		CMP R5, #0
		BEQ NEXT
		CMP R5, #1
		BEQ NEXT1
		CMP R5, #2
		BEQ NEXT2
		CMP R5, #3
		BEQ NEXT3	
	
NEXT    ; INPUT VALUE IS LOADED i.e X1,X2,X3
		VLDR.F32 S15,=1 ; X1
		VLDR.F32 S16,=0 ; X2
		VLDR.F32 S17,=0 ; X3
		B OPERATION
		
NEXT1    ; INPUT VALUE IS LOADED i.e X1,X2,X3
		VLDR.F32 S15,=1 ; X1
		VLDR.F32 S16,=0 ; X2
		VLDR.F32 S17,=1 ; X3
		B OPERATION		
		
NEXT2    ; INPUT VALUE IS LOADED i.e X1,X2,X3
		VLDR.F32 S15,=1 ; X1
		VLDR.F32 S16,=1 ; X2
		VLDR.F32 S17,=0 ; X3
		B OPERATION
		
NEXT3    ; INPUT VALUE IS LOADED i.e X1,X2,X3
		VLDR.F32 S15,=1 ; X1
		VLDR.F32 S16,=1 ; X2
		VLDR.F32 S17,=1 ; X3
		B OPERATION
	
OPERATION
		VMUL.F32 S18,S15,S14 
		VMUL.F32 S19,S11,S16 
		VMUL.F32 S20,S12,S17 
		VADD.F32 S21,S19,S18 
		VADD.F32 S21,S21,S20 
		VADD.F32 S21,S21,S13 
		VMOV.F32 S10, S21    
		BL EXP		          ; Calling of e^x subroutine
		
		VADD.F S22,S4,S1 ; (1+e^x)
		VDIV.F S6,S4,S22 ; Value of Sigmoid function(e^x/(1+e^x)) is stored in S6
		VMOV.F S8,S6     
		VCMP.F S6,S23
		vmrs APSR_nzcv,FPSCR
		BLT LOGIC0
		BGT LOGIC1
FINAL
        MOV R1,R7
	    VCVT.U32.F32 S16,S16
	    VMOV R2,S16
	    VCVT.U32.F32 S17,S17
	    VMOV R3,S17 	    
		BL printMsg1  ; Calling of print function
		ADD R5,R5,R4
		CMP R5,#4
		BNE Switch
		MOV R5, #0
		ADD R7,R7,R4
		CMP R7,#5
		BNE Switch
		BEQ STOP
		
		
LOGIC0 LDR R0,= 0x00000000  
       B FINAL
	   ;BL printMsg1
	   
	   
LOGIC1 LDR R0,= 0x00000001
       B FINAL
; e^x IMPLEMENTATION STARTED
EXP	
	   VMOV.F S7,S10
	   VMOV.F S9,S10
	   LDR r8,= 0x00000001
       
       VMOV.F S0,S10
	   ;VCVT.F32.U32 S0,S0
	   LDR r1,= 0x00000030 ; No of iteration in r1	   
	   LDR r2,= 0x00000001 ; For factorial 
	   VLDR.F S4,= 1      ; For storing final result
       VLDR.F S5,= 1 ; For storing the result of Factorial
	   
loop     
       VMOV.F S7,S9
       CMP r8,r2
	   BNE pow
loop2
       VMOV.F S0,S7
       VDIV.F S3,S0,S5
	   VADD.F S4,S4,S3
	   LDR r8,= 0x00000001 
	   ADD r2,#0x00000001
	   VMOV.F S2,r2
	   VCVT.F32.U32 S2,S2
	   VMUL.F S5,S5,S2 
	   CMP r2,r1
       BNE loop
       BX lr
	  

      ; THIS LOOP FIND OUT X^n TERM
pow     
       VMUL.F S7,S7,S9  
	   ADD r8,#0x00000001
	   CMP r8,r2
	   BNE pow
	   BEQ loop2
	   
STOP B STOP ; stop program
     ENDFUNC
     END
