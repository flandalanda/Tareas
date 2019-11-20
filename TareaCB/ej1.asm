TITLE Ejercicio 1 CB       

; Demonstration of multi-doubleword shift, using
; SHR and RCR instructions.

INCLUDE myIrvine.inc


.DATA
array DWORD 8 DUP(0)
bitsDesp DWORD ?
lenArray DWORD ? 

txtDatos BYTE "DATOS", 0
txtDesp BYTE "Bits a desplazar: ", 0
txtRes BYTE "RESULTADOS", 0

;Variables del procedimiento leerElems
dirRet DWORD ?
txtDword BYTE "Dword ", 0
txtEspacio BYTE ": ", 0

.CODE
main PROC
    MOV EDX, OFFSET txtDatos        ; Leer número de elementos del arreglo
    CALL WriteString
    CALL CrLf
    CALL ReadInt
    MOV lenArray, EAX

    PUSH lenArray
    CALL leerElems

    MOV EDX, OFFSET txtDesp         ; Leer número de bits a desplazar
    CALL WriteString
    CALL ReadInt
    CALL CrLf
    MOV bitsDesp, EAX

    MOV EDX, OFFSET txtRes
    CALL WriteString
    CALL CrLf

    PUSH OFFSET array               ; Imprimir arreglo inicial
    PUSH lenArray
    CALL impArray


    PUSH bitsDesp                  ; Desplazar bits
    PUSH OFFSET array
    PUSH lenArray
    CALL desplazarBits



    EXIT
main ENDP

;-----------------------------------------------------------
leerElems PROC
; DESCRIPCION:
;   Lee n enteros del teclado y los guarda en un arreglo
; RECIBE:
;   Por medio del stack,
;   apuntador al arreglo donde se guardan los elementos en ESI
;   numero de elementos a leer en ECX
; REGRESA:
;   Nada.
;-----------------------------------------------------------
    POP dirRet
    POP ECX                 ; longitud del arreglo
    POP ESI                 ; apuntador del arreglo 

    MOV EBX, 0              ; contador

    .WHILE EBX < ECX
        MOV EDX, OFFSET txtDword
        CALL WriteString

        MOV EAX, EBX        ; Imprimir posición del arreglo
        INC EAX
        CALL WriteInt

        MOV EDX OFFSET txtEspacio
        CALL WriteString

        CALL ReadInt         ; leer valor a guardar
        MOV [ESI], EAX       ; guardar en el arreglo

        ADD EAX, TYPE DWORD

        CALL CrLf

        INC EBX
    .ENDW

    PUSH dirRet

    RET
leerElems ENDP


;-----------------------------------------------------------
desplazarBits PROC
; DESCRIPCION:
;   Lee n enteros del teclado y los guarda en un arreglo
; RECIBE:
;   Por medio del stack,
;   apuntador al arreglo donde se guardan los elementos en ESI
;   numero de elementos del arreglo en ECX
;   numero de bits a desplazar en EBX
; REGRESA:
;   Nada.
;-----------------------------------------------------------
    POP dirRet2
    POP ECX     
    POP ESI
    POP EBX
 
    MOV EDX, 0
    SHR [ESI + EDX], EBX

    INC EDX
    .WHILE EDX < ECX
        RCR [ESI + EDX], EBX 
    .ENDW


    EXIT
desplazarBits ENDP



;-----------------------------------------------------------
impArray PROC
; DESCRIPCION:
;   Lee n enteros del teclado y los guarda en un arreglo
; RECIBE:
;   Por medio del stack,
;   apuntador al arreglo donde se guardan los elementos en ESI
;   numero de elementos del arreglo en ECX
;   numero de bits a desplazar en EBX
; REGRESA:
;   Nada.
;-----------------------------------------------------------
    POP dirRet3
    POP ESI
    POP ECX

    MOV EBX, ECX
    MUL EBX, 4
    ADD ESI, EBX

    .WHILE ECX > 0
        MOV EAX, [ESI]
        Call WriteHex

        SUB ESI, TYPE DWORD

        INC 
    .ENDW
impArray ENDP

END main