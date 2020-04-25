public vvod, process

assume cs:code, ds:data, ss:stk 

stk segment para stack 'STACK'
    DB 300h DUP (?)
stk ends

data segment para public 'DATA'   
	buffer db 254 dup ('$')
    str1 db 'enter:', 0Dh, 0Ah, '$'
    str3 db 0Dh, 0Ah, '$'
    str2 db 'result:', 0Dh, 0Ah, '$'
data ends

code segment para public 'CODE'
vvod proc far
    mov ax, data
    mov ds, ax
    
    mov ah,09h
    mov dx, offset str1
    int 21h

    mov ah,0ah
    mov dx, offset buffer
    int 21h

    mov ah,09h
    mov dx, offset str3
    int 21h

    mov ah,09h
    mov dx, offset str2
    int 21h

vvod endp

process proc far
    mov di, -1
    mov bx, 1
    find_len:
        inc di
        mov si, di
        cmp buffer[si + 2],'$' ;сравнение текущего символа с концом строки
        jnz find_len ;если не конец строки
        sub di, 2
        jz check ;если конец строки

    check:
        cmp bx, di ;сравнение что текущая позиция меньшн длины
        jle print ;если меньше либо равно
        jb quit ;если больше

    print:
        mov si, bx
        mov ah, 02h
        mov dl, buffer[si + 2]
        int 21h
        mov dl,13   ;возврат каретки
        int 21h
        mov dl,10   ;перевод строки
        int 21h
        add bx, 3
        cmp bx, di
        jle check
        jb quit

    quit:
        mov ax, 4c00h
        int 21h
process endp
code ends
end find_len
end check
end print
end quit
