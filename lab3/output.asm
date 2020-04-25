EXTRN vvod: far, process: far

stkg segment para stack 'STACK'
    DB 300h DUP (?)
stkg ends

cseg segment para public 'CODE'
	assume cs:cseg, ss: stkg
main:
	call vvod
    call process	

cseg ends

end main