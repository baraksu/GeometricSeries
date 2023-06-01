.MODEL small
.STACK 100h
.DATA 
msg1 db 13,10,'Please insert the first term (a1): $'
msg2 db 13,10,'Please insert the quotient (q): $'
msg3 db 13,10,'Please insert the amount of terms (n): $'
msg4 db 13,10,'The full series is: $'
a1 db 0
q db 0
n db 0
 
.CODE
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
exit:   
             
        mov ax, 4c00h
        int 21h
 
END start