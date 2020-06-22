#include <stdio.h>

int my_strlen(const char *a){
    int i = 0;
    while (a[i] != '\0'){
        i++;
    }
    return i;
}

void my_strcpy(const char *from, char *to, int len){
    for (int i = 0; i < len; i++){
        to[i] = from[i];
    }
    to[len] = '\0';
}

int main(void){
    char surname[20], name[20];
    int len;
    printf("Input stirng to copy: ");
    scanf("%s", name);
    len = y_strlen(name);
    my_strcpy(name, surname, len);
    printf("Result = %s\n", surname);
    return 0;
}