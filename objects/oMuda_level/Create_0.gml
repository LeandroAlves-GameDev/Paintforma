/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

colide_com_player = false;
//criamos uma variave de colide com player por padrão será false
transicao_iniciada = false; 
//criamos uma de transição que tambem será false

//criando um método de colisão com o player
colide_player = function()
{
    //se a transição já foi iniciada ele retorna e nem valida mais a colisão
    if (transicao_iniciada) return;

    //criando uma variavel temporaria para ver se estou colidindo com o player
    var colide = instance_place(x, y, oPlayer);
    
    //se eu estou colidindo com o player
    if(colide)
    {
        //então ele muda colide_com_player para true
        //ele muda tambem a transicao_iniciada para true tambem
        colide_com_player = true;
        transicao_iniciada = true;
        //ao ser ativado como true ele bloquea novas colisoes por conta do return
        
        //chamando o metodo cria_transicao_inicia e informando qual room devo ir
        cria_transicao_inicia(destino)
        audio_stop_all()
    }
}