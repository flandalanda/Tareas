; Conversión decimal a hexa con ascii           (ejer3.asm)
 

INCLUDE myIrvine.inc

.DATA
textoIntro BYTE "Entero 32 bits: ",0
textoFin BYTE "El equivalente Hex a 32 bits es: ",0
adios BYTE "ADIOS",0

; Conversión
cadena BYTE 9 DUP(?)
retorno DWORD ?

.code
main PROC

    MOV EDX, OFFSET textoIntro
    CALL WriteString
    CALL ReadInt

    PUSH EAX

    CALL Conversion

    MOV EDX, OFFSET textoFin
    CALL WriteString
    POP EDX
    CALL WriteString
    MOV EDX, OFFSET adios
    CALL CrLf
    CALL WriteString
    	
	exit
main ENDP

;--------------------------------------------------------
Conversion PROC
; DESCRIPCION:
;   Calcula la cadena de caracteres correspondientes al número decimal leído en hexadecimal.
; RECIBE:
; Por medio del stack,
;   el número a convertir;
; REGRESA:
;   cadena de caracteres correspondientes a la conversión de decimal a hexadecimal.
;--------------------------------------------------------
    POP retorno
    POP EAX


    MOV ESI, 0


    .WHILE ESI < 8

        MOV ECX, 30h
        MOV EBX, 0
        SHLD EBX, EAX, 4
        SHL EAX, 4

        .IF EBX < 10
            ADD ECX, EBX
        .ELSE
            ADD ECX, 7
            ADD ECX, EBX
        .ENDIF

        MOV cadena[ESI], CL
        INC ESI 

    .ENDW

    MOV cadena[ESI], 0

    PUSH OFFSET cadena
    PUSH retorno
    
	ret
Conversion ENDP

;-----------------------------------------------------------

END main