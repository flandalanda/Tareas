; Multiplicacion M*N           (ejer2.asm)
 

INCLUDE myIrvine.inc

.DATA
dwrd DWORD ?
sdwrd SDWORD ?
texto1 BYTE "Introduzca un entero sin signo: ",0
texto2 BYTE "Introduzca un entero signado: ",0

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
    CALL ReadInt
    MOV dwrd, EAX

    PUSH dwrd
    PUSH OFFSET strDWord
    CALL dwToStr



    MOV EDX, OFFSET texto2
    CALL WriteString
    CALL ReadInt
    MOV sdwrd, EAX
	
	exit
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
    POP ESI                 ; apuntador buffer string
    POP EAX                 ; valor del SDWORD

    .IF PTR SDWORD EAX < 0
        MOV [ESI], "+"
    .ELSE 
        MOV [ESI], "-"
    .ENDIF

    MOV EBX, 1

    .WHILE PTR SDWORD EAX != 0

        CALL WriteHexB
        SHR EAX, 8

    .ENDW 
        
    ret
sdwToStr ENDP

;-----------------------------------------------------------

END main