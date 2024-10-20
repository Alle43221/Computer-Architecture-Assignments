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
    format_citire db "%x", 0
    format_scriere_cu_semn db "%d", 0
    format_scriere_fara_semn db "%u", 10, 0
    rez dd 0

; our code starts here
segment code use32 class=code
    start:
        
        push dword rez
        push dword format_citire
        call [scanf]
        add esp, 4*2
        
        push dword [rez]
        push dword format_scriere_fara_semn
        call [printf]
        add esp, 4*2
    
        mov al, [rez]
        cbw 
        cwd
        push word dx
        push word ax
        pop eax
        mov [rez], eax
        push dword [rez]
        push dword format_scriere_cu_semn
        call [printf]
        add esp, 4*2
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
