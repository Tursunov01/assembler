PUBLIC SDec
EXTRN x:word

CSEG SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG
		
SDec PROC NEAR
   mov ax, x ; перемещяю введенное число в регистр ах

; Проверяю число на знак.
   test ax, ax
   jns metka_1

; Если оно отрицательное, выведем минус.
   mov cx, ax
   mov ah, 02h
   mov dl, '-'
   int 21h
   mov ax, cx
   neg ax

metka_1:  
    xor cx, cx ;обнуляю сх
    mov bx, 10 ; основание сс в которую я перевожу
metka_2:
    xor dx,dx
    div bx
; Делю число на основание сс. В остатке получается последняя цифра. Сохраняю её в стек
    push dx
    inc cx

; А с частным повторяю то же самое, отделяя от него очередную цифру справа, пока не останется ноль

    test ax, ax    
    jnz metka_2
    mov ah, 02h ; вывод.

metka_3:
    pop dx
; Извлекаю очередную цифру, переводя её в символ и произвожу вывод.
    add dl, '0'
    int 21h
; Идёт повтор, кол-во которого равно кол-ву насчитанных цифр.
    loop metka_3
    ret

SDec	ENDP		
CSEG	ENDS
END