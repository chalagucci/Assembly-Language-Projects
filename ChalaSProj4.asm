; Project Four
; Chala Smart
; 2/24/23

INCLUDE Irvine32.inc 
WriteString PROTO

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data 
    sourceBYTE "This is the string that will be reversed",0
    targetBYTE SIZEOF  source DUP('#')

.code 
main PROC 
    mov esi,0
    mov edi,LENGTHOF source - 2
    mov ecx,SIZEOF source
L1:
    mov AL,source[esi]
    mov target[edi],AL
    inc esi
    dec edi
    loop L1
    mov edx, OFFSET target
    call WriteString

    invoke ExitProcess, 0
main ENDP
END main



