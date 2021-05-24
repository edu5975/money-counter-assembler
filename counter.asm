desplegaMensajeMacro macro msg  ;LA MACRO DESPLEGAMENSAJE TIENE COMO PARAMETRO MSG 
    mov ah, 09h                 ;EL CUAL SERA EL MENSAJE A DESPLEGAR MEDIANTE 
    lea dx, msg                 ;LA FUNCIÓN 09H Y LA INTERRUPCIÓN 21H 
    int 21h 
endm

imprimeNumero macro num
    mov ax, num
    mov bx, offset cantidad
    call itoa 
    desplegaMensajeMacro cantidad
endm

imprimeLCD macro num
    mov ax, num
    mov bx, offset cantidad
    call imp 
endm

desplegaTodo macro
    desplegaMensajeMacro msgUno
    imprimeNumero uno
    desplegaMensajeMacro msgDos
    imprimeNumero dos 
    desplegaMensajeMacro msgCinco
    imprimeNumero cinco 
    desplegaMensajeMacro msgDiez
    imprimeNumero diez 
    desplegaMensajeMacro msgTotal
    imprimeNumero total 
endm

delay macro
	mov cx,1h
	mov dx,1h
	mov ah,86h
	int 15h
endm

insert macro numero
	mov dx,0378h
	mov al,numero
	out dx,al
	delay
	cero
	delay
endm

saldo macro
    insert 00110101b ;S
    insert 00110011b

    insert 00110100b ;a
    insert 00110001b

    insert 00110100b ;l
    insert 00111100b

    insert 00110100b ;d
    insert 00110100b

    insert 00110100b ;o
    insert 00111111b

    insert 00110011b ;:
    insert 00111010b
endm

conse macro
endm

cero macro
	mov dx,0378h
	mov al,00000000b
	out dx,al
endm

.model SMALL
.386
.STACK 128
.DATA
    cantidad  db 6 DUP(?)    
    prueba db 10,13,7, "PRUEBAAAAAA $"
    msgUno db 10,13,7, "Monedas 1: $"
    msgDos db 10,13,7, "Monedas 2: $"
    msgCinco db 10,13,7, "Monedas 5: $"
    msgDiez db 10,13,7, "Monedas 10: $"
    msgTotal db 10,13,7, "Total: $"
    op1 dw ?
    op2 dw ?
    
    uno dw 2
    dos dw 2
    cinco dw 2
    diez dw 2
    total dw 2
    bina dw 2

.CODE
.STARTUP
    mov ax,@data
    mov ds,ax

main proc
    insert 01000000b  ;function reset

    insert 00100010b  ;function set

	insert 00100010b  ;function set
	insert 00100000b

	insert 00100000b  ;display on
	insert 00101110b

	insert 00100000b  ;entry mode
	insert 00100110b

    insert 00100000b  ;clear display
    insert 00100001b

	mov uno,0
    mov dos,0
    mov cinco,0
    mov diez,0
    mov total,0

    
    desplegaTodo
    saldo
    imprimeLCD total

    ciclo:
        xor ax,ax
        mov dx, 379h
        in al,dx


        cmp al,72
        jz aumentauno
        cmp al,88
        jz aumentados
        cmp al,104
        jz aumentacinco
        cmp al,120
        jz aumentadiez


    jmp ciclo



    salir proc
        mov ax,4c00h
        int 21h
    salir endp
main endp

aumentauno proc
    insert 00100000b  ;clear display
    insert 00100001b
    inc uno
    add total,1
    desplegaTodo
    saldo
    imprimeLCD total
    jmp ciclo
aumentauno endp

aumentados proc
    insert 00100000b  ;clear display
    insert 00100001b
    inc dos
    add total,2
    desplegaTodo
    saldo
    imprimeLCD total
    jmp ciclo
aumentados endp

aumentacinco proc
    insert 00100000b  ;clear display
    insert 00100001b
    inc cinco
    add total,5
    desplegaTodo
    saldo
    imprimeLCD total
    jmp ciclo
aumentacinco endp

aumentadiez proc
    insert 00100000b  ;clear display
    insert 00100001b
    inc diez
    add total,10
    desplegaTodo
    saldo
    imprimeLCD total
    jmp ciclo
aumentadiez endp

ceroP proc 
    insert 00110011b  
	insert 00110000b    
    add ax,30h  ; lo pasamos a su valor ascii
    mov [bx],ax ; lo guardamos en la cadena final
    inc bx
    jmp imp_3
ceroP endp

unoP proc 
    insert 00110011b  
	insert 00110001b   
    add ax,30h  ; lo pasamos a su valor ascii
    mov [bx],ax ; lo guardamos en la cadena final
    inc bx
    jmp imp_3
unoP endp

