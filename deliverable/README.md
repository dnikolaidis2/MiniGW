# mycompiler
A MiniScript compiler for the COMP402 course.
## Compilation
Use the provided Makefile
`make` - Makes the compiler
`make tests` - Compiles the correct1 and correct2 test programs
`make clean` - Cleans the folder
## Arguments
```
Usage: mycompiler filename
Output: filename_im.c
```
### Example
`./mycompiler correct1.ms` - outputs `correct1_im.c` file with intermediate representation of MiniScript code into C.
`gcc -std=c99 -Wall -I. -Wno-main -o correct1_ms correct1_im.c -lm` - compiles C code into an executable.
**Notes**: 

 1. `-lm` option is required for  because the `mslib.h` includes `math.h` for the power operator.
 2. `-Wno-main` option is required for normal compilation because in the C99 standard the main function is not allowed to have a void return type.

