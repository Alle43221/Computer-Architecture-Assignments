bits 32 


global start        

extern exit, fread, fprintf, fopen, fclose, scanf              
import exit msvcrt.dll    
import fread msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    mod_deschidere db "r", 0
    mod_deschidere1 db "a", 0
    format_scriere db "%d", 0
    format_citire db "%s", 0
    descriptor dd 0
    text times 100 db 0
    numar dd 0

; our code starts here
segment code use32 class=code
    start:
        push dword text
        push dword format_citire
        call [scanf]
        add esp, 4*2
        
        push dword mod_deschidere   ; deschidere cu read mode
        push dword text
        call [fopen]
        add esp, 4*2
        mov [descriptor], eax
        
        cmp eax, 0
        je final
        
        mov ebx, 0
        mov esi, numar
        bucla:
            push dword[descriptor]    ; citire cu read mode
            push dword 1
            push dword 1
            push dword esi
            call [fread]
            add esp, 4*4
            cmp eax, 0
            je final
            inc ebx
        jmp bucla
        final:
        
        push dword [descriptor]      ; inchidere fisier cu read_mode
        call [fclose]  
        add esp, 4
        
        push dword mod_deschidere1   ; deschidere cu append mode
        push dword text
        call [fopen]
        add esp, 4*2
        mov [descriptor], eax
        
        push ebx
        push dword format_scriere     ; append numar
        push dword[descriptor]
        call [fprintf]
        add esp, 4*3
        
        push dword [descriptor]      ; inchidere fisier cu append_mode
        call [fclose]  
        add esp, 4
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
