extern printf

extern fgets

extern stdin

extern strlen

extern scanf

extern atof

extern cos

extern isfloat

global manager

name_string_size equ 48
title_string_size equ 48
variable_size equ 4096

segment .data

program_description db "This program will manage your arrays of 64-bit floats, 0
program_directions db "For the array enter a sequence of 64-bit floats separated by white space.", 0
exit_directions db "After the last input press enter followed by Control+D:", 0
numbers_recieved db "These number were received and placed into an array", 0
variance_output db "The varianc of the inputted numbers is $lf", 0


segment .bss
backup_storage_area resb 832

user_name resb name_string_size
user_title resb title_string_size

user_first_length resb variable_size
user_second_length resb variable_size
user_angle resb variable_size

segment .text

manager:
; Back up GPRs
push    rbp
mov     rbp, rsp
push    rbx
push    rcx
push    rdx
push    rsi
push    rdi
push    r8 
push    r9 
push    r10
push    r11
push    r12
push    r13
push    r14
push    r15
pushf

;Backup the registers other than the GPRs
mov rax,7
mov rdx,0
xsave [backup_storage_area]