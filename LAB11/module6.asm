
%ifndef  _MODULE6_ASM_

%define  _MODULE6_ASM_ 

; our code starts here
segment code use32 class=code
    concat:
        
        mov edi, [esp+8]
        mov esi, [esp+4]
        cld
        repeta:
            lodsb
            cmp al, 0
            je mai_jos
            stosb
            jmp repeta
            mai_jos:
            mov [esp+4], edi
        ret

%endif