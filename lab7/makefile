app.exe: main.o my_func.o
	gcc -o app.exe main.o my_func.o
main.o: main.c
	gcc -Wall -g -c -masm=intel main.c -o main.o
my_func.o: my_func.asm
	nasm -f elf64 my_func.asm -o my_func.o
clean: 
	rm *.o *.exe