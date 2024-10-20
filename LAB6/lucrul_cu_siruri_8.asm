bits 32 ; assembling for the 32 bits architecture

global start        

extern exit               
import exit msvcrt.dll    
                         
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s DD 1203_5678h, 1A2C_3C4Dh, 98FC_DC76h, 1233_5678h
    len equ ($-s)/4
    d times len db 0
    unsprezece db 11
    o_suta db 100
    zece db 10
    
    ;Se da un sir de dublucuvinte. Sa se obtina sirul format din octetii inferiori ai
    ;cuvintelor superioare din elementele sirului de dublucuvinte care sunt palindrom in scrierea in baza 10.

; our code starts here
segment code use32 class=code
    start:
        mov esi, s
        mov edi, d
        cld
        mov ecx, len
        repeta:
            lodsw ;cuvantul inferior in AX
            lodsw ;cuvantul superior in AX
                  ;in AL avem octetul inferior
            
            mov bh, 0
            mov bl, al
            CMP bl, 63h ;>99
            JNBE cazul_3_cifre
            CMP bl, 9h  ;>9
            JNBE cazul_2_cifre
            JMP adauga
            
            cazul_2_cifre:
                mov ah, 0
                mov al, bl
                div byte[unsprezece] ;ah:al rest:cat
                cmp ah, 0
                JE adauga
                JMP final
            
            cazul_3_cifre:
                mov ah, 0
                mov al, bl
                div byte[o_suta] ;ah:al rest:cat
                mov dl, al ;nr/100
                
                mov ah, 0
                mov al, bl
                div byte[zece] ;ah:al rest:cat
                mov dh, ah ;nr/100
                
                cmp dh, dl
                JE adauga
                JMP final
            
            adauga:
                mov al, bl
                STOSB 
            final:
            
        loop repeta
        
        push dword 0      
        call [exit]   
