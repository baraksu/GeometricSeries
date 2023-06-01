.MODEL small
.STACK 100h
.DATA 
msg1 db 13,10,'Please insert the first term (a1): $'
msg2 db 13,10,'Please insert the quotient (q): $'
msg3 db 13,10,'Please insert the amount of terms (n): $'
msg4 db 13,10,'The full series is: $' 
msg5 db 13,10,' $'
 
a1 db 0
q db 0
n db 0 
an dw 0
 
.CODE

print_ax proc
    cmp ax, 0
    jne print_ax_r
    push ax
    mov al, '0'
    mov ah, 0eh
    int 10h
    pop ax
    ret 
print_ax_r:
    pusha
    mov dx, 0
    cmp ax, 0
    je pn_done
    mov bx, 10
    div bx    
    call print_ax_r
    mov ax, dx
    add al, 30h
    mov ah, 0eh
    int 10h    
    jmp pn_done
pn_done:
    popa  
    ret  
endp   


print_space proc
    mov dl, ' '
    mov ah, 02h
    int 21h
    ret
endp print_space


start:       
        mov ax, @data
        mov ds, ax
        
        lea dx, msg1
        mov ah, 09h
        int 21h
        
        mov ah, 01h
        int 21h
        mov a1, al
        
        lea dx, msg2
        mov ah, 09h
        int 21h
        
        mov ah, 01h
        int 21h
        mov q, al
        
        lea dx, msg3
        mov ah, 09h
        int 21h
        
        mov ah, 01h
        int 21h
        mov n, al
        
        sub a1, 30h
        sub q, 30h
        sub n, 30h
        
        lea dx, msg4
        mov ah, 09h
        int 21h
         
        lea dx, msg5
        mov ah, 09h
        int 21h      
        
        xor dx, dx
        xor cx, cx
        mov cl, n
        dec cl
        mov dl, a1
        mov an, dx
        mov dl, a1
        add dl, 30h
        mov ah, 02h
        int 21h 
                
Mult:
        call print_space 
        mov ax, an
        mul [q] ;ax holds the multiplyment
        call print_ax 
        mov an, ax
        loop Mult
                                                                     
exit:   
             
        mov ax, 4c00h
        int 21h
 
END start
