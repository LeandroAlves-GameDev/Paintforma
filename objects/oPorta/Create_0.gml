/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

estados = "Fechada";
//definindo uma variavel de estado para nossa porta

//dando uma velocidade para nossa porta
velv = 0;
velv_max = 4;



//Criando a maquina de stados da porta
estado_porta = function()
{
    switch (estados) 
    {
    	case "Fechada":
        {
            velv = 0;
            //dentro da primeira case por padrão iremos estar com a velv 0
        }
        break;
        case "Aberto":
        {
            //fazendo estado da porta abrindo
            //se mey velv for menor que meu velv_max
            if(velv <= velv_max)
            {
                //se meu velv for ainda igual a 0
                if(velv == 0)
                {
                    //então ele cria esse efeito
                    //rodando um create layer para gerar um efeito de poeira na porta
                    var _partporta = instance_create_layer(x, y, "Efeitos", oParticulas_porta) 
                }
                //apos ganhar velocidadeo efeito some rapidamente e então
                //então eu ganho velv
                velv -= 0.01
                //rodando meu screenshake para imersão
                oScreenshake.treme = random_range(1.7, 2.8)
                //durante o ganho de velocidade da porta iremos rodar o screenshake podendo puxar
                //valores entre 1.7, 2.8
                
                //Criando mais um efeito onde a porta se move levementer
                x = xstart + random_range(-1, 1)
                
                if(velv <= -1) //se meu velv for menor ou igual a -1 que o limite de velocidade da porta
                { 
                   //então meu estaod da porta e resetado
                   estados = 0 
                   //e meu velv da porta e resetado
                   velv = 0    
                   x = xstart;
                }
                
            }
            
        }
        break;   
    
    }
    y += velv;
    //fazendo a porta pois ele vai pegar o y da room e somar com o velv 
}