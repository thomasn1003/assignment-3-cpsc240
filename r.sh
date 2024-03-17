# Author Information
# Author name: Thomas Nguyen
# Author Email: thomas1003nguyen@gmail.com
# Author Section: 240-3
# Author CWID 885287615

#Delete some un-needed files
rm *.o
rm *.out

# Assembles manager.asm
nasm -f elf64 -l manager.lis -o manager.o manager.asm

# Assembles input_array.asm
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

# Assembles compute_mean.asm
nasm -f elf64  -l compute_mean.lis -o compute_mean.o compute_mean.asm

# Assembles isfloat.asm
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

# Compiles main.c
gcc  -m64  -Wall -no-pie -o main.o -std=c2x -c main.c

# Compiles output_array.c
gcc  -m64  -Wall -no-pie -o output_array.o -std=c2x -c output_array.c

# Compiles compute_variance.cpp
gcc  -m64  -Wall -no-pie -o compute_variance.o -std=c2x -c compute_variance.cpp

# Linker for the object files
gcc -m64 -no-pie -o a.out manager.o input_array.o compute_mean.o isfloat.o main.o output_array.o compute_variance.o -lm -std=c2x -Wall -z noexecstack

# Runs the program
chmod +x a.out
./a.out