section .data
    prompt db 'Enter the first number: ', 0
    prompt_len equ $ - prompt
    
    prompt2 db 'Enter the second number: ', 0
    prompt2_len equ $ - prompt2
    
    result_msg db 'Result: ', 0
    result_msg_len equ $ - result_msg
    
    buffer times 32 db 0

section .text
    global _start

_start:
    
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, prompt_len
    int 0x80

    
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 32
    int 0x80

    
    mov eax, buffer
    call atoi
    mov ebx, eax

    
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, prompt2_len
    int 0x80

    
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 32
    int 0x80

    
    mov eax, buffer
    call atoi

    
    add eax, ebx   
    call itoa_and_print

    sub eax, ebx   
    call itoa_and_print

    imul eax, ebx   
    call itoa_and_print

    cdq   
    idiv ebx   
    call itoa_and_print

exit_program:
    
    mov eax, 1
    xor ebx, ebx
    int 0x80


atoi:
    xor ecx, ecx   

atoi_loop:
    movzx edx, byte [eax + ecx]   

    cmp dl, 0   
    je atoi_done

    sub dl, '0'   

    imul eax, 10   
    add eax, edx   

    inc ecx   
    jmp atoi_loop

atoi_done:
    ret


itoa_and_print:
    push eax   

itoa_convert:
    xor ecx, ecx   

itoa_loop:
    mov edx, 0   
    div dword [ecx]  
    add dl, '0'   
    push dx   
    inc ecx   
    test eax, eax   
    jnz itoa_loop   

itoa_print:
    
    mov eax, 4
    mov ebx, 1
itoa_pop:
    pop dx
    mov byte [buffer + ecx - 1], dl
    int 0x80
    loop itoa_pop

itoa_done:
    pop eax   
    ret
