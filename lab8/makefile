app.exe: main.o
	gcc -o app.exe main.o
main.o: main.c
	gcc -Wall -c -masm=intel main.c -o main.o
clean: 
	rm *.o *.exe