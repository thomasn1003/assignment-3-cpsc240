//Author: Thomas Nguyen
//Author email: thomasn1003@csu.fullerton.edu
//Program name: main
//Programming languages: One module in C, two in X86, and one in bash.
//Date program began: 2024-Mar 2
//Date of last update: 2024-Mar
//Files in this program: main.c, manager.asm, output_array.c, compute_mean.asm, compute_variance.cpp, input_array.asm, isfloat.asm, r.sh


//Purpose of this program:
// This program calculates 

//This file
//  File name: main.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc  -m64  -Wall -no-pie -o main.o -std=c2x -c main.c
//  Link: gcc -m64 -no-pie -o a.out compute_triangle.o isfloat.o main.o -lm -std=c2x -Wall -z noexecstack

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h> 

extern double manager();

int main(int argc, const char* argv[]) 
{
    printf("Welcome to Arrays of floating point numbers.\n");
    printf("Brought to you by Thomas Nguyen\n\n");
    double result = 0;
    result = manager();

    printf("Main recieved &lf, and will keep it for future use\n\n", result)
    printf("Main will return 0 to the operating system. Bye.")

}   