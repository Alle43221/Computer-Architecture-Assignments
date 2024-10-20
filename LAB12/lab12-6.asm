bits 32
global _concat
extern _sir4

segment data public data use32

segment code public code use32
_concat:
    push ebp
    mov ebp,esp
    
    mov edi, _sir4
    mov esi, [ebp+8]
    
    cld
    repeta:
        lodsb
        cmp al, 0
        je mai_jos
        stosb
        jmp repeta
        mai_jos:
	
    mov esi, [ebp+12]
    
    
    cld
    repeta1:
        lodsb
        cmp al, 0
        je mai_jos1
        stosb
        jmp repeta1
        mai_jos1:
        
    mov esi, [ebp+16]    
        
    cld
    repeta2:
        lodsb
        cmp al, 0
        je mai_jos2
        stosb
        jmp repeta2
        mai_jos2:
        
	mov esp, ebp
	pop ebp
      
    ret