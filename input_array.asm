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
;  Program name: input_array
;  Programming languages: Two modules in C, One in CPP, Four in X86, and two in bash.
;  Date program began: 2024-Mar-2
;  Date of last update: 2024-Mar-17
;  Files in this program: main.c, manager.asm, output_array.c, compute_mean.asm, compute_variance.cpp, input_array.asm, isfloat.asm, r.sh, rg.sh
;  Testing: Alpha testing completed.  All functions are correct.
;
;Purpose
; Calculates Variance

;This file:
;  File name: input_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
;  Assemble (debug): nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm -gdwarf
;  Prototype of this function: double manager();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

extern isfloat
extern atof
extern printf
extern scanf

global input_array

segment .data

string_format db "%s", 0
user_invalid_input db "The last input was invalid and not entered into the array.", 10, 0

segment .bss

align 64
backup_storage_area resb 832

segment .text

input_array:
;Back up the GPRs (General Purpose Registers)
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



mov r13, rdi ;r13 is the array
mov r14, rsi ;r14 is the array size
mov r15, 0 ;r15 is the current index


begin_loop:
sub rsp, 1024

cmp r15, r14
je exit_loop

mov rax, 0
mov rdi, string_format
mov rsi, rsp
call scanf

cdqe
cmp rax, -1
je exit_loop


;Check user input with isfloat
mov rax, 0
mov rdi, rsp
call isfloat
cmp rax, 0
je invalid_input

    
;calls atof
mov rax, 0
mov rdi, rsp
call atof


movsd [r13+r15*8], xmm0
inc r15

add rsp, 1024
jmp begin_loop


invalid_input:
add rsp, 1024
mov rax, 0
mov rdi, user_invalid_input
call printf

jmp begin_loop


exit_loop:
add rsp, 1024

; Restore the values to non-GPRs
mov rax, 7
mov rdx, 0
xrstor [backup_storage_area]

mov rax, r15

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

