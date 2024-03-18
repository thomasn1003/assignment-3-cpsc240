//Author: Thomas Nguyen
//Author email: thomasn1003@csu.fullerton.edu
//Program name: compute_variance
//Programming languages: Two modules in C, One in CPP, Four in X86, and two in bash.
//Date program began: 2024-Mar-2
//Date of last update: 2024-Mar-17
//Files in this program: main.c, manager.asm, output_array.c, compute_mean.asm, compute_variance.cpp, input_array.asm, isfloat.asm, r.sh, rg.sh


//Purpose of this program:
// This program calculates variance

//This file
//  File name: compute_variance.cpp
//  Language: C++ language
//  Max page width: 124 columns
//  Compile (standard): g++  -c -m64 -Wall -fno-pie -no-pie -o compute_variance.o compute_variance.cpp
//  Compile (debug): g++  -c -m64 -Wall -fno-pie -no-pie -o compute_variance.o compute_variance.cpp -g
//  Link: g++ -m64 -no-pie -o a.out isfloat.o manager.o input_array.o compute_mean.o output_array.o compute_variance.o main.o -std=c2x -Wall -z noexecstack -lm

#include <stdio.h>
#include <cmath>

extern "C" double compute_variance(double *array, int size, double mean);

double compute_variance(double *array, int size, double mean) {
    double variance = 0.0;

    for(int i = 0; i < size; i++) {
        variance += std::pow((array[i] - mean), 2);
    }

    return variance/(size - 1);
}