// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

//iniciando o efeito do brilho
function inicia_efeito_brilho()
{
    //criando um script que pode ser transportado pra outros projetos
    
    //definindo nossos variaveis padroes
    xscale = 1;
    yscale = 1;
    dir = 1;
    
    brilho = c_white;
    alpha_brilho = 0;
}

//aplicando oe efeito do brilho
//vamos usar essa função para brilhar
//podemos tambem definir uma cor 
//e tambem podemos mexer na intesidade do brilho
function aplica_brilho(_cor = c_white, _intesidade_valor = 1)
{
    //informando a cor do brilho com base no parametro _cor = c_white
    //com isso ao chamar a função em algum outro objeto podemos informar a cor diretamente por ele
    alpha_brilho = _intesidade_valor;
    brilho = _cor;
}

//criando uma função para fazer voltar para cor principal
//podemos usar essa função para fazer ele parar de brilhar
//podemos mudar velocidade com ele diminui a cor
function retorna_efeito_brilho(_vel = 0.1)
{
    //rodando um sistema para apagar no alpha
    //como ele está definindo como 1 ele rodará o lerp que vai suavizar esse valor
    //ou seja 1 e o alpha 100% e 0 será a interpolação 
    alpha_brilho = lerp(alpha_brilho, 0, _vel);
}

//criando a função para desenhar o efeito do brilho
//ele e apenas usado apos desenhar a sprite 
//ela tambem pode ser feita de maneira manual
//usando variavel alpha_brilho e brilho no image blend
function desenha_efeito_brilho()
{
    //ele so vai precisar se desenhar se meu alpha brilho for maior que 0
    if(alpha_brilho <= 0.01) return;
    //chamando o shader
    shader_set(sh_muda_cor);
    draw_sprite_ext(sprite_index, image_index, x, y, xscale * dir, yscale, image_angle, brilho, alpha_brilho)
    //resetando ele
    shader_reset();
}

