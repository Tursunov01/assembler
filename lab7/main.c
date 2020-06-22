#include <stdio.h>
#include <string.h>

extern void my_strcpy(int len, char *from, char *to);

int my_strlen(char *str)
{
    int len;
    __asm__ (
    /* для удобства, а то глаза не привыкнут писать наоборот. 
    То есть не mov приёмник источник , а наоборот*/         
    ".intel_syntax noprefix\n\t"   
    "mov ecx, 100\n\t" // ecx будет декрементироваться каждый раз при "прочтении"   
    "mov al, 0\n\t" // символ с которым идёт сравнение
         
    /* repne повторит некую операцию(поиск) по строке пока не найдет символ из регистра al.
    Строка находится по edi. Проходясь по байтам, декрементирует ecx.
    Поиск прекратиться если не встретиться нуль или ecx станет равным нулю.*/
         
    "repne scasb\n\t"
    "mov eax, 100\n\t" 
        
    /* чтобы получить реальный размер. 
    То есть после того как переберутся все символы, получим 100 - n. 
    Вычитая к этому выражению 100, получим реальный размер*/
        
    "sub eax, ecx\n\t"
    "dec eax\n\t"
    "mov %0, eax" // перенос к 0ой(индекс) переменной
    : "=r"(len)
    : "D"(str)
    : "eax", "ecx", "al" // разрушение регистров
    );

    return len;    
}

int main(void)
{
    setbuf(stdout, NULL);
    
    char str[] = "Makambu";
    char copied_str[100];
    int len;

    len = my_strlen(str);

    printf("strlen = %ld \nmy_strlen = %d\n", strlen(str), len);

    my_strcpy(len, str, copied_str);

    printf("my_strcpy result = %s\n", copied_str);
    
    return 0;
}