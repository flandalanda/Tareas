TITLE Ejercicio encontrar mayor temperatura

; Descripcion:
; 

INCLUDE \Users\Usuario\Documents\andrea\Irvine\Irvine32.inc
INCLUDELIB \Users\Usuario\Documents\andrea\Irvine\Irvine32.lib
INCLUDELIB \Users\Usuario\Documents\andrea\Irvine\User32.lib
INCLUDELIB \Users\Usuario\Documents\andrea\Irvine\Kernel32.lib

;SIMBOLOS
mcr=0dh
mlf=0ah
mnul=0h

.DATA
; PROC main
cadena BYTE 31 DUP(0)
lenCadena DWORD ?

txtString BYTE mcr,mlf,"String: ",mnul
txtRes BYTE mcr,mlf,"Conversion: ",mnul
adios BYTE mcr,mlf,"ADIOS.",mnul

; PROC Salarios, variables locales
dirRet DWORD ?
num SDWORD ?

; PROC Possal, variables locales
dirRet2 DWORD ?

txtCh1 BYTE mcr,mlf,"Caracter ",mnul
txtCh2 BYTE " : ",mnul
mayus BYTE " - MAYUSCULA", mnul
minus BYTE " - minuscula", mnul
noAlfa BYTE " - Char no alfa", mnul

dirRet3 DWORD ?

.CODE

main PROC 

    CALL Lectura
    MOV lenCadena, EAX
       
    CALL Analisis

    CALL Conversion
    
    EXIT
main ENDP

Lectura PROC
    POP dirRet

    MOV EDX, OFFSET txtString
    CALL WriteString
    
    MOV EDX, OFFSET cadena          ; guardar en la variable cadena
    MOV ECX, SIZEOF cadena          ; num max de caracteres
    CALL ReadString

    PUSH dirRet
    
    RET
Lectura ENDP

Analisis PROC
    POP dirRet2

    MOV ESI, OFFSET cadena
    MOV EBX, 1

    .WHILE EBX <= lenCadena

        MOV AL, [ESI]                       ; Mover el primer caracter
        
        MOV EDX, OFFSET txtCh1
        CALL WriteString
        CALL WriteChar
        MOV EDX, OFFSET txtCh2
        CALL WriteString

        AND AL, 60h
        .IF AL == 40h
            MOV EDX, OFFSET mayus
            MOV CH, [ESI]
            ADD CH, 20h
            MOV [ESI], CH
        .ELSEIF AL == 60h
            MOV EDX, OFFSET minus
            MOV CH, [ESI]
            SUB CH, 20h
            MOV [ESI], CH
        .ELSE
            MOV EDX, OFFSET noAlfa
        .ENDIF

        CALL WriteString
        CALL CrLf

        ADD ESI, 1
        INC EBX

    .ENDW

    PUSH dirRet2
    RET
Analisis ENDP

Conversion PROC
    POP dirRet3

    MOV EDX, OFFSET cadena
    CALL WriteString

    PUSH dirRet3

     
     RET
Conversion ENDP


END main
