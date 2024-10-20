bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf  
import exit msvcrt.dll   
import printf msvcrt.dll     
import scanf msvcrt.dll     

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    format db "%c", 0
    format_citire db "%c", 0
    
    sir times 100 db 0 

; our code starts here
segment code use32 class=code
    start:
        mov edi, sir
        mov esi, sir
        bucla: 
            push esi
            push format_citire
            call [scanf]
            add esp, 4*2
            
            cmp byte[esi], ' '
            je final_bucla
            
            cmp byte[esi], ','
            je final_bucla
            
            cmp byte[esi], '.'
            je final_bucla
            
            cmp byte[esi], ';'
            je final_bucla
            
            cmp byte[esi], 10
            je final
            
            inc esi
            jmp bucla
            
            final_bucla:
            mov ecx, esi
            sub ecx, edi
            
            cmp ecx, 0
            je mai_jos1
            
            buclita:
                push ecx
                mov ebx, 0
                mov bl, [edi+ecx-1]
                push ebx
                push format
                call [printf]
                add esp, 4*2
                pop ecx
            loop buclita
            
            mai_jos1:
            mov ebx, 0
            mov bl, [esi]
            push ebx
            push format
            call [printf]
            add esp, 4*2
            inc esi
            mov edi, esi
            
        jmp bucla
        
        final:
        mov ecx, esi
        sub ecx, edi
        
        cmp ecx, 0
        je mai_jos
        
        buclita1:
            push ecx
            mov ebx, 0
            mov bl, [edi+ecx-1]
            push ebx
            push format
            call [printf]
            add esp, 4*2
            pop ecx
        loop buclita1
        mov edi, esi
        
        mai_jos:
        
        push    dword 0      
        call    [exit]      
        