dosP proc 
    insert 00110011b  
	insert 00110010b   
    add ax,30h  ; lo pasamos a su valor ascii
    mov [bx],ax ; lo guardamos en la cadena final
    inc bx
    jmp imp_3
dosP endp

tresP proc 
    insert 00110011b  
	insert 00110011b   
    add ax,30h  ; lo pasamos a su valor ascii
    mov [bx],ax ; lo guardamos en la cadena final
    inc bx
    jmp imp_3
tresP endp

cuatroP proc 
    insert 00110011b  
	insert 00110100b   
    add ax,30h  ; lo pasamos a su valor ascii
    mov [bx],ax ; lo guardamos en la cadena final
    inc bx
    jmp imp_3
cuatroP endp

cincoP proc 
    insert 00110011b  
	insert 00110101b   
    add ax,30h  ; lo pasamos a su valor ascii
    mov [bx],ax ; lo guardamos en la cadena final
    inc bx
    jmp imp_3
cincoP endp

seisP proc 
    insert 00110011b  
	insert 00110110b   
    add ax,30h  ; lo pasamos a su valor ascii
    mov [bx],ax ; lo guardamos en la cadena final
    inc bx
    jmp imp_3
seisP endp

sieteP proc 
    insert 00110011b  
	insert 00110111b   
    add ax,30h  ; lo pasamos a su valor ascii
    mov [bx],ax ; lo guardamos en la cadena final
    inc bx
    jmp imp_3
sieteP endp

ochoP proc 
    insert 00110011b  
	insert 00111000b   
    add ax,30h  ; lo pasamos a su valor ascii
    mov [bx],ax ; lo guardamos en la cadena final
    inc bx
    jmp imp_3
ochoP endp

nueveP proc 
    insert 00110011b  
	insert 00111001b   
    add ax,30h  ; lo pasamos a su valor ascii
    mov [bx],ax ; lo guardamos en la cadena final
    inc bx
    jmp imp_3
nueveP endp

; =============== Convertir numero a cadena ===============
; Parametros
; ax: valor
; bx: donde guardar la cadena final
; Retorna
; cadena
imp proc
    xor cx,cx  ;CX = 0
    imp_1:
        cmp ax,0   ; El ciclo itoa_1 extrae los digitos del
        je imp_2  ; menos al mas significativo de AX y los
                ; guarda en el stack. Al finalizar el 
        xor dx,dx  ; ciclo el digito mas significativo esta
        push bx    ; arriba del stack.
        mov bx,10  ; CX contiene el numero de digitos
        div bx
        pop bx
        push dx
        inc cx
        jmp imp_1

    imp_2:
        cmp cx,0    ; Esta seccion maneja el caso cuando
        ja imp_3   ; el numero a convertir (AX) es 0.
        mov ax,'0'  ; En este caso, el ciclo anterior
        mov [bx],ax ; no guarda valores en el stack y
        inc bx      ; CX tiene el valor 0
        jmp imp_4

    imp_3:
        pop ax      ; Extraemos los numero del stack
        cmp ax,0
        jz ceroP
        cmp ax,1
        jz unoP
        cmp ax,2
        jz dosP
        cmp ax,3
        jz tresP
        cmp ax,4
        jz cuatroP
        cmp ax,5
        jz cincoP
        cmp ax,6
        jz seisP
        cmp ax,7
        jz sieteP
        cmp ax,8
        jz ochoP
        cmp ax,9
        jz nueveP

    imp_4:
        jmp ciclo
imp endp

; =============== Convertir numero a cadena ===============
; Parametros
; ax: valor
; bx: donde guardar la cadena final
; Retorna
; cadena
itoa proc
  xor cx,cx  ;CX = 0

  itoa_1:
  cmp ax,0   ; El ciclo itoa_1 extrae los digitos del
  je itoa_2  ; menos al mas significativo de AX y los
             ; guarda en el stack. Al finalizar el 
  xor dx,dx  ; ciclo el digito mas significativo esta
  push bx    ; arriba del stack.
  mov bx,10  ; CX contiene el numero de digitos
  div bx
  pop bx
  push dx
  inc cx
  jmp itoa_1

  itoa_2:
  cmp cx,0    ; Esta seccion maneja el caso cuando
  ja itoa_3   ; el numero a convertir (AX) es 0.
  mov ax,'0'  ; En este caso, el ciclo anterior
  mov [bx],ax ; no guarda valores en el stack y
  inc bx      ; CX tiene el valor 0
  jmp itoa_4

  itoa_3:
  pop ax      ; Extraemos los numero del stack
  add ax,30h  ; lo pasamos a su valor ascii
  mov [bx],ax ; lo guardamos en la cadena final
  inc bx
  loop itoa_3

  itoa_4:
  mov ax,'$'  ; terminar cadena con '$' para 
  mov [bx],ax ; imprimirla con la INT21h/AH=9
  ret
itoa endp

end

