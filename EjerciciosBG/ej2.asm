TITLE *MASM Template

; Descripcion:
; Uso de "Type" PTR
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
N SDWORD ?
M SDWORD ?
Error BYTE "Error: ",0
Respuesta BYTE "Producto ",0
Adios BYTE "Adios",0
Espacio BYTE " : ", 0
EspacioP BYTE "*",0
EspacioC BYTE ", ", 0
DatoN BYTE "Introduzca el dato N",0
DatoM BYTE "Introduzca el dato M",0


.CODE
;Procedimiento principal

main PROC   
    ; leer datos
    MOV EDX, OFFSET DatoN
    CALL WriteString
    CALL CrLf
    CALL ReadInt
    CALL CrLf
    MOV N, EAX

    MOV EDX, OFFSET DatoM
    CALL WriteString
    CALL CrLf
    CALL ReadInt
    CALL CrLf
    MOV M, EAX

    CMP EAX, 0
    JGE else1
        MOV EDX, OFFSET Error
        CALL WriteString
        CALL WriteInt                   ; imprime M
        MOV EDX, OFFSET EspacioC
        CALL WriteString
        MOV EAX, N
        CALL WriteInt
        CALL CrLf
        JMP finif1
    else1:
        MOV EAX, N
        CMP EAX, 0
        JGE else2
            MOV EDX, OFFSET Error
            CALL WriteString
            CALL WriteInt               ; imprime N
            MOV EDX, OFFSET EspacioC
            CALL WriteString
            MOV EAX, M
            CALL WriteInt
            CALL CrLf
            JMP finif2
        else2:
            MOV EBX, 1                  ; i = 1
            MOV ECX, 0                  ; total = 0

            CMP EAX, N   
            JG else3                    ; M <= N
                initWhile1:
                    CMP EBX, M          ; i <= M
                    JG endWhile1
                        ADD ECX, N
                        INC EBX
                        JMP initWhile1
                endWhile1:
                    JMP finif3
            else3:                      ; M > N
                initWhile2:
                    CMP EBX, N          ; i <= N
                    JG endWhile2
                        ADD ECX, M
                        INC EBX
                        JMP initWhile2
                endWhile2:
                    JMP finif3
            finif3:
                
                MOV EDX, OFFSET Respuesta
                CALL WriteString
                MOV EAX, M
                CALL WriteInt
                MOV EDX, OFFSET EspacioP
                CALL WriteString
                MOV EAX, N
                CALL WriteInt
                MOV EDX, OFFSET Espacio
                CALL WriteString
                MOV EAX, ECX
                CALL WriteInt
                CALL CrLf
        finif2:

    finif1:
        MOV EDX, OFFSET Adios
        CALL WriteString
        exit

    main ENDP

END main
                    
                
            
            

