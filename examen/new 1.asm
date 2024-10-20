bits 32
 
global start

extern exit, fclose, fopen, fread, scanf, printf            
import exit msvcrt.dll    
import fclose msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    format_citire db "%d", 0
    format_citire1 db "%s", 0
    open_mode db "r", 0
    
    format_afisare db "%d", 10, 0
    format_afisare1 db "-%d", 10, 0
    
    descriptor_fisier dd 0
    nume_fisier times 20 db 0
    
    intreg dd 0
    numar dd 0
    sir times 10 db 0
	
segment code use32 class=code
    start:
        push numar
        push format_citire  ; citire nr 
        call [scanf]
        add esp, 4*2
        
        push nume_fisier
        push format_citire1  ; citire nume fisier
        call [scanf]
        add esp, 4*2
        
        push open_mode
        push nume_fisier     ; deschidere fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor_fisier], eax
        
        cmp eax, 0
        je final
        
        mov esi, sir
        bucla:
            push dword[descriptor_fisier]
            push 1
            push 1
            push esi 
            call[fread]
            add esp, 4*4
            
            cmp eax, 0
            je final
            
            cmp byte[esi], ' '
            jne mai_jos
            
            cmp esi, sir
            mov ebx, esi
            mov esi, sir
            je bucla
            
            sub ebx, sir
            cmp byte[sir], '-'
            jne pas_urmator
            dec ebx
            pas_urmator:
            cmp ebx, [numar]
            mov edi, [intreg]
            mov dword[intreg], 0
            jne bucla
            mov ebx, edi
            mov eax, ebx
            and ebx, 01
            cmp ebx, 0
            je bucla
            
            cmp byte[sir], '-'
            je mai_jos2
            push eax
            push format_afisare
            call [printf]
            add esp, 4*2
            jmp bucla
            
            mai_jos2:
            push eax
            push format_afisare1
            call [printf]
            add esp, 4*2
            jmp bucla
            
            mai_jos:
            cmp byte[esi], '-'
            je si_mai_jos
            
            mov eax, [intreg]
            mov edx, 0
            mov ebx, 10
            mul ebx
            mov ebx, 0
            mov bl, [esi]
            sub ebx, '0'
            add eax, ebx
            mov [intreg], eax
            
            si_mai_jos:
            inc esi
            
        jmp bucla
        final:
        
        cmp esi, sir
        mov ebx, esi
        mov esi, sir
        je inchidere
        
        sub ebx, sir
        cmp byte[sir], '-'
        jne pas_urmator1
        dec ebx
        pas_urmator1:
        cmp ebx, [numar]
        jne inchidere
        mov ebx, [intreg]
        mov dword[intreg], 0
        mov eax, ebx
        and ebx, 01
        cmp ebx, 0
        je inchidere
        
        cmp byte[sir], '-'
        je mai_jos3
        push eax
        push format_afisare
        call [printf]
        add esp, 4*2
        jmp inchidere
        mai_jos3:
        push eax
        push format_afisare1
        call [printf]
        add esp, 4*2
        
        inchidere:
    	push dword[descriptor_fisier]    ; inchidere fisier
        call [fclose]  
        add esp, 4
        
        push    dword 0      
        call    [exit]       
