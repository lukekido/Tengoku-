section .data
    filename db "window_names.txt", 0
    filemode db "w", 0
 buffer_size equ 256

section .bss
    hwnd_buffer resq 1
    window_name_buffer resb buffer_size

section .text
    extern GetWindowTextA
    extern GetForegroundWindow
    extern fopen
    extern fprintf
    extern fclose

global _start

_start:
    ; Open the text file for writing
 mov rdi, filename
    mov rsi, filemode
    call fopen
    mov qword [hwnd_buffer], rax

 ; Loop forever
loop_forever:
    ; Get the handle of the foreground window
    call GetForegroundWindow
    mov qword [hwnd_buffer], rax

    ; Get the window name
    mov rdi, qword [hwnd_buffer]
    mov rsi, window_name_buffer
    mov edx, buffer_size
    call GetWindowTextA

    ; Write the window name to the text file
    mov rdi, qword [hwnd_buffer]
    mov rsi, window_name_buffer
    mov rdx, qword [hwnd_buffer]
    call fprintf

    ; Sleep for a short period of time (e.g., 1 second)
    mov ecx, 1000
    call Sleep

    ; Jump back to the beginning of the loop
    jmp loop_forever

exit_program:
    ; Close the text file
    mov rdi, qword [hwnd_buffer]
    call fclose

    ; Exit the program
    mov eax, 0x60
    xor edi, edi
    syscall
