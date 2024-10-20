bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fprintf, scanf, fopen, fclose
import exit msvcrt.dll   
import fprintf msvcrt.dll     
import scanf msvcrt.dll 
import fopen msvcrt.dll
import fclose msvcrt.dll    

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    format db "%c", 0
    format_citire db "%c", 0
    denumire db "string.txt", 0
    mode db "w", 0
    descriptor_fisier dd 0
    cate dd 0
    sir times 100 db 0 

; our code starts here
segment code use32 class=code
    start:
        mov esi, sir
        buclita:
            push esi
            push format_citire
            call [scanf]
            add esp, 4*2
            inc esi
            cmp byte[esi-1], 10
        jne buclita

        push mode
        push denumire
        call [fopen]
        add esp, 4*2
        mov [descriptor_fisier], eax
        
        dec esi
        dec esi
        mov ecx, esi
        sub ecx, sir
        inc ecx
        mov [cate], ecx
        bucla:  
            push ecx
            cmp byte[esi], ' '
            je final_bucla
            
            cmp byte[esi], ','
            je final_bucla
            
            cmp byte[esi], '.'
            je final_bucla
            
            cmp byte[esi], ';'
            je final_bucla
            
            cmp byte[esi], 'A'
            jb final_bucla
            cmp byte[esi], 'Z'
            ja final_bucla
            
            mov ebx, 0
            mov bl, [esi]
            push ebx
            push format
            push dword[descriptor_fisier]
            call [fprintf]
            add esp, 4*3
            
            final_bucla:
            dec esi
            pop ecx
            
        loop bucla
        
        mov ecx, [cate]
        mov esi, sir
        add esi, [cate]
        dec esi
        bucla1:  
            push ecx
            cmp byte[esi], ' '
            je final_bucla1
            
            cmp byte[esi], ','
            je final_bucla1
            
            cmp byte[esi], '.'
            je final_bucla1
            
            cmp byte[esi], ';'
            je final_bucla1
            
            cmp byte[esi], 'a'
            jb final_bucla1
            cmp byte[esi], 'z'
            ja final_bucla1
            
            mov ebx, 0
            mov bl, [esi]
            push ebx
            push format
            push dword[descriptor_fisier]
            call [fprintf]
            add esp, 4*3
            
            final_bucla1:
            dec esi
            pop ecx
            
        loop bucla1
        
        final:
        
        push dword[descriptor_fisier]
        call [fclose]
        add esp, 4
        
        push    dword 0      
        call    [exit]      
        
