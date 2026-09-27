/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

draw_self();
//se eu não devo estar desenhando o texto então ele encerra tudo
if(!desenha_texto) exit;
//alinhando nosso texto
draw_set_halign(0)
draw_set_valign(0)
//criando a margem do texto
var marg = 3;
//usando draw_set_halign e draw_set_valign para alinhar o texto
var _x = x - sprite_width/2 + marg;
var larg = (sprite_width * 10) - (marg * 10)
//criando uma var temporaria que se referente ao x menos a largura da sprite dividido por 2
//chamando a fonte
draw_set_font(fnt_dialogo)
//usando um draw_text_transformed para mudar a escala do texto
draw_text_ext_transformed(_x, y + 5, texto, 50, larg, 0.1, 0.1, 0)
//draw_text(_x, y, texto)
//resetando a fonte
draw_set_font(-1)