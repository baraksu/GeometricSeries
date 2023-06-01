.MODEL small
.STACK 100h
.DATA 
msg1 db 13,10,'Please insert the first term (a1): $'
msg2 db 13,10,'Please insert the quotient (q): $'
msg3 db 13,10,'Please insert the amount of terms (n): $'
msg4 db 13,10,'The full series is: $' 
msg5 db 13,10,' $'
msg6 db 13,10,'The series is empty. $' 
 
a1 db 0
q db 0
n db 0 
an dw 0 
i db 1
x dw 0
y dw 0
minus dw 0

 
.CODE

proc print_ax 
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


proc print_space 
    mov dl, ' '
    mov ah, 02h
    int 21h
    ret
endp print_space 

proc print_arrow 
    mov dl, 1Fh
    mov ah, 02h
    int 21h
    ret
endp print_arrow

proc enter
    lea dx, msg5
    mov ah, 09h
    int 21h 
    ret
endp enter


proc first_lines     ;before calling need to push n
    push bp
    mov bp, sp 
    push cx
    mov cx, [bp+4]     
    first_lines_loop:
                        
        call print_arrow
        
        call print_space
        call print_space
        call print_space
        call print_space
        call print_space                
                
        loop first_lines_loop
    pop cx
    pop bp    
    ret
endp first_lines
    
    


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
        
        cmp al, '0'         ; check if n=0 => end program imdtly
        jne continue1
        
        lea dx, msg6
        mov ah, 09h
        int 21h
        
        jmp exit
        
continue1:

        cmp al, '1'         ; check if n=1 => print only a1 and end program
        jne continue2
        
        lea dx, msg4
        mov ah, 09h
        int 21h
        
        call enter      
        
        mov dl, a1
        mov ah, 02h
        int 21h
        
        xor cx, cx
        mov cl, a1
        sub cl, 30h
        
print_arrows_case1:

        call enter
        
        mov dx, 1Fh
        mov ah, 02h
        int 21h        
        
        loop print_arrows_case1                 
        jmp exit       
        
continue2:
        
        
        sub a1, 30h
        sub q, 30h
        sub n, 30h
        
        lea dx, msg4
        mov ah, 09h
        int 21h
         
        call enter     
        
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
         
                
Multiply:
        call print_space
        call print_space
        call print_space
        call print_space                 
        mov ax, an
        mul [q] ;ax holds the multiplyment
        call print_ax 
        mov an, ax

        loop Multiply
     
        ; prepare for printing chart
        call enter
        
        xor ax, ax
        mov al, a1   ;holds a1 and go on
        mov x, ax
        mul [q]
        mov y, ax   ;holds a2 and go on 
        
        call enter
        
        xor cx, cx
        mov cl, n
        push cx
        
        xor cx, cx
        mov cl, a1
first_lines_amount:
           
        call first_lines
        call enter
        loop first_lines_amount                   
    
        
        xor cx, cx
        mov cl, n
        dec cl
        push cx
print_line_types:
        mov ax, y
        mov minus, ax
        mov ax, x
        sub minus, ax
        mov cx, minus
        inc cx
        push cx
        spaces_and_arrows_amount:
            xor cx, cx
            mov cl, i
            spaces:
                call print_space
                call print_space
                call print_space
                call print_space
                call print_space
                call print_space
                loop spaces
            xor ax, ax
            mov al, n
            sub al, i
            mov cx, ax
            arrows:
                call print_arrow
                call print_space
                call print_space
                call print_space
                call print_space
                call print_space
                loop arrows
            call enter
            pop cx
            sub cl, i
            
            loop spaces_and_arrows_amount 
   
        mov ax, x
        mul [q]
        mov x, ax
        
        mov ax, y
        mul [q]
        mov y, ax
        pop cx 
        inc i
        loop print_line_types                 
                
                                                                              
exit:   
             
        mov ax, 4c00h
        int 21h
 
END start 

