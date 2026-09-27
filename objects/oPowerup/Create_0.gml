/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//definindo um alvo
alvo = noone;
tempo_sumir = 0;

//Criando um metodo para mover meu objeto
movendo = function()
{
    //so devo rodar se ter um alvo
    if(!alvo) return; 
    //se eu não tiver um alvo então nao roda nada
    y = alvo.y - 34;
    //fazendo meu powerup se mover no eixo Y
    x = alvo.x;
    //fazendo ele se mover no eixo x
    
    
    //melhorando a destruição do powerup
    //o maximo de opacidade será de 1 ou seja iremos começar com 100 e vai diminuir 90, 80, 70
    image_alpha = clamp(image_alpha - 0.01, 0, 1);
    //show_debug_message(image_alpha)
    //ao atingir zero
    //criando um timer para sumir o powerup
    tempo_sumir++;
    //ganhando tempo
    if(tempo_sumir >= 60 && image_alpha <= 0)
    {
        //se meu tempo for maior ou igual a 60 frames     
        instance_destroy();
        //então ele e destruido
        //show_message("morri")
    }
}


//criando um metodo no powerup para destruir meu objeto power up
fui_pego = function()
{
    if (alvo != noone) return;
    //se meu alvo for diferente de noone ou seja nada então ele não roda o codigo    
    //verificando se eu colidi com o player
    var coletado = instance_place(x, y, oPlayer)
    if(coletado)
    {
        alvo = coletado.id;
        oPlayer.estado_coletapowerup();
        explode();
        oPlayer.power_up_tinta = true;
    }
}

//criando um metodo de explosão de efeito das particulas
explode = function()
{
    //criando a instancia oParticulapowerup na layer efeitos e definindo a posição dele
    repeat (10) 
    {
    	var cria_efeitopowerup = instance_create_layer(alvo.x, alvo.y - 34, "Efeitos", oParticulapowerup);
        //criando um efeito de aleatoridade para essa particula
        cria_efeitopowerup.speed = random_range(1, 4);
        //por padrão ele vai mudar entre 1 e 3
        //criando uma forma de deixar aleatorio a direção ele vai mudar direção entre o raio de 0 e 359
        cria_efeitopowerup.direction = random_range(0, 359);
        //definindo o alvo
        cria_efeitopowerup.alvo = alvo;
    }
    //rodando um debug para ver speed dele
    //show_message(cria_efeitopowerup.speed)
}