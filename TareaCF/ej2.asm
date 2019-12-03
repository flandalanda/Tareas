TITLE Ejercicio 1 CF      

; Demonstration of multi-doubleword shift, using
; SHR and RCR instructions.

INCLUDE myIrvine.inc


.DATA
factor DWORD ?
n DWORD ?
arrLista REAL8 10 DUP(?)

textoFac BYTE "Ingresa un factor entre el 0 y el 9: ",0
textoN BYTE "Ingresa una N del 1 al 10: ",0
tex BYTE "Menor elemento: ",0
tex2 BYTE " con indice: ",0

; Proc leerLista
textoLec BYTE "Ingresa el siguiente valor real: ",0

; Proc facLista
r DWORD ?

; Proc Imprime
textoImp BYTE "El valor en el indice ", 0
textoImp2 BYTE " es: ", 0 

; Proc MenorLista
lim DWORD ?


.CODE
main PROC
    MOV EDX, OFFSET textoFac  ; Lectura de factor
    CALL WriteString
    CALL ReadInt
    MOV factor, EAX

    CALL CrLf
    MOV EDX, OFFSET textoN    ; Lectura de valor N
    CALL WriteSTring
    CALL ReadInt
    MOV n, EAX

    PUSH OFFSET arrLista
    PUSH n
    CALL LeerLista

    PUSH OFFSET arrLista
    PUSH factor
    PUSH n
    CALL FacLista

    PUSH OFFSET arrLista
    PUSH n
    CALL Imprime

    PUSH OFFSET arrLista
    PUSH n
    CALL MenorLista

    CALL CrLf
    MOV EDX, OFFSET tex
    CALL WriteString
    CALL WriteFloat
    MOV EDX, OFFSET tex2
    CALL WriteString
    POP EAX
    CALL WriteInt
    
    exit

main ENDP

    LeerLista PROC
        POP EDI    ; dirección de retorno
        POP EAX    ; valor n
        POP ESI    ; offset arreglo reales

        MOV ECX, 0
        .WHILE ECX < EAX

            MOV EDX, OFFSET textoLec
            CALL WriteString
            CALL ReadFloat
            CALL CrLf

            FSTP REAL8 PTR [ESI]
            
            INC ECX
            ADD ESI, TYPE REAL8

        .ENDW

        PUSH EDI
        RET

    LeerLista ENDP

    FacLista PROC

        POP EDI    ; dir ret
        POP EAX    ; n
        POP r      ; factor
        POP ESI    ; OFFSET arrLista

        MOV ECX, 0
        FILD r

        .WHILE ECX < EAX

            FLD REAL8 PTR [ESI]
            FMUL ST(0), ST(1)
            FSTP REAL8 PTR [ESI]
            ADD ESI, TYPE REAL8
            INC ECX

        .ENDW

        PUSH EDI
        RET

    FacLista ENDP

    Imprime PROC
        POP EDI
        POP EBX
        POP ESI

        MOV EAX, 0

        .WHILE EAX < EBX

            FLD REAL8 PTR [ESI]
            MOV EDX, OFFSET textoImp
            CALL WriteString
            CALL WriteInt
            MOV EDX, OFFSET textoImp2
            CALL WriteString
            CALL WriteFloat
            CALL CrLf
            ADD ESI, TYPE REAL8
            INC EAX

        .ENDW

        PUSH EDI
        RET


    Imprime ENDP

    MenorLista PROC
        POP EDI    ; dir ret
        POP lim    ; valor n
        POP ESI    ; OFFSET arrLista

        MOV EAX, 0
        FLD REAL8 PTR [ESI]
        CALL WriteFloat

        .WHILE EAX < lim

            ADD ESI, TYPE REAL8
            FCOM REAL8 PTR [ESI]
            FNSTSW AX
            SAHF
            JB SALTO
            FLD REAL8 PTR [ESI]
            MOV EBX, EAX
    SALTO:  INC EAX

        .ENDW

        PUSH EBX
        PUSH EDI

        RET


    MenorLista ENDP
    
END main