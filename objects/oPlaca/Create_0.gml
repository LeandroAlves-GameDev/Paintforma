/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

criando_caixa = false;

caixa_dialogo = noone;


//Criando um sistema de colisão com player
//iniciando nosso metodo
faz_dialogo = function()
{
    //criando uma variavel temporaria que armazena se colidi com o player
    var colide_player = place_meeting(x + 1, y, oPlayer)
    //criando um if para ver se colide ou não com o player
    if(!colide_player)
    {
        //se eu não colide então minha caixa passa a ser falso
        criando_caixa = false;
        if(instance_exists(caixa_dialogo))
        {
            //fazendo minha caixa de dialogo receber a variavel destruido do ocaixadialogo
            //informando que o retorno dela e true
            caixa_dialogo.destruido = true;
            //se já existe uma instancia então ela e destruida
            caixa_dialogo = noone;
            //informando que o objeto que deve ser destruido e o caixa_dialogo que guardar
            //o sistema de criação de instancia
        }
        return;
    }
    //se meu caixa for igual igual a false ou seja informa se criando caixa for falso
    if(criando_caixa == false)
    {
     //cria a minha caixa   
     //criando minha caixa de dialogo
     caixa_dialogo = instance_create_layer(x, oPlaca.y - 40, "Dialogo", oCaixadialogo)
     caixa_dialogo.texto = texto;  
     //criando a instancia da caixa
     //definindo o alpha da caixa
     caixa_dialogo.image_alpha = 0.8;
     //definindo o tamanho da caixa
     caixa_dialogo.image_xscale = .8; 
     caixa_dialogo.image_yscale = .5;
     //então eu crio a caixa e faço o criando caixa virar true
     criando_caixa = true;
    }
}
