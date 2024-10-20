bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll   
import fopen msvcrt.dll    
import fclose msvcrt.dll    
import fprintf msvcrt.dll    

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    mod_afisare db "%x", 10, 0
    nume_fisier db "output.txt", 0
    mod_acces db "w", 0
    descriptor_fisier dd 0
    high_word db 0
    low_word db 0
    
    valoare dw 0BCAFh

; our code starts here
segment code use32 class=code
    start:
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor_fisier], eax
        mov esi, valoare
        mov edx, 0
        cld
        
        lodsb
        mov [high_word], al
        lodsb
        mov [low_word], al
        
         mov bl, [low_word]
         shr bl, 4
            
         push ecx
            
         mov dl, bl
         push edx
         push mod_afisare
         push dword[descriptor_fisier]
         call [fprintf]
         add esp, 4*3
            
         mov bl, [low_word]
         shl bl, 4
         shr bl, 4
         mov dl, bl
         push edx
         push mod_afisare
         push dword[descriptor_fisier]
         call [fprintf]
         add esp, 4*3
         pop ecx
        
      
        
         mov bl, [high_word]
         shr bl, 4
            
         push ecx
            
         mov dl, bl
         push edx
         push mod_afisare
         push dword[descriptor_fisier]
         call [fprintf]
         add esp, 4*3
            
         mov bl, [high_word]
         shl bl, 4
         shr bl, 4
         mov dl, bl
         push edx
         push mod_afisare
         push dword[descriptor_fisier]
         call [fprintf]
         add esp, 4*3
         pop ecx
         
        push dword[descriptor_fisier]
        call [fclose]
        add esp, 4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
