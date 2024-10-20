bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll 
import scanf msvcrt.dll    
import printf msvcrt.dll    

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 010
    b dd 0
    format_citire db "%u", 0
    rez dd 0

; our code starts here
segment code use32 class=code
    start:
        
        push dword b
        push dword format_citire
        call [scanf]
        add esp, 4*2
    
        mov edx, 0
        mov eax, [a]
        div dword[b]
        
        add eax, [a]
        mov [rez], eax
        push dword [rez]
        push dword format_citire
        call [printf]
        add esp, 4*2
        
        
        ; pt b=10 avem 3149642683
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
