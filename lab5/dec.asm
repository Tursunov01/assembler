PUBLIC SDec
EXTRN x:word

CSEG SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG
		
SDec	PROC NEAR
    mov ax, x ; перемещяю введенное число в регистр ах
; Проверяем число на знак.
   test ax, ax
   jns metka_1

; Если оно отрицательное, выведем минус.
   mov cx, ax
   mov ah, 02h
   mov dl, '-'
   int 21h
   mov ax, cx
   neg ax
; Количество цифр будем в CX.
metka_1:  
    xor cx, cx ;обнуляю сх
    mov bx, 10 ; основание сс в которую я перевожу
metka_2:
    xor dx,dx
    div bx
; Делим число на основание сс. В остатке получается последняя цифра.
; Сразу выводить её нельзя, поэтому сохраним её в стэке.
    push dx
    inc cx
; А с частным повторяем то же самое, отделяя от него очередную
; цифру справа, пока не останется ноль, что значит, что дальше
; слева только нули.
    test ax, ax; логическое И
    jnz metka_2

    mov ah, 02h ; вывод.
metka_3:
    pop dx
; Извлекаем очередную цифру, переводим её в символ и выводим.
    add dl, '0'
    int 21h
; Повторим ровно столько раз, сколько цифр насчитали.
    loop metka_3
    ret
SDec	ENDP	
		
CSEG	ENDS
END