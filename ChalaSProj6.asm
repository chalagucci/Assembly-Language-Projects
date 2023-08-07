; Project 6
; Chala Smart
; 3/21/23

INCLUDE Irvine32.inc

.data
msgMenu BYTE "---- Boolean Calculator ----",0dh,0ah
        BYTE 0dh, 0ah
        BYTE "1. x AND y"       ,0dh,0ah
        BYTE "2. x OR y"        ,0dh,0ah
        BYTE "3. NOT x"         ,0dh,0ah
        BYTE "4. x XOR y"       ,0dh,0ah
        BYTE "5. Exit program"  ,0dh,0ah,10
        BYTE "Enter integer: ", 0

        msgAND BYTE "Boolean AND",0
        msgOR BYTE "Boolean OR",0
        msgNOT BYTE "Boolean NOT",0
        MsgXOR BYTE "Boolean XOR",0

        msgOperand1 BYTE "Input the first 32-bit hexadecimal operand:  ",0
        msgOperand2 BYTE "Input the second 32-bit hexadecimal operand: ",0
        msgResult BYTE "The 32-bit hexadecimal result is:              ",0
        msgError BYTE "No such a option. Please choose from 1 -- 5:    ",0

        
        CaseTable BYTE '1'           ; lookup value
        DWORD AND_op
        EntrySize = ($ - caseTable)
        BYTE '2'
        DWORD OR_op
        BYTE '3'
        DWORD NOT_op
        BYTE '4'
        DWORD XOR_op
        BYTE '5'
        DWORD Exit_Program
        NumberOfEntries = ($ - caseTable)/ EntrySize

.code

main PROC
Display_Menu:
        mov edx, OFFSET msgMenu         ; display menu
        call WriteString

Get_Choice:
        call ReadChar 
        call WriteChar 
        mov ebx, OFFSET caseTable
        mov ecx, NumberOfEntries
Loop_CaseTable:                         ; loop through casetable
        cmp al, [ebx]                   ; compare choice with casde
        jne Not_Match                         
        call Near PTR[ebx+1]            ; if there is a match (1-4) call corresponding
        call Crlf           
        jmp Display_Menu                              
Mot_Match:                              ; if not match, increase ebx appropriately and loop back to Loop_Case table
     add ebx, EntrySize
     loop Loop_CaseTable

     cmp al, '5'                        
     je Exit_Program                    ; if the choice is '5', jump to ExitProgram
     mov edx, OFFSET msgError                  ; display wrong choice message and jump back
     call WriteString
     jmp Get_Choice
ExitProgram:
     exit
main ENDP

AND_op PROC
        pushad 

        mov edx, OFFSET msgAND
        call WriteString
        call Crlf
        call Crlf

        mov edx, OFFSET msgOperand1
        call WriteString
        call ReadHex
        mov ebx, eax  

        mov edx, OFFSET msgOperand2
        call WriteString
        call ReadHex 

        and eax, ebx

        mov edx, OFFSET msgResult
        call WriteString
        call WriteHex
        call Crlf

    popad 
    ret

AND_op ENDP

OR_op PROC
        pushad

        mov edx, OFFSET msgOR
        call WriteString
        call Crlf
        call Crlf

        mov edx, OFFSET msgOperand1
        call WriteString
        call ReadHex
        mov ebx, eax

        mov edx, OFFSET msgOperand2
        call WriteString
        call ReadHex

        or eax, ebx

        mov edx, OFFSET msgResult
        call WriteString
        call WriteHex
        call Crlf

    popad 
    ret

OR_op ENDP

NOT_op PROC
        pushad

        mov edx, OFFSET msgNOT
        call WriteString
        call Crlf
        call Crlf

        mov edx, OFFSET msgOperand1
        call WriteString
        call ReadHex

        not eax

        mov edx, OFFSET msgResult
        call WriteString
        call WriteHex
        call Crlf

    popad   
    ret

NOT_op ENDP

XOR_op PROC
        pushad

        mov edx, OFFSET MsgXOR
        call WriteString
        call Crlf
        call Crlf

        mov edx, OFFSET msgOperand1
        call WriteString
        call ReadHex
        mov ebx, eax

        mov edx, OFFSET msgOperand2
        call WriteString
        call ReadHex

        xor eax, ebx

        mov edx, OFFSET msgResult
        call WriteString
        call WriteCharHex
        call Crlf

        popad 
        ret

XOR_op ENDP

ExitProgram PROC

	stc							; set the carry flag to 1
	ret							; return from procedure

ExitProgram ENDP

END main
