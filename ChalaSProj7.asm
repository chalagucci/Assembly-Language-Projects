; Project 7
; Chala Smart
; 3/25/23

INCLUDE Irvine32.inc

.data 
            msg1 BYTE "Enter the multiplicand: ", 0
            msg2 BYTE "Enter the multiplier: ", 0
            msg3 BYTE "The product is: ", 0
            msg4 BYTE "Do you want to do another calculation? y/n (all lower case): ", 0
            msgError BYTE "The function implementation is wrong", 0
            msgRight BYTE "The function implementation is right", 0

.code
main PROC

do_again:
        mov edx, offset msg2            ;get multiplier from user
        call WriteString
        call ReadInt
        mov ebx, eax                    ; store multiplier in ebx

        mov edx, offset msg1            ; get multiplier from user
        call WriteString
        call ReadInt                    ; multiplicand stored in eax

        call Crlf

        call BitWiseMultiply            ; call BitWiseMultiply function
        mov edx, offset msg3            ; display result
        call WriteString
        call WriteDec
        call Crlf

        mov edx, offset msg4            ; ask if user want to do another calculation
        call WriteString
        call ReadChar

        call Crlf                       ; print out a new line

        cmp al, 'y'
        je do_again
        cmp al, 'Y'
        je do_again                     ; if y or Y, jump to do_again

        call TestBitWiseMultiply        ; do automatic test

        call WaitMsg                    ; press any key to continue
        exit 
Main ENDP

BitWiseMultiply PROC
        push edx
        push ebx
        push ecx

        mov edx, eax                    ; let edx hold the multiplicand
        mov ecx, 16
        mov eax, 0                      ; start from 0
L:
        test ebx, 00000001h             ; if last bit in ebx is 1, add edx to eax
        jz NO_ADD                       ; else jump to no add
        add eax, edx
NO_ADD:
        sh1 edx, 1                      ; shift multiplicant to left 1 bit
        shr ebx, 1
        loop L1

        pop ecx
        pop ebx
        pop edx
        ret 
BitWiseMultiply ENDP

TestBitWiseMultiply PROC
        pushad 
        mov eax, 1364
        mov ebx, 0                      ; test boundary case
        call BitWiseMultiply
        cmp eax, 0
        jne NOT_RIGHT

        mov eax, 1234
        mov ebx, 1                      ; test special case
        call BitWiseMultiply
        cmp eax, 1234
        jne NOT_RIGHT

        mov eax, 5678                   ; test any case
        mov ebx, 8765
        call BitWiseMultiply
        cmp eax, 49767670
        jne NOT_RIGHT
        
        mov edx, offset msgRight        ; display right message
        call WriteString
        call Crlf
        jmp RIGHT 

NOT_RIGHT:
        mov edx, offset msgError
        call WriteString
        call Crlf

RIGHT:
        popad 
        ret 
TestBitWiseMultiply ENDP
END main

        
        