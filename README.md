# A calculator written in assembly language with nasm syntax
Programm 32bit

These commands will compile this code in assembly language and create an object file "calc.o":
``` bash
    nasm -f elf32 calc.s -o calc.o
```
And assemble the object file with a linker:
```bash
    ld -m elf_i386 calc.o -o calc.out
```
