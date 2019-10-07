TITLE *MASM Template	(problema2.asm)*

; Descripcion:
; Impresión de vectores de valores enteros
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA

Svector WORD 2002h, 4004h, 6006h, 8008h
Cvector SWORD -2, -4, -6, -8
Texto1 BYTE "SVECTOR",0
Texto2 BYTE "CVECTOR",0
Producto BYTE "Producto:",0

.CODE
; Procedimiento principal
main PROC
    
    MOV EDX, OFFSET Texto1
    CALL WriteString
    
    MOVZX EAX, Svector       ; Movemos primer elemento del Svector a EAX rellenando con ceros
    MOVZX EBX, Svector + 2   ; Movemos segundo elemento del Svector a EBX rellenando con ceros
    MOVZX ECX, Svector + 4   ; Movemos tercer elemento del Svector a ECX rellenando con ceros
    MOVZX EDX, Svector + 6   ; Movemos cuarto elemento del Svector a EDX rellenando con ceros

    CALL DumpRegs

    MOV EDX, OFFSET Texto2
    CALL WriteString

    MOVSX EAX, Cvector       ; Movemos primer elemento del Cvector a EAX preservando signo
    MOVSX EBX, Cvector + 2   ; Movemos segundo elemento del Cvector a EBX preservando signo
    MOVSX ECX, Cvector + 4   ; Movemos tercer elemento del Cvector a ECX preservando signo
    MOVSX EDX, Cvector + 6   ; Movemos cuarto elemento del Cvector a EDX preservando signo

    CALL DumpRegs

    MOV EDX, OFFSET Producto
    CALL WriteString
    
    MOVZX EAX, Svector       ; Movemos el primer elemento del Svector a EAX rellenando con ceros
    MOVSX EBX, Cvector       ; Movemos el primer elemento del Cvector a EBX preservando signo
    IMUL EBX                 ; Hacemos el producto signado de EAX con EBX
    XCHG EAX, EDX            ; Almacenamos la parte alta del producto a EAX
    CALL WriteHex            ; Imprimimos la parte alta del producto
    XCHG EAX, EDX            ; Almacenamos la parte baja del producto a EAX
    CALL WriteHex            ; Imprimimos la parte baja del producto

    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main