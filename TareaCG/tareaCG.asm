TITLE proyecto seno					(mediTiem.asm)

; GetMseconds PROC
; Returns the number of milliseconds that have elapsed since midnight, in the local zone.
; Returns (milliseconds): EAX = ( (hours*3600) + (minutes*60) + (seconds) ) * 1000 + currentMilliseconds

INCLUDE myIrvine.inc

.DATA
; variables procedimiento principal
mstart DWORD ?
opcion DWORD ?

txtSep BYTE "----------------------------------------------------------", 0
txtMnu BYTE "MENU: Escoge la opcion deseada",0
txtOp1 BYTE "1. Ingrese el valor de x en grados",0
txtOp2 BYTE "2. Ingrese el valor de x en radianes", 0
txtOp3 BYTE "3. Tabla del seno de x de 0 a 360 grados", 0
txtSalir BYTE "4. Salir",0
txtX BYTE "Ingresa el valor de x: ", 0
txtRes BYTE "El resultado de seno(x) es: ", 0
txtTmp BYTE "El tiempo transcurrido en el calculo del seno, en ms, fue: ", 0
adios BYTE "ADIOS", 0

; variables procedimiento gradToRad
constante REAL8 180.0


; variables procedimiento calculaSeno
fac REAL8 1.0
num REAL8 1.0
contFac REAL8 1.0
pow REAL8 ?
x2 REAL8 ?
sin REAL8 ?


; variables procedimiento epsilon
tol REAL8 0.0001

; variables proc creaTabla
grados BYTE "Grados",0
radianes BYTE "Radianes",0
seno BYTE "seno(x)",0
sep BYTE " | ",0

diez REAL8 10.0
aux REAL8 ?


.CODE
main PROC

    .REPEAT
        ; Desplegar menu
        MOV EDX, OFFSET txtSep
        CALL WriteString
        CALL CrLf
        MOV EDX, OFFSET txtMnu
        CALL WriteString
        CALL CrLf
        MOV EDX, OFFSET txtOp1
        CALL WriteString
        CALL CrLf
        MOV EDX, OFFSET txtOp2
        CALL WriteString
        CALL CrLf
        MOV EDX, OFFSET txtOp3
        CALL WriteString
        CALL CrLf
        MOV EDX, OFFSET txtSalir
        CALL WriteString
        CALL CrLf

        ; Leer opcion
        CALL ReadInt
        MOV opcion, EAX
        FINIT
        .IF opcion < 3                          ; Calcular el valor de seno
            
            CALL CrLf
            MOV EDX, OFFSET txtX                ; Leer valor de x
            CALL WriteString
            CALL ReadFloat
            CALL CrLf

            .IF opcion == 1
                CALL gradToRad                  ; Convertir a radianes 
            .ENDIF

            CALL GetMseconds                    ; Obtener tiempo de inicio
            MOV mstart, EAX
            ;CALL WriteInt

            CALL calculaSeno                    ; Calcular seno

            CALL GetMseconds                    ; Calcular tiempo transcurrido
            ;CALL CrLf
            ;CALL WriteInt
            SUB EAX, mstart
            ;CALL CrLf


            MOV EDX, OFFSET txtRes              ; Imprimir resultados
            CALL WriteString
            CALL WriteFloat
            CALL CrLf

            MOV EDX, OFFSET txtTmp              
            CALL WriteString
            CALL WriteInt
            CALL CrLf


        .ELSEIF opcion == 3                     ; Desplegar tabla

            CALL crearTabla
    
        .ENDIF

        CALL CrLf
    .UNTIL opcion >= 4

    MOV EDX, OFFSET adios
    CALL WriteString


    EXIT
main ENDP

gradToRad PROC
; Procedimiento para convertir de grados a radianes
; Recibimos por el stack del FPU:
;           ST(0) el valor a convertir
; Regresa por el stack del FPU
;           ST(0) el valor en radianes

    POP ESI                     ; direccion de retorno

    FLDPI                       ; guardar el valor de PI en ST(0)  
    FMUL ST(0), ST(1)           ; multiplicar grados * PI
    FDIV constante              ; dividir por 180    


    PUSH ESI
    RET

