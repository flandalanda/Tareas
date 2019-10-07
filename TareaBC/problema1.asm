TITLE *MASM Template	(cuarto4.asm)*

; Descripcion:
; Programa que implementa la expresión R = -A *9 - (B/D +1) + 100
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
A SDWORD 7
B SDWORD ?
D SDWORD -15
R SDWORD ?
Dato BYTE "Dato:",0
RespuestaDec BYTE "El resultado R =",0
RespuestaHex BYTE "El resultado Rh =",0

.CODE
; Procedimiento principal
main PROC

    MOV EDX, OFFSET Dato
    CALL WriteString
    CALL CrLf
    CALL ReadInt
    CALL CrLf
    MOV B,EAX ; Aquí empieza la operación

    CDQ              ; Extiende EAX a EDX   
    MOV EBX, D       ; Cargamos valor de D a EBX
    IDIV EBX         ; Hacemos la división EAX/EBX que corresponde a B/D
    INC EAX          ; Incrementamos EAX y tenemos B/D + 1
    NEG EAX          ; Negamos EAX para obtener -(B/D +1)
    XCHG EAX, EBX    ; Almacenamos el valor de -(B/D +1) en EBX
    MOV EAX, 9       ; Cargamos 9 a EAX
    NEG EAX          ; Convertimos a -9
    IMUL A           ; Hacemos el producto A * (-9) que debería dar -63
    ADD EAX, EBX     ; Hacemos la suma de -A*9 + (-((B/D) + 1))
    ADD EAX, 100
    MOV R, EAX
    MOV EDX, OFFSET RespuestaDec
    CALL WriteString
    CALL WriteInt
    CALL CrLf
    MOV EDX, OFFSET RespuestaHex
    CALL WriteString
    CALL WriteHex
    CALL CrLf
    MOV ESI, OFFSET A
    MOV ECX, 4
    MOV EBX, 4
    CALL DumpMem
    CALL CrLf

    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main