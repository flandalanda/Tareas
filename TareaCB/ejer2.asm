; Multiplicacion M*N           (ejer2.asm)
 

INCLUDE myIrvine.inc

.DATA
M DWORD ?
N DWORD ?
textoM BYTE "M: ",0
textoN BYTE "N: ",0
textoProd BYTE "Producto: ",0
adios BYTE "ADIOS",0

; Multi
retorno DWORD ?
textoPot BYTE "Potencia de 2, peso ",0
prod DWORD 0
baseM DWORD ?
multN DWORD ?

.code
main PROC

    MOV EDX, OFFSET textoM    ; Lectura de M
    CALL WriteString
    CALL ReadInt
    MOV M, EAX

    CALL CrLf          ; Lectura de N
    MOV EDX, OFFSET textoN
    CALL WriteString
    CALL ReadInt

    .IF EAX >= M
        XCHG EAX, M
    .ENDIF

    MOV N, EAX

    PUSH M
    PUSH N

    CALL Multi

    MOV EDX, OFFSET textoProd
    CALL WriteString

    POP EAX
    CALL WriteInt
    
    CALL CrLf
    MOV EDX, OFFSET adios
    CALL WriteString
	
	exit
main ENDP

;--------------------------------------------------------
Multi PROC
; DESCRIPCION:
;   Calcula la multiplicación de dos número N y M con N <= M.
; RECIBE:
; Por medio del stack,
;   los dos enteros, colocandolos en multN y baseM;
; REGRESA:
;   El producto entre los dos números.
;--------------------------------------------------------

    POP retorno
    POP multN
    POP baseM
    MOV ECX, 0


    .WHILE multN > 0

        SHR multN,1
        .IF( CARRY? )

            MOV EAX, baseM
            SHL EAX, CL
            ADD prod, EAX

            MOV EDX, OFFSET textoPot
            CALL WriteString
            MOV EAX, ECX
            CALL WriteInt
            CALL CrLf

        .ENDIF
        
        INC CL

    .ENDW
    MOV EAX, prod
    PUSH EAX

    PUSH retorno

	ret
Multi ENDP

;-----------------------------------------------------------

END main