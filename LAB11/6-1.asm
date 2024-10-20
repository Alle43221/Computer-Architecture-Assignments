bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program

extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
%include  "module6.asm"
segment data use32 class=data
    a db "abcd", 0
    b db "efghij", 0
    c db "klmnopq", 0
    d times 100 db 0
    adresa dd 0
    format db "rezultat concatenare: %s", 0
    
; our code starts here
segment code use32 class=code

    start:
                      ; offset return  <-ESP
        push dword d  ;      a         <-ESP+4
        push dword a  ;      d         <-ESP+8
         
        call concat
        pop dword[adresa]
        add esp, 4*2
        
        push dword[adresa]
        push dword b  
         
        call concat
        pop dword[adresa]
        add esp, 4*2
        
        push dword[adresa]
        push dword c  
         
        call concat
        pop dword[adresa]
        add esp, 4*2
        
        push dword d
        push dword format
        call [printf]
        add esp, 4*2
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
