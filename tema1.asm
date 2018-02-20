%include "io.inc"

section .data
%include "input.inc"


global CMAIN
convert:
    push ebp
    mov ebp,esp
    
    mov eax,[ebp + 12]
    mov ebx,[ebp + 8]
    xor ecx,ecx
    
    mov edx,16
    cmp ebx,edx
    jg incorect
    
    mov edx,2
    cmp ebx,edx
    jge flag

incorect:   
    PRINT_STRING "Baza incorecta"
    
    leave
    ret
    
flag:
    xor edx,edx
    div ebx
    push edx
    inc ecx
    test eax,eax
    jnz flag
    
print:
    pop eax
    mov ebx,10
    
    cmp eax,ebx
    jge print_char
    jl print_number
    
   

print_char:
    add eax,87
    PRINT_CHAR eax
    dec ecx
    test ecx,ecx
    jnz print
    jmp fin
    
print_number:
    add eax,48
    PRINT_CHAR eax
    dec ecx
    test ecx,ecx
    jnz print
        
fin:
    leave
    ret
    
CMAIN:
    mov ebp, esp
    xor edx, edx
    xor ecx,ecx
    xor ebx,ebx
    
salt:
    push ebx
    mov eax,[nums_array + ebx*4]
    push eax
    mov eax, [base_array + ebx*4]
    push eax
    call convert
    NEWLINE
    pop eax
    pop eax
    
    pop ebx
    inc ebx
    mov ecx,[nums]
    
    cmp ebx,ecx
    jl salt
    
    
    xor eax, eax
    ret
