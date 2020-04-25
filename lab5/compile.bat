@echo on
masm.exe main.asm,,,;
masm.exe input.asm,,,;
masm.exe hex.asm,,,;
masm.exe dec.asm,,,;
link.exe main.obj input.obj hex.obj dec.obj,,,;
del *.obj
del *.lst
del *.map
del *.sbr