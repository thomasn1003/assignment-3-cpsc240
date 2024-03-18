;****************************************************************************************************************************
;Program name: "Assignment 2 Arrays".  This program serves as a model for programmers of X86 programming language.            *
;This shows the standard layout of a function written in X86 assembly.  The program is a live example of how to compile,    *
;assembly, link, and execute a program containing source code written in X86.  Copyright (C) 2024  Floyd Holliday.          *
;                                                                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Thomas Nguyen
;  Author email: thomasn1003@csu.fullerton.edu
;
;Program information
;  Program name: manager
;  Programming languages: Two modules in C, One in CPP, Four in X86, and two in bash.
;  Date program began: 2024-Mar-2
;  Date of last update: 2024-Mar-17
;  Files in this program: main.c, manager.asm, output_array.c, compute_mean.asm, compute_variance.cpp, input_array.asm, isfloat.asm, r.sh, rg.sh
;  Testing: Alpha testing completed.  All functions are correct.
;
;Purpose
; Calculates Variance

;This file:
;  File name: manager.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l manager.lis -o manager.o manager.asm
;  Assemble (debug): nasm -f elf64 -l manager.lis -o manager.o manager.asm -gdwarf
;  Prototype of this function: double manager();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

extern printf
extern stdin
extern scanf
extern input_array
extern output_array
extern isfloat
extern compute_mean
extern compute_variance

global manager



float_size equ 60
array_size equ 12

segment .data

program_description db 10, "This program will manage your arrays of 64-bit floats", 10, 0
program_instructions db "For the array enter a sequence of 64-bit floats separated by white space.", 10, 0
exit_instructions db "After the last input press enter followed by Control+D:", 10, 0
numbers_received db 10, "These numbers were received and placed into an array", 10, 0
variance db "The variance of the inputted numbers is %1.6lf", 10, 0
doubleformat db "%lf", 0


segment .bss

align 64
backup_storage_area resb 832
array resq array_size


segment .text

manager:
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

;Backup the registers other than the GPRs
mov rax,7
mov rdx,0
xsave [backup_storage_area]

;Output the program description
mov rax, 0
mov rdi, program_description
call printf

;Output the program instructions
mov rax, 0
mov rdi, program_instructions
call printf

;Output the exit instructions
mov rax, 0
mov rdi, exit_instructions
call printf


;Call input array to get inputs from the array and validate the inputs
mov rax, 0
mov rdi, array
mov rsi, array_size
call input_array
mov r13, rax 
    

;Ouput numbers_received
mov rax, 0
mov rdi, numbers_received
call printf


;Call output_array
mov rax, 0
mov rdi, array
mov rsi, r13
call output_array

;Call compute_mean
mov rax, 0
mov rdi, array
mov rsi, r13
call compute_mean
movsd xmm14, xmm0 ;moves compute_mean output to xmm14



;Call compute_variance
mov rax, 0
mov rdi, array
mov rsi, r13
movsd xmm0, xmm14
call compute_variance
movsd xmm15, xmm0 ;moves variance to xmm15


;Output the variance of the array input by the user
mov rax, 1
mov rdi, variance
mov rsi, doubleformat
movsd xmm0, xmm15   ;variance
call printf


;Back up value in xmm15 (variance) before restoring registers
push qword 0
movsd [rsp], xmm15

;Restore the values to non-GPRs
mov rax, 7
mov rdx, 0
xrstor [backup_storage_area]

movsd xmm0, [rsp]
pop rax
    
;Restore the GPRs
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp
ret