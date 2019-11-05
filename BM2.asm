TITLE Ejercicio suma de arreglo

; Descripcion:
; Ejemplo de uso de direccionamiento indirecto con operandos indirectos,
; en la suma de elementos de un arreglo.
; Todas las impresiones enteras se haran en Hexadecimal.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
; Variables
arr1 SDWORD 11, 10, 12, 14, 13, 10, 12
arr2 SDWORD 209, -131, -96, 160, -221, 85, -49
texto BYTE "El resulado de la suma es: ",0

; Variables SumaMulti
a1 DWORD ?
a2 DWORD ?
tam DWORD ?
retorno DWORD ?
termino BYTE "El siguiente termino a sumar es: ",0


.CODE
; Procedimiento principal
main PROC

    PUSH OFFSET arr1
    PUSH OFFSET arr2
    PUSH LENGTHOF arr1

    CALL SumaMulti

    POP EAX
    MOV EDX, OFFSET texto
    CALL WriteString
    CALL WriteInt
    

    exit
main ENDP
; Termina el procedimiento principal

SumaMulti PROC

    POP retorno
    POP tam
    POP a2
    POP a1

    MOV ESI, a1
    MOV EDI, a2
    MOV EBX, 0
    MOV ECX, 0

    .WHILE EBX < tam

        MOV EAX, SDWORD PTR [ESI]
        IMUL EAX, SDWORD PTR [EDI]

        ADD ECX, EAX

        MOV EDX, OFFSET termino
        CALL WriteString
        CALL WriteInt
        CALL CrLf

        MOV EAX, ECX
        CALL WriteInt
        CALL CrLf

        ADD ESI, 4
        ADD EDI, 4
        INC EBX

    .ENDW

    PUSH ECX
    PUSH retorno

    RET

SumaMulti ENDP

; Termina el area de Ensamble
END main