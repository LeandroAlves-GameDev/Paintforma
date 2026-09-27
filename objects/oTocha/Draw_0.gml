/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//criando um sistema de variação de escala para nosso jogo
var escala =  random_range(0, 0.03);
//variando a escala do brilho da tocha para termos a impressão que a iluminação cresce e diminui
//por isso o uso do random range que vai alterna entre 0 e 0.03

//criando um efeito de iluminação
gpu_set_blendmode(bm_add);

//desenhando o efeito do brilho da tocha e usando os paramentros de escala junto do scale 
draw_sprite_ext(spr_tocha_brilho, image_index, x, y, 0.4 + escala, 0.4 + escala, 0, c_white, .07);

gpu_set_blendmode(bm_normal);