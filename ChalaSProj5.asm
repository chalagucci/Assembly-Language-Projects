; Project 5
; Chala Smart
; 3/4/23

INCLUDE Irvine32.inc

L = 10

.data 
       randomString BYTE L DUP (?)
.code
main PROC
        call Clrscr
        mov     eax, L
        mov     esi, OFFSET randomString
        mov     ecx, 20
GenerateStrings:
        call   GenerateRandomString
        mov   edx, OFFSET randomString
        call WriteString
        call Crlf
loop GenerateStrings
        exit 
main ENDP

GenerateRandomString PROC USES eax ecx esi
         mov      ecx, eax
GenerateChar: 
         mov      eax, 26
         call randomRange 
         add      eax, 65
         mov      [esi], eax
         inc  esi
loop GenerateChar
         mov    eax, 0
         mov    [esi], eax
         ret 
GenerateRandomString ENDP
END main 
