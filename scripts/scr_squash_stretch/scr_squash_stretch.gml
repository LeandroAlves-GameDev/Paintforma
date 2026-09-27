// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

//Criando um efeito de mola
function inicia_efeito_mola()
{
    xscale = 1;
    yscale = 1
}

function efeito_mola(_xscale = 1, _yscale = 1)
{
    xscale = _xscale;
    yscale = _yscale;
}

function retorna_mola(_qtd = .1)
{
    xscale = lerp(xscale, 1, _qtd);
    yscale = lerp(yscale, 1, _qtd);
}

function desenha_efeito_mola()
{
    draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, c_white, 1)
}