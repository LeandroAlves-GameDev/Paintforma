/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

draw_set_font(-1)
//desenhando o player
//chamando nosso sprite index ou seja se refere a minha sprite
//chamando eu image index se refere ao frame dela
//x e y se refere a posição
//chamando o xscale multiplicado pelo dir ou seja minha escala vai multiplicar com a direção que estou olhando
//fazendo eu olhar para o lado certo sem quebrar a imagem
//chamando o yscale que se referente a escala y do personagem
//chamando o image angle que refere o angulo de imagem do player
//image blend se refere a cor do player
//image alpha o tanto de opacidade do player
draw_sprite_ext(sprite_index, image_index, x, y, xscale * dir, yscale, image_angle, image_blend, image_alpha)


//chamando a minha função de desenhar efeito do brilho
desenha_efeito_brilho();

//desenhando o hitbox do meu player
//draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true)

//desenhando o debug da velv 
draw_text(x, y - 30, buffer_jump_timer_atual);
//draw_text(x + 50, y - 30, y);