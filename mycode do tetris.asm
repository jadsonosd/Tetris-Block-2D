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
      