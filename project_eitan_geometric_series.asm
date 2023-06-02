.MODEL small
.STACK 100h
.DATA

logo db 13,10,'   '                                                                  
     db 13,10,'   _____                   _       _        _____         _         '
     db 13,10,'  |   __|___ ___ _____ ___| |_ ___|_|___   |   __|___ ___|_|___ ___ '
     db 13,10,'  |  |  | -_| . |     | -_|  _|  _| |  _|  |__   | -_|  _| | -_|_ -:'
     db 13,10,'  |_____|___|___|_|_|_|___|_| |_| |_|___|  |_____|___|_| |_|___|___|'
     db 13,10,' $'
                                                                                      
                                                         

                                                                                                 
 
msg1 db 13,10,'Please insert the first term (a1): $'       ; to get a1 from user
msg2 db 13,10,'Please insert the quotient (q): $'          ; to get q from user
msg3 db 13,10,'Please insert the amount of terms (n): $'   ; to get n from user
msg4 db 13,10,'The full series is: $'                      ; print before printing the full chart
msg5 db 13,10,' $'                                         ; print enter
msg6 db 13,10,'The series is empty. $'                     ; case n=0 
msg7 db 13,10,'Please insert the sign of the chart: $'      ; case n=0 

sign db 0               ; sign ot the chart
a1 db 0                 ; first element of the series
q db 0                  ; quotient of the series
n db 0                  ; amount of elements of the series
an dw 0                 ; holds current element from the series to print it

x dw 0                  ; used to represent every a(n)      - made for the chart printing algorithm
y dw 0                  ; used to represent every a(n+1)    - made for the chart printing algorithm

j db 0                  ; counter for outer loop
k dw 0                  ; counter for middle loop
k1 db 0                 ; counter for the first inner loop
k2 db 0                 ; counter for the second inner loop
                        ; all of them are made for the chart printing algorithm
 
.CODE 

; print ax procedure
; the goal procedure is to print the elements of the series
; before calling the procedure, the program places in ax the value of the current element and the procedure prints it on the screen
; then the program places the next element in ax and prints it, and so on...
; how the procedure works - first it checks if ax=0, if it is so it is just prints '0' and retire, if not it divides ax by 10 in a loop until ax=0 and every phase of the loop it prints the reminder of the division
; at the end of the procedure, all of the registers and variables have the same values has before, and the number that was in ax is now printed on the screen

proc print_ax 
    cmp ax, 0
    jne print_ax_r
    push ax
    mov al, '0'
    mov ah, 0eh
    int 10h                ;this functions displays a character on the screen, advancing the cursor and scrolling the screen as necessary. the printing is always done to current active page.
    pop ax
    ret 
print_ax_r:
    pusha                  ;push all the registers to the stack to keep their original values
    mov dx, 0
    cmp ax, 0
    je pn_done
    mov bx, 10
    div bx                 ;ax = dx:ax div bx, dx = dx:ax mod bx
    call print_ax_r
    mov ax, dx
    add al, 30h
    mov ah, 0eh
    int 10h    
    jmp pn_done
pn_done:
    popa                   ;pop all the registers that were pushed in line 44 to return them
    ret  
endp   
 
 
; procedure for print space char - ' '
; the goal of the procedure is to print ' ' easily and quickly, to ease the program and not make it too long and slow
; in this project there are a lot of uses in this procedure because there are a lot of numbers ans signs to print on the screen and they need to be separated
; the procedure doesn't need parameters, and does not change any registers or variables.
proc print_space 
    mov dl, ' '
    mov ah, 02h
    int 21h
    ret
endp print_space 
          
          
; procedure for print the arrow char for the chart 
; the goal of the procedure is to print the arrow easily and quickly, to ease the program and not make it too long and slow
; in this project there are a lot of uses in this procedure because the goal is to print amount of arrows coordinated for the size of each element in the array
; the procedure doesn't need parameters, and does not change any registers or variables. 
         
proc print_chart_sign 
    mov dl, sign
    mov ah, 02h
    int 21h
    ret
endp print_chart_sign


; procedure for lower 1 line down on the screen - "enter"
; the goal of the procedure is to print the enter easily and quickly, to ease the program and not make it too long and slow
; in this project there are a lot of uses in this procedure because there are a lot of separated lines in the chart
; the procedure doesn't need parameters, and does not change any registers or variables.

proc enter
    lea dx, msg5
    mov ah, 09h
    int 21h 
    ret
endp enter


; procedure for printing first lines of the chart
; this procedure is related to the algorithm I made to print the chart
; but this procedure only prints the first lines of the chart - the lines that are in common for all of the columns - every column has at least a1-times arrows
; before calling the procedure you need to push n - the amount of the array's alements 
; the procedure print an arrow for each element in the first lines - n times, and 5 spaces between every one of them using the print_space procedure
; at the end every register that was being used in the procedure return to his original value

