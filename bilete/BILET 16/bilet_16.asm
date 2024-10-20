bits 32 


global start        

extern exit, fread, printf, fopen, fclose               
import exit msvcrt.dll    
import fread msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
import printf msvcrt.dll


segment data use32 class=data
    denumire_fisier db "input16.txt", 0
    mod_deschidere db "r", 0
    format_scriere db "%d", 0
    descriptor dd 0
    text times 100 db 0
    produs dd 0
    numar dd 0

; our code starts here
segment code use32 class=code
    start:
        push dword mod_deschidere
        push dword denumire_fisier
        call [fopen]
        add esp, 4*2
        mov [descriptor], eax
        
        cmp eax, 0
        je final
        
        mov esi, text
        bucla:
            push dword[descriptor]
            push dword 1
            push dword 1
            push dword esi
            call [fread]
            add esp, 4*4
            cmp eax, 0
            je final
            
            cmp byte[esi], '0'
            jb terminat_numar
            cmp byte[esi], '9'
            ja terminat_numar
            
            ;conditii de jump
            
            mov eax, [numar]
            mov ebx, 10
            mul ebx
            mov ebx, 0
            mov bl, [esi]
            sub bl, '0'
            add eax, ebx
            mov [numar], eax
            
            inc esi
            jmp final_bucla
            
            terminat_numar:
            
            cmp dword[numar], 8
            
            jae nu_salva
            
            mov eax, [produs]
            add eax, [numar]
            mov [produs], eax
            
            nu_salva:
            mov esi, text
            mov dword[numar], 0
            
            final_bucla:
            jmp bucla
        final:
        
        cmp esi, text
        je mai_jos
        
        cmp dword[numar], 8
        jae mai_jos
        
        mov eax, [produs]
        add eax, [numar]
        mov [produs], eax
        
        mai_jos:
        push dword[produs]
        push dword format_scriere
        call [printf]
        add esp, 4*2
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
