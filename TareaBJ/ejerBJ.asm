TITLE *MASM Template	(ejerBj)*

; Descripcion:
; 
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA

N DWORD ?
textoLec BYTE "Ingrese un número de temperaturas a leer entre 1 y 10",0
textoError1 BYTE "Error por N < 1 o N > 10",0
textoLectura1 BYTE "Teclee la ",0
textoLectura2 BYTE " temperatura: ",0
min SDWORD 300000
pos DWORD 0
textoMin BYTE "Minimo de las temperaturas: ",0
textoFin1 BYTE "Temperatura ",0
textoFin2 BYTE ": ",0
textoP BYTE ", P",0
textoI BYTE ", I",0
adios BYTE "ADIOS", 0
temperaturas SDWORD ?

.CODE
; Procedimiento principal
main PROC

    MOV ESI, OFFSET temperaturas
    
    MOV EDX, OFFSET textoLec
    CALL WriteString
    CALL CrLf
    CALL ReadInt
    MOV N, EAX
    .IF N < 1 || N > 10
        MOV EDX, OFFSET textoError1
        CALL WriteString
        CALL CrLf
    .ELSE
        MOV EBX, 1
        .WHILE EBX <= N
            MOV EDX, OFFSET textoLectura1
            CALL WriteString
            MOV EAX, EBX
            CALL WriteInt
            MOV EDX, OFFSET textoLectura2
            CALL WriteString
            CALL ReadInt
            CALL CrLf

            MOV [ESI], EAX
            INC SDWORD PTR [ESI]

            .IF EAX < min
                MOV min, EAX
                MOV pos, EBX
            .ENDIF
            INC EBX
        .ENDW
        
        MOV EDX, OFFSET textoMin
        CALL WriteString
        MOV EAX, min
        CALL WriteInt
        CALL CrLf
    
        .WHILE EBX > 1
            ;SUB ESI, TYPE temperaturas
            DEC SDWORD PTR [ESI]
            DEC EBX
            
            MOV EDX, OFFSET textoFin1
            CALL WriteString
            MOV EAX, EBX
            CALL WriteInt
            MOV EDX, OFFSET textoFin2
            CALL WriteString
            MOV EAX, [ESI]
            CALL WriteInt
            
            MOV ECX, [ESI]
            AND ECX, 1
            .IF ECX > 0
                MOV EDX, OFFSET textoI
                CALL WriteString
            .ELSE
                MOV EDX, OFFSET textoP
                CALL WriteString
            .ENDIF
    
            CALL CrLf
    
        .ENDW
    
    .ENDIF

    MOV EDX, OFFSET adios
    CALL WriteString

    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main