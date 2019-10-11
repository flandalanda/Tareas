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
Error BYTE "No definido ",0
Respuesta BYTE "(",0
Adios BYTE "Adios",0
Espacio BYTE ")!: ", 0
DatoN BYTE "Introduzca el dato N",0


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

    CMP EAX, 0
    JGE else1
        MOV EDX, OFFSET Respuesta
        CALL WriteString
        CALL WriteInt
        MOV EDX, OFFSET Espacio
        CALL WriteString
        MOV EDX, OFFSET Error
        CALL WriteString
        CALL CrLf
        JMP endif1
    else1:
        ;CMP EAX, 0
        MOV EAX, 1                      ; total = 1
        JNE else2                       ; N == 0
            ;MOV ECX, 1
            JMP endif2
        else2:                          ; N > 0
            MOV EBX, 1
            initWhile:
                CMP EBX, N              ; i <= N
                JG endWhile
                    MUL EBX
                    INC EBX
                JMP initWhile
            endWhile:
                MOV ECX, EAX
        endif2:
            MOV EDX, OFFSET Respuesta
            CALL WriteString
            MOV EAX, N
            CALL WriteInt
            MOV EDX, OFFSET Espacio
            CALL WriteString
            MOV EAX, ECX
            CALL WriteInt
            CALL CrLf
    endif1:
        MOV EDX, OFFSET Adios
        CALL WriteString
        exit

    main ENDP

END main
                    
                
            
            

