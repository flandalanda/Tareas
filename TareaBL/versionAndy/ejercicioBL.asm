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
total SDWORD ?

txtN BYTE mcr,mlf,"Teclee el dato n: ",mnul
txtRes BYTE mcr,mlf,"Resultado: ",mnul
adios BYTE mcr,mlf,"ADIOS.",mnul

; PROC Salarios, variables locales
dirRet DWORD ?
num SDWORD ?

; PROC Possal, variables locales
dirRet2 DWORD ?
;cont DWORD ?
txtSal1 BYTE mcr,mlf,"Teclee el ",mnul
txtSal2 BYTE " salario: ",mnul


.CODE

main PROC 
    MOV EDX, OFFSET txtN
    CALL WriteString
    CALL ReadInt
    
    PUSH EAX                    ; Guardo N en la pila
    CALL Salarios               ; Mando a llamar al proceso Salarios

    POP total

    MOV EDX, OFFSET txtRes
    CALL WriteString
    MOV EAX, total
    CALL WriteInt
    CALL CrLf

    MOV EDX, OFFSET adios
    CALL WriteString
    

    EXIT
main ENDP

Salarios PROC
    POP dirRet
    POP num                     ; Guardo el numero de salarios

    MOV EBX, 1                  ; Inicializar contador
    MOV ECX, 0                  ; Inicializar variable para la suma

    .WHILE EBX <= num
        PUSH EBX
        CALL Possal

        CALL ReadInt            ; Leer valor del salario
        ADD ECX, EAX

        INC EBX
    .ENDW

    PUSH ECX                    ; Regreso la suma
    PUSH dirRet                 ; Direccion de regreso
        
    RET
Salarios ENDP

Possal PROC
     POP dirRet2
     POP EAX

     ;MOV DH, 08h
     ;MOV DL, 12h
     ;CALL Gotoxy

     MOV EDX, OFFSET txtSal1
     CALL WriteString
     CALL WriteInt
     MOV EDX, OFFSET txtSal2
     CALL WriteString

     PUSH dirRet2
     
     RET
Possal ENDP

END main
