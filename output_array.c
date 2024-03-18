//Author: Thomas Nguyen
//Author email: thomasn1003@csu.fullerton.edu
//Program name: output_array
//Programming languages: Two modules in C, One in CPP, Four in X86, and two in bash.
//Date program began: 2024-Mar-2
//Date of last update: 2024-Mar-17
//Files in this program: main.c, manager.asm, output_array.c, compute_mean.asm, compute_variance.cpp, input_array.asm, isfloat.asm, r.sh, rg.sh


//Purpose of this program:
// This program calculates variance

//This file
//  File name: output_array.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile (standard): gcc  -m64 -Wall -no-pie -o output_array.o -std=c2x -c output_array.c
//  Compile (debug): gcc  -m64 -Wall -no-pie -o output_array.o -std=c2x -c output_array.c -g
//  Link: g++ -m64 -no-pie -o a.out isfloat.o manager.o input_array.o compute_mean.o output_array.o compute_variance.o main.o -std=c2x -Wall -z noexecstack -lm


#include <stdio.h>

void output_array(double *arr, int size) {
    for(int i = 0; i < size; i++) {
        printf("%lf  ", arr[i]);
    }

    printf("\n");
}