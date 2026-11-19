/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Melhorando nosso sistema da chave
segue_player = false;
alvo = noone;


//Criando um metodo de seguir o player
segue_jogador = function()
{
    //rodando nosso if para seguir o player
    if (segue_player) 
    {
        //vendo se meu alvo existe
        if(instance_exists(alvo))
        {
           //limitando a chave 
           var _distx = abs(x - alvo.x)
            
            
           if(_distx != (15 * alvo.dir))
           {
               x = lerp(x, alvo.x + (15 * -alvo.dir) , .05)
           }
            //Criando uma sistema de onda
            var sinwave = 15 * sin(10 * current_time / 1000);
            
            y = lerp(y, alvo.y - alvo.sprite_height / 1 + sinwave, .1);
            
            
        }
    }
}

//
////criando um metodo de colisão para destruir a chave atual pega
//pega_chave = function()
//{
    ////criando o sistema de chaves do jogo
    //var chave = place_meeting(x, y, oPlayer);
    ////ele vai ver se o player colidiu com a chave
    ////se sim então ele roda o if
    //if(chave)
    //{
        ////segue_player = true; 
        //alvo = other.id;
        ////dai eu coleto minha chave e destruo a instancia
        ////melhorando nosso sistema de coleta de chave e criando um efeito bacana para destruir ela 
        ////global.chaves += 1; 
        ////se eu peguei a chave então ele deve ser destruida 
        ////instance_destroy();
        //
    //}
    ////show_debug_message(image_speed)
//}