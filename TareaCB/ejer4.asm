; Multiplicacion M*N           (ejer2.asm)
 
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

;INCLUDE myIrvine.inc

.DATA
dwrd DWORD ?
sdwrd SDWORD ?
texto1 BYTE "Introduzca un entero sin signo: ",0
texto2 BYTE "Introduzca un entero signado: ",0

txtRes BYTE "RESULTADO", 0
txtSigno BYTE "Cadena con signo: ", 0
txtUnsig BYTE "Cadena sin signo: ", 0

strDword BYTE 10 DUP(?),0
strSDword BYTE 11 DUP(?),0

; dwToStr
dirRet DWORD ?


; sdwToStr
dirRet2 DWORD ?

.code
main PROC
    
    MOV EDX, OFFSET texto1
    CALL WriteString
    CALL ReadDec                    ; Lee numero sin signo
    MOV dwrd, EAX

    PUSH dwrd
    PUSH OFFSET strDWord
    CALL dwToStr

    MOV EDX, OFFSET texto2
    CALL WriteString
    CALL ReadInt                    ; Lee numero signado
    MOV sdwrd, EAX

    PUSH sdwrd
    PUSH OFFSET strSDWord
    CALL sdwToStr


    CALL CrLf                       ; Resultados

    MOV EDX, OFFSET txtRes
    CALL WriteString
    CALL CrLf

    MOV EDX, OFFSET txtUnsig
    CALL WriteString
    MOV EDX, OFFSET strDWord
    CALL WriteString 
    CALL CrLF

    MOV EDX, OFFSET txtSigno
    CALL WriteString
    MOV EDX, OFFSET strSDWord
    CALL WriteString 
    CALL CrLf

    EXIT
main ENDP

;--------------------------------------------------------
dwToStr PROC
; DESCRIPCION:
;   Convierte DWORD a cadena de caracteres que representan al número introducido.
; RECIBE:
; Por medio del stack,
;   el valor de la DWORD y la dirección inicial del buffer donde quedará la cadena;
; REGRESA:
;   Nada.
;--------------------------------------------------------
    POP dirRet
    POP ESI                 ; apuntador buffer string
    POP EAX                 ; valor del DWORD

    MOV EBX, 10             ; Dividir entre 10
    MOV ECX, 0              ; número de digitos

    .WHILE DWORD PTR EAX != 0
        
        MOV EDX, 0
        DIV EBX

        ADD EDX, 48         ; convertimos el digito a su expresion en ASCII
        
        MOV BYTE PTR [ESI], DL
        
        .IF DWORD PTR EAX != 0
            MOV EDX, ECX

            .WHILE SDWORD PTR EDX >= 0
                SHL WORD PTR [ESI + EDX], 8
                DEC EDX
            .ENDW

        .ENDIF


        INC ECX
    .ENDW 


    PUSH dirRet
        
    ret

    

    ret
dwToStr ENDP

;--------------------------------------------------------
sdwToStr PROC
; DESCRIPCION:
;   Convierte SDWORD a cadena de caracteres que representan al número introducido.
; RECIBE:
; Por medio del stack,
;   el valor de la SDWORD y la dirección inicial del buffer donde quedará la cadena;
; REGRESA:
;   Nada.
;--------------------------------------------------------
    POP dirRet2
    POP ESI                         ; apuntador buffer string
    POP EAX                         ; valor del SDWORD

    .IF SDWORD PTR EAX < 0
        MOV BYTE PTR [ESI], "-"     
        NEG EAX                     ; Si es negativo lo volvemos positivo para trabajar con los dígitos   
    .ELSE 
        MOV BYTE PTR [ESI], "+"
    .ENDIF

    INC ESI

    MOV EBX, 10             ; Dividir entre 10

    MOV ECX, 0              ; número de digitos

    .WHILE SDWORD PTR EAX != 0
        MOV EDX, 0
        IDIV EBX

        ADD EDX, 48         ; ultimo digito es el residuo de la division
        
        MOV BYTE PTR [ESI], DL  
        
        .IF SDWORD PTR EAX != 0
            MOV EDX, ECX

            .WHILE SDWORD PTR EDX >= 0
                SHL WORD PTR [ESI + EDX], 8
                DEC EDX
            .ENDW

        .ENDIF


        INC ECX
    .ENDW 


    PUSH dirRet2
        
    ret
sdwToStr ENDP

;-----------------------------------------------------------

END main