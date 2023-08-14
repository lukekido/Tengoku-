global GetNumberOfProcesses

section .text
GetNumberOfProcesses:
    ; Get the number of processes running on the system
    mov rax, 600
    mov rdi, 0
    syscall

    ; Return the number of processes
    ret

    ; OMG I have no idea where I'd store it, as I have no idea how to call an overlay on WindowsAPI using purely ASM.