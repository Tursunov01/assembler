#include <stdio.h>
#include <stdlib.h>

#define SIZE 8

// Сложение 2-х векторов

int main(void){
 
    setbuf(stdout, NULL);

    // выделение памяти под вектора
    char *arr1 = malloc(SIZE * sizeof(char));
    char *arr2 = malloc(SIZE * sizeof(char));
    char *arr3 = malloc(SIZE * sizeof(char));

    // заполнение
    for (int i = 0; i < SIZE; i++){
        arr1[i] = i;
        arr2[i] = i + 2;
    }
    // ассемблерная вставка
    __asm(
        ".intel_syntax noprefix\n\t" // чтобы синтаксис был удобным
        "movq mm0, [%1]\n\t" // загрузка в регистр ммх массива по индексу 1 из параметров
        "movq mm1, [%2]\n\t"
        "paddb mm1, mm0\n\t" // сложение поэлементно
        "movq [%0], mm1\n\t"
        : "=r" (arr3) // выходные параметры
        : "r" (arr1), "r" (arr2) // входные параметры
        : "mm0", "mm1" // очищение регистров
    );

    for (int i = 0; i < SIZE; i++){
        printf("%d ", arr3[i]);
    }
    return 0;
}