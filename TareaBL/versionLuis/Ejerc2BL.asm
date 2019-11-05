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
textoA BYTE "Adios",0


; PROC Lectura
MAX = 31
stringIn BYTE MAX + 1 DUP (?)
texto BYTE "String: ", 0
retornoL DWORD ?

; PROC Impresion
MAYUS BYTE "MAYUSCULA",0
minus BYTE "minuscula",0
textoImp BYTE "Caracter ",0
textoO BYTE "o: ",0
textoG BYTE " - ",0
textoNo BYTE "Char no alfa.",0
retornoI DWORD ?
string DWORD ?
tam DWORD ?

; PROC Conversion
string2 DWORD ?
tam2 DWORD ?
textoC BYTE "Conversion: ", 0
retornoC DWORD ?

.CODE
main PROC

    
    CALL Lectura

    CALL Impresion

    CALL Conversion
            
    EXIT
main ENDP

Lectura PROC

    POP retornoL
    
    MOV EDX, OFFSET texto
    CALL WriteString
    MOV EDX, OFFSET stringIn
    MOV ECX, MAX
    CALL ReadString

    PUSH OFFSET stringIn
    PUSH EAX
    PUSH retornoL

    RET

Lectura ENDP

Impresion PROC

    POP retornoI
    POP tam
    POP string

    MOV EBX, 0
    MOV AL, 31h
    MOV AH, 30h

    MOV ESI, string

    .WHILE EBX < tam
        MOV EDX, OFFSET textoImp
        CALL WriteString

        .IF AL == 3Ah
            INC AH
            MOV AL, 30h
        .ENDIF

        .IF AH == 30h
            CALL WriteChar
        .ELSE
            XCHG AH, AL
            CALL WriteChar
            XCHG AH, AL
            CALL WriteChar
        .ENDIF

        MOV EDX, OFFSET textoO
        CALL WriteString


        MOV CL, AL

        MOV AL, BYTE PTR [ESI]
        CALL WriteChar

        INC ESI

        MOV EDX, OFFSET textoG
        CALL WriteString

        .IF AL > 60h && AL < 7Bh
            MOV EDX, OFFSET minus
            CALL WriteString
        .ELSEIF AL > 40h && AL < 5Bh
            MOV EDX, OFFSET MAYUS
            CALL WriteString
        .ELSE
            MOV EDX, OFFSET textoNo
            CALL WriteString
        .ENDIF

        CALL CrLf

        MOV AL, CL
        
        INC AL
        ADD EBX, 1
    .ENDW

    PUSH string

    PUSH tam
    
    PUSH retornoI

    RET

Impresion ENDP

Conversion PROC

    POP retornoC
    POP tam2

    POP [string2]

    MOV ESI, string2
    MOV EBX, 0

    MOV EDX, OFFSET textoC
    CALL WriteString

    .WHILE EBX < tam2

        MOV AL, BYTE PTR [ESI]

        .IF (AL > 60h && AL < 7Bh) || (AL > 40h && AL < 5Bh)        
             XOR AL, 20h
        .ENDIF

        CALL WriteChar
        INC ESI
        INC EBX

     
    .ENDW

    PUSH retornoC
    RET
    

Conversion ENDP


END main