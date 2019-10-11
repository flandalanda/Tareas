TITLE *MASM Template

; Descripcion:
; Uso de "Type" PTR
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA

A SDWORD 20
B SDWORD 10
C1 SDWORD 2
texto BYTE "C: ",0

.CODE
;Procedimiento principal

main PROC   

    MOV EAX, A
    CMP EAX, B
    JLE else1

        CMP C1, 5
        JG else1
            NEG EAX
            ADD EAX, B
            MOV C1, EAX
            JMP mataif

    else1:
        MOV EAX, B
        MOV EBX, 10
        IMUL EBX
        MOV C1, EAX
    mataif:

    MOV EDX, OFFSET texto
    CALL WriteString
    CALL WriteInt
    CALL CrLf

    exit

    main ENDP

END main
                    
                
            
            

