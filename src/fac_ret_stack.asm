%include "io.inc"
section .data
    message db "The factorial of 0x%08X ist 0x%08X", 10, 0
section .text

;    retval = fac(n)
;
; 'retval': returned over the _stack_, not in a register.
;   * Calling code allocates 4 bytes on the stack beforehand
;   * fac function then writes return value to this memory location
;
; Parameter 'n' is passed on the stack
;

fac:
    push ebp
    mov ebp, esp
    push eax
    push ecx
    mov ecx, [ebp + 8]
    cmp ecx, 1
    je end_recursion
    sub esp, 4
    sub ecx, 1
    push ecx
    call fac
    mov ecx, [esp + 4]
    add esp, 8
    mov eax, [ebp + 8]
    mul ecx
    mov [ebp + 12], eax
    jmp end
    
end_recursion:
    mov dword [ebp + 12], 1
    jmp end
     
end:
    pop ecx
    pop eax
    mov esp, ebp
    pop ebp
    ret

global main
extern printf
main:
    mov ebp, esp; for correct debugging
    mov eax, 0xffffffff
    mov ebx, 0xffffffff
    mov ecx, 0xffffffff
    mov edx, 0xffffffff

    sub esp, 4  ; Allocate memory for return value
    push 1      ; n=1
    call fac
     
    push message
    call printf
    add esp, 12
    
    sub esp, 4  ; Allocate memory for return value
    push 2      ; n=2
    call fac
    
    push message
    call printf
    add esp, 12
    
    sub esp, 4  ; Allocate memory for return value
    push 3      ; n=3
    call fac
    
    push message
    call printf
    add esp, 12
 
    sub esp, 4  ; Allocate memory for return value
    push 4      ; n=4
    call fac
    
    push message
    call printf
    add esp, 12
 
    sub esp, 4  ; Allocate memory for return value
    push 5      ; n=5
    call fac
    
    push message
    call printf
    add esp, 12
 
    ret
