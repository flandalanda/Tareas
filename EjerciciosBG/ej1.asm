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
Error BYTE "Error, numero invalido: ",0
Respuesta BYTE "Suma total serie:",0
Adios BYTE "Adios",0
Termino BYTE "Termino ",0
Espacio BYTE " : ", 0
Dato BYTE "Introduzca el dato",0

.CODE
;Procedimiento principal

main PROC   
    MOV EDX, OFFSET Dato
    CALL WriteString
    CALL CrLf
    CALL ReadInt
    CALL CrLf
    MOV N, EAX

    
    CMP EAX, i
    JGE else1
        MOV EDX, OFFSET Error
        CALL WriteString
        CALL WriteInt
        CALL CrLf
    JMP finif1
    else1: 
        MOV EBX, 1
        MOV ECX, 0
        initWhile:
            CMP EBX, N
            JG finWhile
                CMP ECX, 0
                JGE else2
                    NEG ECX
                    ADD ECX, EBX
                    JMP finif2
                else2:
                    ADD ECX, EBX
                    NEG ECX
                finif2:
                    MOV EDX, OFFSET Termino
                    CALL WriteString
                    MOV EAX, EBX
                    CALL WriteInt
                    MOV EDX, OFFSET Espacio
                    CALL WriteString
                    MOV EAX, ECX
                    CALL WriteInt
                    CALL CrLf
                    INC EBX
                JMP initWhile
            finWhile:
                MOV EDX, OFFSET Respuesta
                CALL WriteString
                MOV EAX, ECX
                CALL WriteInt
                CALL CrLf
                MOV EDX, OFFSET Adios
                CALL WriteString
    finif1:
        exit

    main ENDP

END main
                    
                
            
            

