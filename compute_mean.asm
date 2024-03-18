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
;  Program name: compute_mean
;  Programming languages: Two modules in C, One in CPP, Four in X86, and two in bash.
;  Date program began: 2024-Mar-2
;  Date of last update: 2024-Mar-17
;  Files in this program: main.c, manager.asm, output_array.c, compute_mean.asm, compute_variance.cpp, input_array.asm, isfloat.asm, r.sh, rg.sh
;  Testing: Alpha testing completed.  All functions are correct.
;
;Purpose
; Calculates Variance

;This file:
;  File name: compute_mean.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l compute_mean.lis -o compute_mean.o compute_mean.asm
;  Assemble (debug): nasm -f elf64 -l compute_mean.lis -o compute_mean.o compute_mean.asm -gdwarf
;  Prototype of this function: double manager();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration


extern printf

global compute_mean

segment .data

segment .bss

align 64
backup_storage_area resb 832


segment .text

compute_mean:
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
mov r15, 0   ;r15 is the current index

movsd xmm13, [r13]
cvtsi2sd xmm14, r14 ;Converts size of the array to float and storing value in xmm14


sumadd:
cmp r15, r14
je exit

addsd xmm12, [r13+r15*8]
inc r15
jmp sumadd
    
exit:
;Divides sum to get the mean
divsd xmm12, xmm14
    
push qword 0
movsd [rsp], xmm12

; Restore the values to non-GPRs
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