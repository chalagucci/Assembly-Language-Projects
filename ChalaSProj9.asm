; Project 9
; Chala Smart
; 4/27/23

Include Irvine32.inc

Str_find PROTO, pTarget:PTR BYTE, pSource:PTR BYTE



.data

source BYTE 32 DUP(0)
target BYTE 32 DUP(0)
userSelection BYTE 32 DUP(0)
yesString1 BYTE "Y",0
yesString2 BYTE "y",0
noString1 BYTE "N",0
noString2 BYTE "n",0

enterSource BYTE "Enter source string (the string to search for): ",0
enterTarget BYTE "Enter target string (the string to search from): ",0
sourceFound BYTE "Source string found at position ",0
inTarget BYTE " in Target string (counting from zero).",0Ah,0Ah,0Dh,0
stringNotFound BYTE "Unable to find Source string in Target string.",0Ah,0Ah,0Dh,0
againString BYTE "Do you want to do another search? y/n: ",0
invalidSelection BYTE "That was not a valid selection, please try again.",0

stop DWORD ?
targetLength DWORD ?
sourceLength DWORD ?
position DWORD ?

.code
main PROC
start:
	call Crlf;
	mov EDX, OFFSET enterSource
	call WriteString
	mov EDX,OFFSET source
	mov ECX,SIZEOF source
	call ReadString
	
	mov EDX, OFFSET enterTarget
	call WriteString
	mov EDX,OFFSET target
	mov ECX,SIZEOF target
	call ReadString

	INVOKE Str_find,ADDR target, ADDR source
	mov position, eax				; keep track of the position value
	jz wasfound						; ZF = 1 denotes that a string was found.
	
	mov EDX,OFFSET stringNotFound	; string is not found
	call WriteString
	jmp again
	
wasfound:					
	mov EDX,OFFSET sourceFound
	call WriteString
	mov eax,position				; writing the position value
	call WriteDec
	mov edx,OFFSET inTarget
	call WriteString
	
again:							
	mov EDX,OFFSET againString
	call WriteString
	mov EDX,OFFSET userSelection
	mov ECX,SIZEOF userSelection
	call ReadString
	INVOKE Str_compare, ADDR yesString1, ADDR userSelection		; Look for the letter "Y"
	je start
	INVOKE Str_compare, ADDR yesString2, ADDR userSelection		; Look for the letter "y"
	je start
	INVOKE Str_compare, ADDR noString1, ADDR userSelection		; Look for the letter "N"
	je quit
	INVOKE Str_compare, ADDR noString2, ADDR userSelection		; Look for the letter "n"
	je quit
	call Crlf
	mov EDX,OFFSET invalidSelection							
	call WriteString
	call Crlf
	jmp again

quit:
   exit

main ENDP


Str_find PROC,
	pTarget:PTR BYTE,			
	pSource:PTR BYTE
	
	INVOKE Str_length,pTarget	; get the length of the target
	mov targetLength,eax
	INVOKE Str_length,pSource	; get the length of the source
	mov sourceLength,eax
	
	mov edi,OFFSET target		; point to target
	mov esi,OFFSET source		; point to source

	mov eax,edi					; stopping at (offset target)
	add eax,targetLength		
	sub eax,sourceLength			
	inc eax						
	mov stop,eax				; keep stopping position
	
	
	cld
	mov ecx,sourceLength			; the length of the source string
L1:
	pushad
	repe cmpsb					
	popad
	je found					; if found, exit
	
	inc edi						; move to next target position
	cmp edi,stop				 
	jae notfound				
	jmp L1						
	
notfound:						
	or eax,1					; ZF = 0 indicates failure
	jmp done
	
found:							; string was found
	mov eax,edi					; calculate the position in the find target
	sub eax,pTarget
	cmp eax,eax					
	
done:
	ret
Str_find ENDP

END main