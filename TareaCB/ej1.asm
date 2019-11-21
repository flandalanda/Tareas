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

dirRet2 DWORD ?
dirRet3 DWORD ?

n DWORD ?

.CODE
main PROC
    MOV EDX, OFFSET txtDatos        ; Leer n√∫mero de elementos del arreglo
    CALL WriteString
    CALL CrLf
    CALL ReadInt
    MOV lenArray, EAX
 
    PUSH OFFSET array
    PUSH lenArray
    CALL leerElems

    MOV EDX, OFFSET txtDesp         ; Leer n√∫mero de bits a desplazar
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

                      
    PUSH bitsDesp                   ; Desplazar bits
    PUSH lenArray
    PUSH OFFSET array
    CALL desplazarBits

    PUSH OFFSET array               ; Imprimir arreglo inicial
    PUSH lenArray
    CALL impArray



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

        MOV EAX, EBX        ; Imprimir posici√≥n del arreglo
        INC EAX
        CALL WriteInt

        MOV EDX, OFFSET txtEspacio
        CALL WriteString

        CALL ReadHex         ; leer valor a guardar
        MOV DWORD PTR [ESI], EAX       ; guardar en el arreglo

        ADD ESI, TYPE DWORD

        CALL CrLf

        INC EBX
    .ENDW
    MOV ESI, OFFSET array
    MOV ECX, lenArray
    MOV EBX, 4

    PUSH dirRet

    RET
leerElems ENDP


;-----------------------------------------------------------
; desplazarBits(arreglo, numEl, n)
; Recibe:
;   arreglo - offset de arreglo a desplazar
;   numEl - numero de elementos en el arreglo
;   n - numero de bits de desplazamiento
; Regresa:
; Requiere N/A
;
desplazarBits PROC
    POP dirRet2
    POP ESI           ; OFFSET de arreglo
    POP EBX           ; tamaÒo de arreglo
    POP n             ; n˙mero de shifts

    MOV ECX, 1

    .WHILE (ECX <= n)
        MOV EAX, 1
        SHR DWORD PTR [ESI], 1
        PUSHF                                                   ; Es necesario hacer esto con las banderas porque las macros las modifican
            .REPEAT
                POPF                                            ; Es necesario hacer esto con las banderas porque las macros las modifican
                RCR DWORD PTR [ESI + EAX * 4], 1
                PUSHF                                           ; Es necesario hacer esto con las banderas porque las macros las modifican
                INC EAX
            .UNTIL EAX == EBX
        INC ECX
    .ENDW
    PUSH dirRet2
    RET
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
    POP ECX
    POP ESI

    MOV EBX, ECX
    DEC EBX
    IMUL EBX, TYPE DWORD
    ADD ESI, EBX

    .WHILE ECX > 0
        MOV EAX, [ESI]
        Call WriteBin
        CALL CrLf

        SUB ESI, 4

        DEC ECX
    .ENDW
    CALL CrLf
    PUSH dirRet3
    RET
impArray ENDP

END main