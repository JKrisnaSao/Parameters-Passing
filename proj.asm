; This program reinforces procedure call skills and bit manipulation knowledge
; Author: Jonathan Sao
; Date: 3/31/24

.586
.MODEL FLAT

INCLUDE io.h

.DATA
array1 DWORD 0ff0aff01h, 0ff0bff02h, 0ff0cff03h, 0ff0dff04h, 0ff0eff05h
array2 DWORD 002ff0affh, 003ff0bffh, 004ff0cffh, 005ff0dffh, 006ff0effh

.CODE
_MainProc   PROC
    lea esi, array1        ; loading address for arr1,2,3
    lea edi, array2
    lea ebx, array3
    push 5                 ; Push count onto the stack before calling arrMix
    call arrMix            ; Calling the procedure
    add esp, 4             ; Clean up the stack after the call

    mov eax, 0          ; Return 0
    ret
_MainProc   ENDP


arrMix PROC count:DWORD, array1:DWORD, array2:DWORD, array3:DWORD
    mov ecx, count         ; Load the count value

arrMixLoop:
    mov eax, [esi]               ; Load array1 elements
    and eax, 00FF00FFh           ; Keep bits 0-7 & 16-23
    mov edx, [edi]               ; Load array2 elements
    and edx, 0FF00FF00h          ; Keep bits 8-15 & 24-31
    or eax, edx                  ; Combine the two bit sets
    mov [ebx], eax               ; Store results in array3
    add esi, 4                   ; Move to the next ele in arr1 
    add edi, 4                   ; Move to the next ele in arr2
    add ebx, 4                   ; Move to the next ele in arr3
    loop arrMixLoop              ; Repeat until loop count is zero

    ret
arrMix ENDP

END