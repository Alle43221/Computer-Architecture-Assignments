bits 32 


global start        

extern exit, fread, fopen, fclose, printf             
import exit msvcrt.dll    
import fread msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    mod_deschidere db "r", 0
    format_scriere db "%s", 0
    descriptor dd 0
    text db "bilet18.txt", 0
    sir times 100 db 0

; our code starts here
segment code use32 class=code
    start:
        
        push dword mod_deschidere   ; deschidere cu read mode
        push dword text
        call [fopen]
        add esp, 4*2
        mov [descriptor], eax
        
        cmp eax, 0
        je final
        
        mov ebx, 0
        lea esi, [sir+1]
        bucla:
            push dword[descriptor]    ; citire cu read mode
            push dword 1
            push dword 1
            push dword esi
            call [fread]
            add esp, 4*4
            cmp eax, 0
            je dupa_bucla
            inc ebx
            inc esi
        jmp bucla
        dupa_bucla:
        
        dec esi
        mov ecx, ebx
        bucla1:
            mov ebx, ecx
            push esi
            push dword format_scriere
            call [printf]
            add esp, 4*2
            mov byte[esi], 0
            dec esi
            mov ecx, ebx
        loop bucla1
        
        final:
        
        push dword [descriptor]      ; inchidere fisier cu read_mode
        call [fclose]  
        add esp, 4
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
