; Multiplicacion M*N           (ejer2.asm)
 

INCLUDE myIrvine.inc

.DATA
dwrd DWORD ?
sdwrd SDWORD ?
texto1 BYTE "Introduzca un entero sin signo: ",0
texto2 BYTE "Introduzca un entero signado: ",0

; dwToStr


.code
main PROC
    
    MOV EDX, OFFSET texto1
    CALL WriteString
    CALL ReadInt
    MOV dwrd, EAX

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

;-----------------------------------------------------------

END main