gradToRad ENDP

calculaSeno PROC
; Procedimiento para calcular el seno de x (x en radianes)
; Recibimos por el stack del FPU:
;           ST(0) el valor de x
; Regresa por el stack del FPU
;           ST(0) el valor de seno(x)

    MOV EBX, 0                  ; bandera para salir del while
    MOV ECX, 1                  ; cuenta indice de factorial

    FST pow                     ; calculamos el primer termino de la serie que es x
    FST sin 
 
    FLD pow                     ; calculamos valor de x**2
    FMUL 
    FSTP x2

    .WHILE EBX == 0

        FLD num                 ; Invertimos signo numerador 
        FCHS
        FST num

        FLD pow                 ; multiplicamos la potencia anterior por x**2
        FMUL x2
        FST pow

        FMUL                    ; multiplicamos (-1)**n * x**(2n+1)

        FLD fac                 ; Calculamos el nuevo valor del factorial
        FLD contFac
        FLD1
        FADD
        FMUL ST(1), ST(0)
        FLD1
        FADD
        FMUL ST(1), ST(0)
        FSTP contFac

        FDIV ST(1), ST(0)       ; dividimos entre el factorial
        FSTP fac


        FLD sin                 ; agregamos el nuevo termino de la serie
        FADD ST(1), ST(0)   

        CALL epsilon            ; verificamos tolerancia

        FSTP sin                ; guardamos el nuevo valor de la suma en la variable sin

    .ENDW

    FLD1                        ; resetear variables
    FST fac
    FST contFac
    FSTP num

    FLD sin                     ; regresamos el valor de la suma en el stack
    ; CALL ShowFPUStack

    RET

calculaSeno ENDP

epsilon PROC
    ; Procedimiento para comprobar que el calculo del seno esta dentro de la tolerancia
    ; Recibe por el stack de FPU
    ;               ST(0): valor anterior de la suma
    ;               ST(1): nuevo valor de la suma
    ; Regresa:
    ;               EBX: 0 si el calculo difiere en mas de la tolerancia, 1 si es menor a la tolerancia definida 


    ;POP EDI       


    FSUB ST(0), ST(1)              ; Resta ST(0) = ST(0) - ST(1)
    FABS                           ; Obtenemos valor absoluto

    FCOMP tol                      ; comparamos con la tolerancia

    FNSTSW AX
    SAHF


    JA zero                        ; ST(0) > tol
        MOV EBX, 1
        JMP fin
    zero:                          ; ST(0) < tol
        MOV EBX, 0
    fin:
        RET
    
epsilon ENDP


crearTabla PROC

    CALL ClrScr               ; Limpiamos la ventana de la consola
    MOV EDX, OFFSET grados    ; Creamos las columnas de la tabla
    CALL WriteString

    MOV DX, 0014h
    CALL GoToXY

    MOV EDX, OFFSET sep
    CALL WriteString

    MOV EDX, OFFSET radianes
    CALL WriteString

    MOV DX, 002Bh
    CALL GoToXY
    MOV EDX, OFFSET sep
    CALL WriteString

    MOV EDX, OFFSET seno
    CALL WriteString

    MOV DH, 1                ; Inicializamos contador para los renglones

    FLDZ                      ; Inicializamos las xs

    .WHILE DH < 38

        MOV DL, 0             ; Colocamos el cursor en la primera columna
        CALL GoToXY

        CALL WriteFloat       ; Escribe el valor de x en grados

        CALL gradToRad        ; Convertimos de grados a radianes
        MOV DL, 17h           ; Nos colocamos en la segunda columna
        CALL GoToXY
        CALL WriteFloat       ; Escribimos x en radianes

        CALL calculaSeno      ; Calculamos sen(x)
        MOV DL, 2Eh           ; Nos posicionamos en la tercera columna
        CALL GoToXY
        CALL WriteFloat       ; Imprimimos el valor del seno

        INC DH                ; Aumentamos renglon

        FSTP aux              ; Popeamos el valor de sen(x)
        FADD diez             ; Aumentamos x en 10 grados

    .ENDW


    CALL CrLf
    CALL CrLf
    

    RET

crearTabla ENDP



END main