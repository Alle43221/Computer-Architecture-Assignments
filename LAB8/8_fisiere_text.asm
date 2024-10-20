bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll   
import fopen msvcrt.dll    
import fclose msvcrt.dll    
import fread msvcrt.dll    
import printf msvcrt.dll    

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    mod_afisare db "%c : %d", 0
    nume_fisier db "input.txt", 0
    mod_acces db "r", 0
    descriptor_fisier dd 0
    text resb 100
    dimensiune dd 1
    count dd 100
    lungime db 0
    vector times 26 db 0
    maxim dd 0
    element dd 0

; our code starts here
segment code use32 class=code
    start:
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor_fisier], eax
        mov edi, vector
        
        push dword [descriptor_fisier]
        push dword [count]
        push dword [dimensiune]
        push dword text
        call [fread]
        add esp, 4*4
        
        mov esi, text
        mov ecx, eax
        mov eax, 0
        cld
        jecxz iesire_bucla
        bucla:
            lodsb
            cmp al, 'A'
            jb final_bucla
            cmp al, 'Z'
            ja final_bucla
            
            sub al, 'A'
            inc byte[edi+eax*1]
            
            mov bl, [maxim]
            cmp [edi+eax*1], bl
            jbe final_bucla
            
            mov bl, [edi+eax*1]
            mov [maxim], bl
            
            add eax, 'A'
            mov [element], eax
            
            final_bucla:
            loop bucla
        iesire_bucla:
        
        push dword[maxim]
        push dword[element]
        push mod_afisare
        call [printf]
        add esp, 4*3
	
	push dword[descriptor_fisier]
        call [fclose]
        add esp, 4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
