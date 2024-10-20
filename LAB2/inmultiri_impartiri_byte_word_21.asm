bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a DB 8
    b DB 32
    c DB 7
    d DB 37
    f DW 258
    g DW 259
    e DW 257
    h DW 256

; our code starts here
segment code use32 class=code
    start:
        MOV AX, [f]
        MUL word[g] ; DX:AX=f*g 258*259=66822
        
        push DX
        push AX
        pop EBX
        
        MOV AL, [a]
        MUL byte[b] ; AX=a*b   32*8=256
        MUL word[e] ; DX:AX=AX*e 256*257=65 792.
        
        push DX
        push AX
        pop EAX
        
        SUB EBX, EAX ; EBX=EBX-EAX 66822-65792=1030
        MOV AL, [c]
        MUL byte[d]  ; AX=c*d  7*37=259
        ADD AX, word[h] ; AX=AX+h 259+256=515
        
        MOV word[f], AX
        push EBX
        pop AX
        pop DX
        DIV word[f]   ;EAX=EAX/EBX  1030/515=2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
