TITLE Program Template          (OpArrArg.asm)

; Este programa llama un procedimiento con pasaje por stack.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
; PROC main
n DWORD ?
intro BYTE "Tecle el dato n: ",0
res BYTE "Resultado: ",0
adios BYTE "Adios",0


; PROC Salarios, variables locales
numSal DWORD ?
suma DWORD 0
retornoS DWORD ?

; PROC Possal, variables local
texto1 BYTE "Teclee el ",0
texto2 BYTE " salario: ",0
indice DWORD ?
retornoP DWORD ?

.CODE
main PROC

    CALL Clrscr
    MOV DX, 080Eh
    CALL Gotoxy
    MOV EDX, OFFSET intro
    CALL WriteString
    CALL ReadInt
    MOV n, EAX
    PUSH n
    CALL Salarios

    INC n

    MOV EDX, 080Eh
    XCHG DL, DH
    ADD EDX, n
    XCHG DL, DH

    CALL Gotoxy


    MOV EDX, OFFSET res
    CALL WriteString
    POP EAX
    CALL WriteInt
    CALL Crlf

    INC n

    MOV EDX, 080Eh
    XCHG DL, DH
    ADD EDX, n
    XCHG DL, DH

    CALL Gotoxy

    MOV EDX, OFFSET adios
    CALL WriteString
    
    EXIT
main ENDP

Salarios PROC
; Salarios(numSal)
; Pide numSal número de salarios y calcula su suma.
; Recibe
;     Stack: numSal
; Regresa
;     Stack: suma	
; Varibles automaticas y locales

;   Argumentos o parametros pasados

    POP retornoS
    POP numSal

    MOV EBX, 1
    .WHILE EBX <= numSal

        PUSH EBX
        CALL Possal
        CALL ReadInt
        ADD suma, EAX
        INC EBX
        
    .ENDW

    PUSH suma
    PUSH retornoS
	
    RET
Salarios ENDP

Possal PROC

    POP retornoP
    POP indice

    MOV EDX, 080Eh
    XCHG DL, DH
    ADD EDX, indice
    XCHG DL, DH

    CALL Gotoxy


    MOV EDX, OFFSET texto1
    CALL WriteString
    MOV EAX, indice
    CALL WriteInt
    MOV EDX, OFFSET texto2
    CALL WriteString

    PUSH retornoP

    RET
Possal ENDP

END main