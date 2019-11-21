;AH = 13h
;AL = 01H    ; 06h modo  ; de 13 para 6 a proporcao
;        bit 0: ; 1- atualiza a posição do cursor apos a escrita
;        bit 1: ; 1- string contém caracteres e atributos
;BL = ; atributo do caractere se o bit 1 em AL for 0
;BH = ; numero da pagina de video
;DH, DL = ; linha, coluna da posicao de impressao
;CX = ; tamanho, em caracteres, da string
;ES:BP = ; endereco do inicio da string   

;
; Tetris Block 2D
; 
 
;   AH = 13h 
   
mov ah, 9
mov dx, offset TituloStr
int 21h   
   
   
   
   
  TituloStr     db  'Tetris Block 2D'
                db  'Jadson e Felipe', 13, 10, 36               
    ;rdtsc 
    
    ;edx:eax
    
    
    ;rand shuffle do rand   
    ; rand procedimento (double word):
    ; da um numero de range 0 <= n range.
    ; procedimento ebp
    
    ;
    ;rand:
    ;rdtsc
    ;xor edx, edx
    ;div dword [esp + 4]
    ;mov eax, edx
    ;ret
    
    ;proedimento sbx e ecx
    
    ;shuffle:
    
    push ebp
    mov ebp, esp
    push ebx
    
    mov ebx, [ebp + 8]
    mov ecx, [ebp + 12]
    dec ecx
    
    ; loop usando rand entre 0 e acx inclusive
    
    .loop:
        lea eax, [ecx +1]
        push eax
        call rand
        add esp, 4
    
    ; para passar ecx + 1 para rand o "carregar endereço effetivo"
    ; tem a instrucao lea que e usado. Isso e comum como truque para fazer
    ; uma certa aritimetica operacoes em uma simples instrucao
    
    ; os valores no (index) lugar ecx e qualquer index eax estao paginados, usando
    ;dx como um temporario
    
    mov dx, [ebx + ecx * 2]
    xchg dx, [ebx + eax * 2]
    mov [ebx + ecx * 2], dx
    loop .loop
    
    ; O loop continua, decrementando ecx cada vez. quando o loop completa
    ; a matriz embaralha no lugar, e a funcao simplesmente retorna
    
    pop ebx
    mov esp, ebp
    pop ebp
    ret   
    
    ; Prova de que isso funciona
    
    ; usando funcoes de partes anteriores dessas series,
    ; nos podemos construir um pequeno teste que embaralha
    ; uma matriz de 4 palavras em cada evento chave.
    
    section .data
    
    array dw 0xAAAA, 0xBBBB, 0xCCCC, 0xDDDD
    
    section .text
    
    main:
    
        push word BG.BLACK | ' '
        call clear
        
        .loop:
            call scan
            test al, al
            jz .loop
            
            push dword 4
            push array
            call shuffle
            
            push word 0x1008
            push dword [array]
            call itoa
            push dword 0x01010 << 16 | FG.BRIGHT | FG.BLUE
            push eax
            call puts
            
            push word 0x1008
            push dword [array + 4]
            call ita
            push dword 0x0108 << 16 | FG.BRIGHT | FG.BLUE
            push eax
            call puts
            
            add esp, 36
            jmp .loop
                  
