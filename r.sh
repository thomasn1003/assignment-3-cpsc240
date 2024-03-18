# Author Information
# Author name: Thomas Nguyen
# Author Email: thomas1003nguyen@gmail.com
# Author Section: 240-3
# Author CWID 885287615

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source file manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble the source file isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Assemble the source file input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the source file compute_mean.asm"
nasm -f elf64 -l compute_mean.lis -o compute_mean.o compute_mean.asm

echo "Compile the source file main.c"
gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

echo "Compile the source file output_array.c"
gcc  -m64 -Wall -no-pie -o output_array.o -std=c2x -c output_array.c

echo "Compile the source file compute_variance.c++"
g++  -c -m64 -Wall -fno-pie -no-pie -o compute_variance.o compute_variance.cpp

echo "Link the object modules to create an executable file"
g++ -m64 -no-pie -o a.out isfloat.o manager.o input_array.o compute_mean.o output_array.o compute_variance.o main.o -std=c2x -Wall -z noexecstack -lm

echo "Execute the program"
chmod +x a.out
./a.out