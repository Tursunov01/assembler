global my_strcpy

section .text

my_strcpy:
    ; т.к. у меня х64 поэтому аргументы не передаются через стек. 
    ; аргументы передаются через регистры rdi, rsi, rdx, rcx  тд
    
    mov rcx, rdi 
    mov rsi, rsi
    mov rdi, rdx

    cld ; сбрасываю флаг

    cmp rsi, rdi
    je exit            ;если  строка2 == строке1
    jb metka_1         ; если строка2 < строки1

    ; иначе
    std ; устанавливаю флаг  = 1
    add rsi, rcx
    dec rsi
    add rdi, rcx
    dec rdi

    metka_1:
        ; movsb записывает в rdi из rsi по байту, а repne будет поворять ровно rcx раз
        rep movsb			

    exit:
        cld ; сбрасываю флаг
    ret
