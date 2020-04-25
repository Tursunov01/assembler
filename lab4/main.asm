stk segment stack
        db 200h dup (0)
stk ends

data segment
        n db 0
        m db 0
        matrix db 81 dup (?)
        zapros1 db 13, 10, 'Enter number of rows ->  $'
        zapros2 db 13, 10, 'Enter number of columns ->  $'
        zapros3 db 13, 10, 'Enter elements of matrix->  $'
        zapros4 db 13, 10, 'Matrix->  $'
        perenos db 13, 10, '$'
data ends

code segment
assume cs: code, ds: data, ss:stk
begin:
        mov ax, data
        mov ds, ax
vvod_n:
   mov ah, 09h
   mov dx, offset zapros1
   int 21h

   mov ah, 01h
   int 21h

   cmp al, '0'
   jb vvod_n
   cmp al, '9'
   ja vvod_n

   sub al, 30h
   mov n, al

vvod_m:
   mov ah, 09h
   mov dx, offset zapros2
   int 21h

   mov ah, 01h
   int 21h

   cmp al, '0'
   jb vvod_m
   cmp al, '9'
   ja vvod_m

   sub al, 30h
   mov m, al

lenght:
   mov ah, 09h
   mov dx, offset zapros3
   int 21h
   
   mov al, n
   mov bl, m
   mul bl
   mov cx, ax

input_matrix:
   mov ah,01h                      
   int 21h                        
   
   mov matrix[si], al
   inc si
   
   mov ah,01h                      
   int 21h

   loop input_matrix

change:
   mov si, 0
   mov bp, 0

   mov al, n
   mov bl, m
   mul bl
   mov cx, ax

   mov bx, 0
   mov bl, m
   sub bx, 1
lp3:
   mov al, matrix[si+bp]
   mov ah, matrix[si+1+bp]

   mov matrix[si+1+bp], al
   mov matrix[si+bp], ah
   
   add si, 2
   cmp si, bx

   je lp4

   loop lp3
   jmp output
lp4:
   add bp, si
   inc bp
   mov si, 0
   loop lp3

output:
   mov ah, 09h
   mov dx, offset zapros4
   int 21h

   mov ah, 09h
   mov dx, offset perenos
   int 21h  

   mov si, 0
   mov cx, 0
   mov cl, n
   
lp1:
   mov bx, cx
   mov cx, 0
   mov cl, m
lp2:
   mov ah, 02h
   mov dl, matrix[si]
   int 21h

   mov ah, 02h
   mov dl, ' '
   int 21h

   inc si
   loop lp2

   mov ah, 09h
   mov dx, offset perenos
   int 21h

   mov cx, bx
   loop lp1

finish:
   mov ax, 4C00h
   int 21h

code ends
end begin
end vvod_n
end vvod_m
end lenght
end input_matrix
end change
end lp3
end lp4
end output
end finish