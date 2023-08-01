section .data
filename db "timeLog.txt", 0 ; file name
buffer db "Current time: %s", 10, 0 ; text to write

section .text
global _start

_start:
; open the file
mov rax, 2
mov rdi, filename
mov rsi, 0x41 ; O_WRONLY
mov rdx, 0x1b6 ; 0666
syscall

; write the current time
mov rax, 0x2000004
mov rdi, rax
lea rsi, [rel buffer]
mov rdx, 0x1f ; size of buffer
syscall

; close the file
mov rax, 0x2000001
mov rdi, rax
syscall

; wait 10 minutes
mov rax, 0x2000003
mov rdi, 0
mov rsi, 600
syscall

jmp _start