bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, fopen, fclose, scanf, fread   
import exit msvcrt.dll   
import printf msvcrt.dll 
import fopen msvcrt.dll   
import fclose msvcrt.dll      
import scanf msvcrt.dll     
import fread msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    format db "%s", 10, 0
    format_citire db "%s", 0
    format_citire1 db "%d", 0
    
    nume_fisier times 10 db 0
    mod_acces db "r", 0
    descriptor_fisier dd 0
    sir times 100 db 0 
    numar dd 0

; our code starts here
segment code use32 class=code
    start:
        push numar
        push format_citire1
        call [scanf]
        add esp, 4*2
        
        push nume_fisier
        push format_citire
        call [scanf]
        add esp, 4*2
        
        ;deschiderea fisierului
        push dword mod_acces
        push dword nume_fisier   ; deschidere input.txt cu mod acces r
        call [fopen]
        add esp, 4*2
        
        mov [descriptor_fisier], eax ; salvam descriptorul pt input.txt
        
        mov edi, 1
        mov esi, sir
        bucla:
            push dword[descriptor_fisier]
            push dword 1
            push dword 1
            push esi
            call [fread]
            add esp, 4*4
            
            cmp eax, 0
            je final1
            
            cmp byte[esi], ' '
            jne final_bucla
            
            mov edx, 0
            mov byte[esi], 0
            mov eax, edi
            inc edi
            div dword[numar]
            cmp edx, 0
            mov esi, sir
            jne bucla
            
            push sir
            push format
            call [printf]
            add esp, 4*2
            jmp bucla
            
            final_bucla:
            inc esi
            
        jmp bucla
        
        final1:
        cmp esi, sir
        je final
        
        mov edx, 0
        mov byte[esi], 0
        mov eax, edi
        inc edi
        div dword[numar]
        cmp edx, 0
        mov esi, sir
        jne final
        
        push sir
        push format
        call [printf]
        add esp, 4*2
        
        final:
        
        push dword[descriptor_fisier] ; inchidere fisier
        call [fclose]
        add esp, 4
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
        
