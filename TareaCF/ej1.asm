TITLE Ejercicio 1 CF      

; Demonstration of multi-doubleword shift, using
; SHR and RCR instructions.

INCLUDE myIrvine.inc


.DATA
RA REAL8 2.0
SB REAL8 3.0
TC REAL8 -2.0
UD REAL8 10.0
VE REAL8 15.0

infix BYTE "La expresion infix es: (RA + SB)/TC * UD – RA + VE ",0 ; = 17
postfix BYTE "La expresion postfix es: RA SB + TC / UD * RA - VE +",0
res BYTE "EL resultado de la operacion es: ", 0
adios BYTE "ADIOS", 0

.CODE
main PROC
    FINIT               ; incializar FPU

    ; guardar variables en el stack                
    FLD VE
    FLD RA
    FLD UD
    FLD TC
    FLD SB
    FLD RA

    MOV EDX, OFFSET infix
    CALL WriteString
    CALL CrLf  

    MOV EDX, OFFSET postfix
    CALL WriteString
    CALL CrLf   

    FADD                    ; RA + SB
    FDIV ST(0), ST(1)       ; (RA+SB)/TC
    FMUL ST(0), ST(2)
    FSUB ST(0), ST(3)
    FADD ST(0), ST(4)

    MOV EDX, OFFSET res
    CALL WriteString
    CALL WriteFloat
    CALL CrLf

    CALL ShowFPUStack

    FINIT

    CALL ShowFPUStack

    MOV EDX, OFFSET adios
    CALL WriteString
    CALL CrLf
    
main ENDP
END main