/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//criando um metodo de colisão para destruir a chave atual pega
pega_chave = function()
{
    //criando o sistema de chaves do jogo
    var chave = place_meeting(x, y, oPlayer);
    //ele vai ver se o player colidiu com a chave
    //se sim então ele roda o if
    if(chave)
    {
        //ao colidir com a chave meu imagem speed ou seja a velocidade da animação
        //vai ter um aumento de 0.2
        image_speed += 0.2;
        //se meu image_speed atingir um valor maior ou igual a 10 
        if(image_speed >= 10)
        {
           //dai eu coleto minha chave e destruo a instancia
           //melhorando nosso sistema de coleta de chave e criando um efeito bacana para destruir ela 
           global.chaves += 1; 
           //se eu peguei a chave então ele deve ser destruida 
           instance_destroy();
        }
    }
    //show_debug_message(image_speed)
}