proc first_lines     
    push bp
    mov bp, sp 
    
    push cx
    mov cx, [bp+4]          ; now cx=n
    first_lines_loop:
                        
        call print_chart_sign
        
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
        
        lea dx, logo          ; print logo
        mov ah, 09h
        int 21h
                
        lea dx, msg7          ; print message 'Please insert the sign of the chart: '
        mov ah, 09h
        int 21h
        
        mov ah, 01h           ; get sign as input
        int 21h
        mov sign, al
        
        call enter
                        
        lea dx, msg1          ; print message 'Please insert the first term (a1): '
        mov ah, 09h
        int 21h
        
        mov ah, 01h           ; get a1 as input
        int 21h
        mov a1, al            
        
        lea dx, msg2          ; print message 'Please insert the quotient (q): '
        mov ah, 09h
        int 21h
        
        mov ah, 01h           ; get q as input
        int 21h               
        mov q, al            
        
        lea dx, msg3          ; print message 'Please insert the amount of terms (n): '
        mov ah, 09h
        int 21h
        
        mov ah, 01h           ; get q as input
        int 21h
        mov n, al
        
        cmp al, '0'           ; check a case where n=0 => end program immediately
        jne continue1
        
        lea dx, msg6          ; end program immediately => print 'The series is empty.'
        mov ah, 09h
        int 21h
        
        jmp exit
        
continue1:

        cmp al, '1'           ; check a case where n=1 => print only a1 and end the program
        jne continue2
        
        lea dx, msg4          ; print message 'The full series is: '
        mov ah, 09h
        int 21h
        
        call enter
        call enter      
        
        mov dl, a1            ; print a1
        mov ah, 02h
        int 21h
        
        xor cx, cx
        mov cl, a1
        sub cl, 30h
        
print_arrows_case1:           ; loop for printing the chart only for a1

        call enter
        
        xor dx, dx
        mov dl, sign
        mov ah, 02h
        int 21h        
        
        loop print_arrows_case1                 
        jmp exit       
        
continue2:                    ; main code continue
        
        
        sub a1, 30h           ; transfer a1, q, n for their real values instead of ascii
        sub q, 30h
        sub n, 30h
        
        lea dx, msg4          ; print message 'The full series is: '
        mov ah, 09h
        int 21h
         
        call enter     
        
        xor dx, dx
        xor cx, cx
        mov cl, n             
        dec cl                ; cx = n-1
        mov dl, a1
        mov an, dx
        add dl, 30h           ; dx holds ascii of a1
        mov ah, 02h
        int 21h               ; print a1
         
                
Multiply:
        call print_space      ; print spaces to have distance between the series' elements
        call print_space
        call print_space
        call print_space                 
        mov ax, an            ; ax holds the current elemnt
        mul [q]               ; ax=ax*q  =>  move to next element
        call print_ax 
        mov an, ax

        loop Multiply
        
        
        ; first part finished - the full series is printed.
        
     
        ; prepare for printing chart
        call enter
        
        xor ax, ax
        mov al, a1          ; holds a1 and go on => represents a(n)
        mov x, ax
        mul [q]
        mov y, ax           ; holds a2 and go on => represents a(n+1) 
        
        call enter
        
        xor cx, cx
        mov cl, n
        push cx             
        
        xor cx, cx
        mov cl, a1
first_lines_amount:                  ; loop for printing the lines that all elements have in common - a1 times.
           
        call first_lines
        call enter
        loop first_lines_amount  
         


; the rest of the code is a 3 dimensional loop that is made for printing the chart, it will be fully explained in the README file               
        xor ax, ax 
        mov al, n
        dec al     
        mov j, al        ; j=n-1

outer:                   
        mov ax, y
        mov k, ax
        mov ax, x
        sub k, ax    ;;;;k=y-x
        
        middle:
            cmp k, 0
            je exit
            xor ax, ax 
            mov al, n
            sub al, j
            mov k1, al
            
            inner1:  
            
                 call print_space
                 call print_space
                 call print_space
                 call print_space
                 call print_space
                 call print_space
                 dec k1
                 cmp k1, 1
                 jae inner1
            xor ax, ax 
            mov al, j
            mov k2, al
            
            inner2:
                 call print_chart_sign
                 call print_space
                 call print_space
                 call print_space
                 call print_space
                 call print_space
                 
                 dec k2
                 cmp k2, 1
                 jae inner2
            call enter            
            dec k
            
            cmp k, 1
            jae middle
            
        mov ax, x
        mul [q]
        mov x, ax
            
        mov ax, y
        mul [q]
        mov y, ax            
        dec j
        cmp j, 1
        jae outer
                                                                              
exit:   
             
        mov ax, 4c00h
        int 21h
 
END start 