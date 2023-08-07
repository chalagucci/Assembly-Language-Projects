;Problem Two
;Write code that defines symbolic constants for all seven days of the week. Create an array variable that uses the symbols as initializers

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, 
dwExitCode:dword

.data

SuNDAY = 0
MONDAY = 1
TUESDAY = 2
WEDNESDAY = 3
THURSDAY = 4
FRIDAY = 5
SATURDAY = 6

daysArr BYTE SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY


;Problem Three
;The program must contain a definition of each data type listed in Table 3.2 in Section 3.4 of the textbook. 
;Initialize each variable to a value that is consistent with its data type

valueByte BYTE 255
valueSByte SBYTE -128
valueWord WORD 65535
valueSWord SWORD -32768
valueDWord DWORD 12345678h
valueSDWord SDWORD -2147483648
valueFWord FWORD 0
valueQWord QWORD 1234567812345678h
valueTByte TBYTE 800000000000001234h
valueReal4 REAL4 -1.2
valueReal8 REAL8 3.2E-260
valueReal10 REAL10 4.6E+4096

;Problem Four
;Write code defines symbolic names for several string literals. Use each symbolic name in a variable definition

str1 EQU < "Imogen",0>
str2 EQU <"Amelia",0>
str3 EQU <"Violet",0>

firstWord BYTE str1
secondWord BYTE str2
thirdWord BYTE str3

.code
main proc


;Problem One
; Using the AddTwo program from Section 3.2 as a reference, 
;write code to calculate the following expression, using registers: A = (A+B)-(C+D). 
;Assign integer values to the EAX, EBX, ECX, and EDX registers 

        mov eax, 5
        mov ebx, 4
        mov ecx, 3
        mov edx, 2

        add eax, ebx
        add ecx, edx
        sub eax, ecx

        invoke ExitProcess,0
main endp
end main