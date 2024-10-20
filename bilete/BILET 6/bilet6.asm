bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf       
import exit msvcrt.dll    
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    denumire_fisier db "input.txt", 0
    mod_acces db "r", 0
    descriptor_fisier dd 0
    format_scriere db "%s - %d", 10, 0
    cate dd 2
    dimensiune dd 1
    cifra dd 0

; our code starts here
segment code use32 class=code
    start:
        push dword mod_acces
        push dword denumire_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor_fisier], eax
        cmp eax, 0
        je final
        
        bucla:
            push dword [descriptor_fisier]
            push dword [cate]
            push dword [dimensiune]
            push dword cifra
            call [fread]
            add esp, 4*4
        
            cmp eax, 0
            je final
            
            mov ecx,0 ; cati biti de 1
            mov eax, 0
            mov al, [cifra]
            
            cmp al, 'A'
            jb scadere
            sub al, 7h
            
            scadere:
            sub al, 30h
            
            bucla1:
            mov bl, 2
            div bl
            add cl, ah
            mov ah, 0
            cmp al, 0
            jne bucla1
            
            mov byte[cifra+1], 0
            push dword ecx
            push dword cifra
            push dword format_scriere
            call [printf]
            add esp, 4*3
        
            jmp bucla
            
        final:
        push dword [descriptor_fisier]
        call [fclose]
        add esp, 4
        
      
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
