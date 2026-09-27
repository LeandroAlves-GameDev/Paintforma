/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Criando uma variavel de texto para nossa caixa de dialogo
texto = "OLAAAAA"

//criando uma variavel de controle para desenhar o texto
desenha_texto = false;

destruido = false;

//criando um metodo de inicio
inicio = function()
{
    image_xscale = lerp(image_xscale, 1, .1);
    y = lerp(y, ystart - 10, .2);
    
    if(y <= ystart - 9.9)
    {
        desenha_texto = true;
    }
}

finaliza = function()
{
    //deixando a caixa de dialogo achatada
    image_xscale = lerp(image_xscale, 0, .1);
    //deixando ela sem alpha
    image_alpha = lerp(image_alpha, 0, .1);
    //fazendo ele ir pra baixo
    y = lerp(y, ystart, .2);
    
    desenha_texto = false;
}