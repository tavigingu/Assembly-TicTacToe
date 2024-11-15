BITS 32

%include 'functions.asm'

section .data
    table times 9 db 0x5F ; = '_'
    rand db 0 ; 0/1 randul jucatorului
    msgJucator1 db "JUCATORUL 1 (X)", 0
    msgJucator2 db "JUCATOR 2 (O)", 0
    msgWin db " A CASTIGAT!", 0

    msgRemiza db "REMIZA!", 0
    msgInvalid db "Optiune invalida (1<=N<=3)!", 0
    msgPozitie db "Pozitie deja completata", 0
    msgLinie db "LINIE=", 0
    msgColoana db "COLOANA=", 0

section .bss
    optiune resb 3

section .text
    global _start

_start:

    .loopGame:
        call _print_table
        call _insert
        call _check_win

    jmp .loopGame

    .exit:

    call exit

_check_win:
    push ebp
    mov ebp, esp

    xor ecx, ecx
    .loop_draw:
        cmp [table, ecx], 0x5F
        je .exit_draw

        inc ecx
        cmp ecx, 0x09
        jl .loop_draw

    MOV ESI, msgRemiza
    call string.PrintEndl
    call _start.exit

    .exit_draw

    mov esp, ebp
    pop ebp
    ret

_insert:
    push ebp
    mov ebp, esp

    cmp [rand], byte 1
    je .msgPlayer2

    .msgPlayer1:
        mov esi, msgJucator1
        call string.PrintEndl
        jmp .msgExit

    .msgPlayer2:
        mov esi, msgJucator2
        call string.PrintEndl
        jmp .msgExit
    
    .msgExit:
        jmp .read_line

    .checkInvalid:
        mov esi, msgPozitie
        call string.PrintEndl
        jmp .read_line

    .linie_invalida:
        mov esi, msgInvalid
        call string.PrintEndl

    .read_line:

        mov esi, msgLinie
        call string.Print

        mov esi, optiune
        mov edx, 2
        
        call string.Read

        ;iesire din joc
        cmp [optiune], byte 'q'
        je _start.exit


        call string.atoi ; ii dai esi si iti pune conversia in eax
        
        mov ebx, 1
        mov ecx, 3
        call compare ; verifica daca eax e intre ebx si ecx si returneaza in edx 1 daca e interval, 0 daca nu

        cmp edx, 1
        jne .linie_invalida

    push eax ; salvam pe stiva linia buna
    jmp .read_coloana

    .coloana_invalida:
        mov esi, msgInvalid
        call string.PrintEndl

    .read_coloana:

        mov esi, msgColoana
        call string.Print

        mov esi, optiune
        mov edx, 2
        
        call string.Read
        call string.atoi ; ii dai esi si iti pune conversia in eax
        
        mov ebx, 1
        mov ecx, 3
        call compare ; verifica daca eax e intre ebx si ecx si returneaza in edx 1 daca e interval, 0 daca nu

        cmp edx, 1
        jne .coloana_invalida

        mov ebx, eax ; punem coloana in ebx
        pop eax ; aducem indexu linie

        dec eax
        dec ebx

        mov ecx, 3
        mul ecx ; inm eax cu ecx si salveaza in eax

        add eax, ebx
        call _check_position

        cmp edx, 0
        je .checkInvalid

        call _insert_in_table

    mov esp,ebp
    pop ebp

    ret

;takes eax as parameter ( position to insert in table ) 
_insert_in_table:
    push ebp
    mov ebp, esp

    cmp [rand], byte 0x00
    jne .insertPlayer2

    .insertPlayer1:
        mov [table + eax], byte 0x58 ; X
        mov [rand], byte 0x01
        jmp .insertExit

    .insertPlayer2:
        mov [table + eax], byte 0x4F ; O
        mov [rand], byte 0x00
        jmp .insertExit


    .insertExit:

    mov esp, ebp
    pop ebp

    ret

; take eax as parameter
; returns in edx 1 true 0 false
_check_position:
    push ebp
    mov ebp, esp

    mov bl, [ table + eax ]
    cmp bl, byte 0x5F
    jne .checkFalse

    .chechkTrue:
        mov edx, 1
        jmp .checkExit

    .checkFalse:
        mov edx, 0
        jmp .checkExit

    .checkExit:

    mov esp, ebp
    pop ebp

    ret


_print_table:
    push ebp
    mov ebp, esp

    xor edx, edx ; i
    xor ecx, ecx ; j
    mov esi, table

    .fori:
        xor ecx, ecx

        .forj:
            mov al, byte [esi]
            call char.Print

            mov al, 0x20
            call char.Print

            inc esi

            inc ecx
            cmp ecx, 3
        jl .forj

        call char.NewLine

        inc edx
        cmp edx, 3
    jl .fori

    mov esp, ebp
    pop ebp
    ret