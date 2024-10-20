bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fprintf, fopen, fclose, scanf  
import exit msvcrt.dll   
import fprintf msvcrt.dll 
import fopen msvcrt.dll   
import fclose msvcrt.dll     
import scanf msvcrt.dll      

; our data is declared here (the variables needed by our program)
segment data use32 class=data

    nume_fisier db "output.txt", 0
    mod_acces db "w", 0
    descriptor_fisier dd 0
    format_scriere db "%d", 10, 0
    format_citire db "%c", 0
    cate dd 0
    max dd 0
    min dd -1
    rezultat dd 1
    numar dd 0
    
    sir times 10 db 0

; our code starts here
segment code use32 class=code
    start:
        ;deschiderea fisierului
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor_fisier], eax ; salvam descriptorul
        
        mov esi, sir
        bucla:
            push esi
            push format_citire
            call [scanf]
            add esp, 4*4
      
            cmp byte[esi], 10
            je final
            
            cmp byte[esi], ' '
            jne mai_jos
            
            mov esi, sir
            mov eax, [numar]
            mov dword[numar], 0
            cmp eax, [max]
            jbe verif_minim
            mov [max], eax
            verif_minim:
            cmp eax, [min]
            jae bucla
            mov [min], eax
            jmp bucla
            
            mai_jos:
            mov edx, 0
            mov eax, [numar]
            mov ebx, 10d
            mul ebx
            mov ebx, 0
            mov bl, [esi]
            sub bl, '0'
            add eax, ebx
            mov [numar], eax
            inc esi
            
        jmp bucla
            
        final:
        
        push dword[max]
        push format_scriere
        push dword[descriptor_fisier]
        call [fprintf]
        add esp, 4*3
        
        push dword[min]
        push format_scriere
        push dword[descriptor_fisier]
        call [fprintf]
        add esp, 4*3
        
        mov eax, [max]
        mov edx, 0
        mov ebx, [min]
        mul ebx
        mov [rezultat], eax
        
        push dword[descriptor_fisier] ; inchidere fisier
        call [fclose]
        add esp, 4
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
        
