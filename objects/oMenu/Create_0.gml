/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//rodando a musica do menu 
audio_play_sound(snd_music_menu, 1, 1)

//Criando o menu do jogo
index = 0;
//criando uma variavel para podermos mexer no index
//criando uma lista para armazenar as opções de jogo que temos
opcao = ["Jogar", "Tutorial", "Sair"]

//criando uma margem para os nossos textos 
margem = 55;

//criando uma variavel para definir o alpha do titulo do jogo
alpha_texto = 1;

//criando um meto do para usar as teclas
teclas_menu = function()
{
    up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
    //criando a variavel up que armazena as teclas de W ou seta para cima
    //criando a variavei down que armazena as teclas de S ou seta para baixo
    down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
    enter = keyboard_check(vk_enter);
    //registrando a tecla de enter
    
    //rodando nosso if para informar qual tecla apertamos e qual index ele se refere
    if(up)
    {
        //diminuindo meu index
        index--
        //rodando um if agora para ver se meu index e menor que zero
        if(index < 0)
        {
            //se meu index for menor que zero então ele se move para cima
            index = 2;
        }
    }
    if(down)
    {
        //aumentando meu index
        index++
        //rodando um novo if
        if(index >= 3)
        {
            //se meu index for maior que 1 então meu index vira zero ou estou indo para baixo
            index = 0
        }
    }
    if(enter)
    {
       //se eu apertei enter então ele roda o metodo roda menu
        roda_menu()
        //quando eu apertar enter eu mato a musica
        audio_stop_all()
    }
}

//criando o metodo que roda o menu
roda_menu = function()
{
    //rodando meu switch
    switch (index) 
    {
        case 0:
        {
            cria_transicao_inicia(rm_fase_1)
        }	
        break;
        //encerrando a case com break    
        case 1:
        {
            cria_transicao_inicia(rm_tutorial_1)
        }	
        break;
        case 2:
        {
            game_end()
        }	
        break;
    }
}


//Criand o o metodo de desenharo menu
desenha_menu = function()
{
    //definindo o meito da tela 
    var _meiotela = display_get_gui_height() / 2
    //criando uma variavel temporaria para guardar a parte vertical da room
    draw_set_valign(fa_top)
    
    //rodando um laço de repetição para desenhar as palavras 
    for (var i = 0; i < 3; i++) 
    {
    	//definindo a cor que será branco
        var cor = c_white
        //definindo a margem tambem 
        var marg = 0;
        
        //rodando o if dentro do loop
        if(i == index)
        {
            //ele vai pegar meu indice i e comparar se tem mesmo valor que index
            //se tiver então ele muda a cor do texto para
            var cor = c_yellow;
            //aplicando a minha margem 
            marg = margem
        }
        //definindo a fonte usada que será fnt_menu
        draw_set_font(fnt_menu)
        //dando a cor que quero que se a variavel cor   
        draw_set_color(cor)
        //desenhando meu texto na tela
        //ele vai pegar a posição 20 da room e vai somar com a marg
        //vai aplicar isso no meio da tela somado ao meu indice multiplicado por 80 dando uma sensação de 
        //separação
        //e verificar qual opção se refere esse indice
        draw_text(55 + marg, _meiotela + i * 80, opcao[i])
        
        //resetando a cor de volta
        draw_set_color(-1)
    }
    //definindo a fonte usada que será fnt_menu
    draw_set_font(fnt_menu_titulo)
    //definindo aonde será desenhado o texto
    var _meiotela_titulo = display_get_gui_width() / 3
    //definindo o meito da tela altura do jogo
    var _meiotela_titulo_altura = display_get_gui_height() / 3
    //desenhando o titulo do jogo
    draw_text_ext_colour(_meiotela_titulo, _meiotela_titulo_altura - 90, 
    "Paintforma", -1, 500, c_white, c_white, c_white, c_white, alpha_texto);
    
    //criando um if para diminuir e aumentar a opacidade do texto
    alpha_texto -= 0.009;
    //irei perder o alpha aos poucos
    if(alpha_texto < 0)
    {
        //se meu alpha texto for menor que zero 
        alpha_texto = 1
        //então eu reseto ele e ela passa a ser 1 de novo
        //ele desenhará o meu texto novamente com meu novo alpha
    }
}