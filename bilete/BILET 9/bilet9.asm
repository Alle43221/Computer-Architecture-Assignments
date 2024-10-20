bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fprintf, fopen, fclose, scanf, fread   
import exit msvcrt.dll   
import fprintf msvcrt.dll 
import fopen msvcrt.dll   
import fclose msvcrt.dll      
import scanf msvcrt.dll     
import fread msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    format db "%c", 0
    format2 db "%d", 0
    format_citire db "%s", 0
    
    nume_fisier times 10 db 0
    nume_fisier2 db "output.txt", 0
    mod_acces2 db "w", 0
    mod_acces db "r", 0
    descriptor_fisier dd 0
    descriptor_fisier2 dd 0
    sir db 0

; our code starts here
segment code use32 class=code
    start:
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
        
        push dword mod_acces2
        push dword nume_fisier2   ; deschidere output.txt cu mod acces w
        call [fopen]
        add esp, 4*2
        
        mov [descriptor_fisier2], eax ; salvam descriptorul pt output.txt
        
        bucla:
            push dword[descriptor_fisier]
            push dword 1
            push dword 1
            push sir
            call [fread]
            add esp, 4*4
            
            cmp eax, 0
            je final
            
            cmp byte[sir], 'a'
            jb mai_jos
            cmp byte[sir], 'z'
            ja mai_jos
            
            mov ebx, 0
            mov bl, [sir]
            push ebx
            push format2
            push dword[descriptor_fisier2]
            call [fprintf]
            add esp, 4*3
            jmp bucla
            
            mai_jos:
            mov ebx, 0
            mov bl, [sir]
            push ebx
            push format
            push dword[descriptor_fisier2]
            call [fprintf]
            add esp, 4*3
            
        jmp bucla
        
        final:
        
        push dword[descriptor_fisier] ; inchidere fisier
        call [fclose]
        add esp, 4
        
        push dword[descriptor_fisier2] ; inchidere fisier
        call [fclose]
        add esp, 4
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
        
