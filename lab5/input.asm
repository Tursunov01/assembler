PUBLIC INPUT

DSEG SEGMENT PARA PUBLIC 'DATA'
	ENT	DB	">> $"
	EMPTY_LINE	DB	10, 13, '$'
	error db "incorrect number$"
	buff db 100 Dup('$')
DSEG ENDS

CSEG	SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG, DS: DSEG
		
INPUT PROC far

	mov ah, 09
	mov dx, offset EMPTY_LINE
	int 21h

	mov ah, 09
	mov dx, offset ENT
	int 21h

    mov ah,0ah ; принимаем строку
    xor di,di
    mov dx,offset buff ; аддрес буфера
    int 21h 

    mov dl,0ah
    mov ah,02
    int 21h ; выводим перевода строки
    
    mov si, offset buff+2 ; берем аддрес начала строки
metka_1:
    xor ax,ax ;обнуляем значения ах 
    mov bx, 2  ; основание сc. Тут и происходит самое интересное. Я перевожу из 2 в 10. Дальше работаю только с 10ым числом
metka_2:
    mov cl,[si] ; берем символ из буфера
    cmp cl, 0dh  ; проверяем не последний ли он
    jz metka_3
    
; если символ не последний, то проверяем его на правильность
    cmp cl,'0'  ; если введен неверный символ <0
    jb metka_error
    cmp cl,'1'  ; если введен неверный символ >9
    ja metka_error
 
    sub cl,'0' ; делаем из символа число 
    mul bx     ; умножаем на 2
    add ax,cx  ; прибавляем к остальным
    inc si     ; указатель на следующий символ
    jmp metka_2     ; повторяем
 
metka_error:   ; если была ошибка, то выводим сообщение об этом и выходим
    mov ah,09
	mov dx, offset error
    int 21h
; все символы из буфера обработаны число находится в ax
metka_3:
    ret

INPUT ENDP

CSEG	ENDS
END