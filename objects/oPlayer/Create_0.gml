/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//rodando a musica do jogo
audio_play_sound(snd_music_jogo, 1, 1)


//Iniciando efeitos do player
efeito_mola();
inicia_efeito_brilho();

#region aqui ficará todas as variaveis

//Criando uma lista de sprites para fazer a transição dos estados
lista_sprites = [spr_player_desacelera, spr_player_idle]
//variavel que guarda o indice da sprite
index_sprite = 0;


//variaveis de movimentos
velh = 0;
velv = 0;
velv_max = 4;
velh_max = 2;
velh_run = 4;
grav = 0.3;

power_up_tinta = false;


//criando um sistema de pulos duplos para nosso jogo
//qtd_jump = 2;
//qtd_jump_atual = qtd_jump;


//criando nosso time de coyote jump para melhorar a vida do jogador
coyote_timer = 6;
//dando um valor provisorio
coyote_timer_atual = coyote_timer;


//criando variaveis para o sistema de buffer do pulo 
buffer_jump_timer = 6;
buffer_jump_timer_atual = 0;


//Criando uma variavel para aplicar dano ao player
levo_dano = false;


//definindo variaveis do efeito de brilho
//criando uma variavel de cor
//brilho = c_white;
//alpha_brilho = 0;


//agora iremos pegar a nossa layer para fazer colisão por tiles
var _layer = layer_tilemap_get_id("tl_level")

//criando sistema de colisoes com base em listas
colisoes = [oParede, _layer, oParede_one_way, oPorta];

_tile = layer_tilemap_get_id("tl_powerup")

//Criando uma variavel para ver se estou tocando no chão
chao = false;

//Criando variaveis de inputs para nosso jogo
left = false;
right = false;
jump = false;
tinta = false;
pegapowerup = false;

_tile_powerup = false;

//Criando o sistema de estados do player
estado = noone

//Criando uma variavel de vizualição do debug
view_player = noone;

//Criando uma variavel para ver onde estou olhando
dir = 1

#endregion


#region Aqui dentro ficará todos meus metodos

//Criando um metodo que vai pegar meus inputs
pega_input = function()
{
    //esse metodo foi apenas feito para guardar os inputs
    right = keyboard_check(ord("D")) || keyboard_check(vk_right);
    left = keyboard_check(ord("A")) || keyboard_check(vk_left);
    jump = keyboard_check_pressed(vk_space);
    //criando uma tecla de corrida para nosso jogo
    run = keyboard_check(vk_shift);
    
    
    //criando uma melhoria no pulo
    //jump_r = keyboard_check_released(vk_space);
    //chamando nosso ativa debug dentro do nosso sistema de inputs
    //ao apertar o tab ele rodará nosso ativa debug
    ativando_debug = keyboard_check_pressed(vk_tab);
    
    //criando uma variavel para entrar na tinta
    tinta = keyboard_check_pressed(vk_control);
}

//criando um metodo de corrida
modo_corrida = function()
{
    //criando uma if para ativar o modo corrida
    if(run)
    {
        //se eu apertei o botão de run ou seja shift
        //minha velh_max será a minha velh_run
        velh_max = velh_run;
    }
    else 
    { 
        //se eu não estou apertando então minha velocidade será a velh_max normal 
        velh = velh_max;
    }
}

//criando o metodo do coyote_jump
coyote_jump = function()
{
    //chamando o metodo de checar o chão
    checa_chao();
    //vendo se não estou no chão
    if(!chao)
    {
        coyote_timer_atual--;
    }
    else 
    {
        //se eu toquei o chão eu reseto meu timer
        coyote_timer_atual = coyote_timer;	
    }
}

//criando o metodo para ser nosso buffer pulo
buffer_jump = function()
{
    //chamando o metodo do checa chao
    checa_chao();
    pega_input();
    //se eu estou no ar então eu devo ganhar valor
    if(!chao && jump)
    {
        //se eu nao estou tocando no chão e apertei jump logo eu fico igual o buffer_jump_timer
        buffer_jump_timer_atual = buffer_jump_timer;
        
    }
    if(!chao) 
    {
    	//toda vez que eu tocar no chão eu reseto 
        buffer_jump_timer_atual--;
    }
}

//Cria ndo um sistema de movimentos para o player
//criando um metodo para rodar a movimentação do player
move_player = function()
{
    //chamando o metodo checa_chao
    checa_chao();
    //ele vai verificar se estou apertando direita ou esquerda
    //e irá rodar o seguinte calculo primeiro ele vai calcular quem nos pressionamos e subtrairmos ele
    //depois ele vai multiplicar esse valor por vel que dará o resultado de velh
    //depedendo se for esquerda ou direita ficará negativo ou positivo
    velh = (right - left) * velh_max
    
    //Criando o sistema de gravidade do nosso jogo
    if(!chao)
    {
        //se meu chão tiver um resultado diferente
        //então a gravidade será aplicada junto de meu velv
        velv += grav
        //caso contrario
    }
    else 
    {
        //resetando a velv 
        velv = 0
        //caso o player acabe entrando um pouco dentro do colisor ou seja do nosso chão
        //podemos arredondar usando
        y = round(y) //ele vai servir para arrendodar no y da room
        //ou seja ele vai arrendodar algum valor quebrado
        
        //Criando o pulo do player
    	if(jump || buffer_jump_timer_atual)
        {
            //se o resultado for senao ou seja se meu chão for igual a false
            //então meu velv vai ser igual a menos vel ou seja ao apertar espaço eu pulo e vou para cima 
            //e tomo efeito da gravidade
            //fazendo eu cair 
            velv = -velv_max
            //se eu apertei o botão de jump então ele roda o efeito do som de pulo
            audio_play_sound(snd_jump,1, 0)
            buffer_jump_timer_atual = 0;
        }
        
    }
    
    //criando um limite de velocidade para o player
    if(velv > velv_max) velv = velv_max;
    if(velv < -velv_max) velv = velv_max   
} 

//Criando um metodo de remoção de colisão para evitar bugs de colisão
remove_colisao = function()
{
    //fazendo um if para checar se estou colidindo com meu one_Way
    if(instance_place(x, y, oParede_one_way))
    {
        //ele vai verificar se tem colisão com oParede_one_way
        //agora vou checar esse one way está dentro da minha lista
        if(array_contains(colisoes, oParede_one_way))
        {
            //removendo ele da lista
            //informando o indice desse cara
            var indice = array_get_index(colisoes, oParede_one_way);
            //deletando ele da lista
            array_delete(colisoes, indice, 1)
        }
    }
}

//fazendo meu player olhar para direção certa
ajusta_escala = function()
{
    if(velh != 0) dir = sign(velh)
}

//Criando um metodo de movimentos com move and collide
movimentos = function()
{
    //melhorando o movimento usando um sistema de colisão por move_and_collide
    move_and_collide(velh, velv, colisoes, 4);
    //move and collide vertical
    move_and_collide(0, velv, colisoes, 24);
}

//Criando um metodo de gravidade para nosso player
checa_chao = function()
{
    //ele vai verificar se minha mascara de colisão está colidindo com a minha instancia parede
    chao = place_meeting(x, y + 1, colisoes)
    //passando os parametros do tile powerup para eu entrar nele
    _tile_powerup = place_meeting(x, y + 1, _tile)
}



//criando o sistema de colisão da porta com o player
bloqueia_passagem = function()
{
    //criando um if dentro do metodo para impedir que o player passe
    var porta = instance_place(x + velh, y, oPorta)
    //ele vai ver se o colisoes (oporta) está colidindo com player
    //se eu estou colidindo então ele zera meu velh
    
    //rodando um if para desbloquear a minha porta
    if(porta)
    {
        //se eu colidi com a porta
        //image_blend = c_red
        if(porta.estados == "Fechada")
        {
            //se meu porta.estados for igual a noone ele se refere a case 0
            //ou seja fechada
            if(global.chaves > 0)
            {
                //se minhas chaves forem maior que 0
                //então eu destruo a minha porta
                //instance_destroy(porta)
                global.chaves -= 1;
                //e perco a minha chave
                porta.estados = "Aberto";
                //mudando o estado da porta para case 1 ou seja estado aberto
                
            }
        }
    }
}

//rodando um metodo para desenhar as chaves
desenha_chave = function()
{
    var _gui_largura = 40;
    
    draw_sprite_ext(spr_chave, 0, _gui_largura, 60, image_xscale * 4, image_yscale * 4, 0, c_white, 1);
    
    draw_set_font(fnt_chaves)
    //desenhando o texto da quantidade pega
    draw_text(_gui_largura + 60, 60, string(global.chaves));
    //resetando a fonte
    draw_set_font(-1)
}

//Criando um novo metodo para trocar a sprite
//passando uma argumentação com uma sprite aleatoria
troca_sprite = function(sprite = spr_player_idle)
{
    //se meu sprite index ou seja se minha sprite for diferente do argumento sprite
    if(sprite_index != sprite)
    {
        //então meu sprite index será igual a minha argumentação sprite
        sprite_index = sprite;
        //e nossa animação será zerada
        image_index = 0;
    }
    
}

//Criando um metodo para ver se a animação acabou
anim_acabou = function(_estado = estado_parado)
{
    var spd = sprite_get_speed(sprite_index) / FPS
    //se minha imagem da animação for maior que numero de frames que tenho
    if(image_index + spd >= image_number)
    {
        //então ele da um return
        return true;
    }
    
}

//Criando o metodod de transição de sprite
transicao_sprite = function()
{
    //chamando o metodo troca sprite e dentro dele chamos nossa lista_sprite onde
    //ele guarda as sprites em formato de arrays e passando o indice delas
    troca_sprite(lista_sprites[index_sprite]);
    
    //checando se acabou a minha animação da sprite atual
    if(anim_acabou())
    {
        //se meu anim acabou então eu acabo
        //criando uma variavel temporaria para ver se meu array ainda tem sprites
        //então sera array_length(lista_sprites) - 1
        var _qtd = array_length(lista_sprites) - 1;
        
        //rodando um if para ver se meu index e menor que a quantidade de array do lista sprite
        if(index_sprite < _qtd)
        {
            //eu faço eu ganhar index da sprite se minha index_sprite e menor que o qtd
            index_sprite++;
        }
    }
}

//criando um novo metodo que troca o estado [
troca_estado = function(_estado = estado_parado, _lista_sprites = [spr_player_idle])
{
    //dentro do metodo troca estado, iremos definir alguns parametros
    //a variavel estado vai receber o valor do parametro _estado
    estado = _estado;
    //chamando meu index sprite
    index_sprite = 0;
    //chamando a lista sprites
    lista_sprites = _lista_sprites;
}


//Criando o metodo dos estados para o player
//metodo estado parado
estado_parado = function()
{
    if(buffer_jump_timer_atual == 0) velv = 0
    velh = 0
    //resetando as variaveis
    //chamando move_player no estado parado
    move_player();
    
    //chamando o metodo de transição de sprites
    transicao_sprite();
    
    //criando nosso if para fazer a mudança de estados
    if(right != left)
    {
        //chamando o metodo troca estado e passando os parametros dentro dele
        troca_estado(estado_movendo,[spr_player_acelera, spr_player_correndo])
    }
    if(jump || buffer_jump_timer_atual)
    {
        //chamando o metodo de troca estado e informando qual sprite deve ser usada
        troca_estado(estado_pulando, [spr_player_prepara_pulo, spr_player_pulocima])
        //toda vez que apertar o espaço ou seja pular ele vai criar um efeito
        var cria_efeito = instance_create_layer(x, y, "Player", oParticulas_puloinicio)
        //rodando nosso efeito de mola
        efeito_mola(.1, 1.3);
    }
    if(!chao)
    {
        //chamando o metodo de troca estado e informando qual sprite deve ser usada
        troca_estado(estado_pulando, [spr_player_pulo_para_queda, spr_player_queda])
    }
    
    
    
    //entrando no estado da tinta
    //se eu apertai ctrl, se eu peguei o powerup tambem e se eu estou na area para uso dele
    //então eu entro no estado da tinta
    if(tinta && power_up_tinta && _tile_powerup)
    {
        estado = estado_entra_tinta;
        //se eu apertei o botão para entrar na tinta
        //então ele cria o efeito 
        var cria_efeito = instance_create_layer(x, y, "Efeitos", oParticulas_entratinta)
    }
    //se eu colidi com o objeto espinho 
    if(place_meeting(x, y, oEspinho))
    {
        //então eu entro no estado de dano
        estado = estado_dano;
        //se eu levei dano eu rodo o som de dano
        audio_play_sound(snd_hurt, 1, 0)
    }
}

//Criando o metodo para o estado movendo
estado_movendo = function()
{
    move_player();
    //chamando a minha sprite pelo metodo
    transicao_sprite();
    
    //meu velh for igual a 0
    //então ele mudará para o estado parado pois eu não estou me movendo
    if(velh == 0)
    {
    	troca_estado(estado_parado, [spr_player_desacelera, spr_player_idle])
    }
    //se eu apertei a tecla de jump
    if(jump)
    {
        //toda vez que apertar o espaço ou seja pular ele vai criar um efeito
        var cria_efeito = instance_create_layer(x, y, "Player", oParticulas_puloinicio)
        //chamando o metodo de troca estado e informando qual sprite deve ser usada
        troca_estado(estado_pulando, [spr_player_prepara_pulo, spr_player_pulocima])
    }
    if(!chao)
    {
        //chamando o metodo de troca estado e informando qual sprite deve ser usada
        troca_estado(estado_pulando, [spr_player_pulo_para_queda, spr_player_queda])
    }
    //passando os parametros do tile powerup para eu entrar nele
    
    //eu so devo entrar se apertei o botão e peguei o powerup
    if(tinta && power_up_tinta && _tile_powerup)
    {
        estado = estado_entra_tinta;
        //se eu apertei o botão para entrar na tinta
        //então ele cria o efeito 
        var cria_efeito = instance_create_layer(x, y, "Efeitos", oParticulas_entratinta)
    }
    //se eu colidi com o objeto espinho 
    if(place_meeting(x, y, oEspinho))
    {
        //então eu entro no estado de dano
        estado = estado_dano;
        //se eu levei dano eu rodo o som de dano
        audio_play_sound(snd_hurt, 1, 0)
    }
}

//criando o metodo para o estado pulando 
estado_pulando = function()
{
    ////criando um metodo static para refrescar a cabeça
    //static inicio_pulo = true; 
    ////rodando um if para ver o nosso pulo 
    //if(inicio_pulo)
    //{
        //qtd_jump_atual--;
        //
        ////entrei no estado do pulo
        //inicio_pulo = false;
    //}
    //
    move_player();
    //chamando o metodo troca sprite com a sprite que desejamos ver
    //se minha velv for menor que 0 ou seja estou pulando
    //if(place_meeting(x, y + velv, colisoes))
    //{
        //velv = 0;
    //}
    
    //rodando nosso if do coyote jump
    if(coyote_timer_atual && jump)
    {
        //se eu estou dentro do timer do coyote jump e tentei pular 
        //então eu posso pular
        velv = -velv_max
        
        //resentando meu coyote timer
        coyote_timer_atual = 0;
        
        var cria_efeito = instance_create_layer(x, y, "Player", oParticulas_puloinicio)
        //rodando nosso efeito de mola
        efeito_mola(.1, 1.3);
    }
    
    
    if(velv < 0)
    {
        //então ele rodará a animação do pulo
        transicao_sprite()
        //removendo o one way da lista
        //por padrão nossa colisão ocorrera no obj parede
        //se meu one way existir dentro da lista então eu removo ele da lista
        if(array_contains(colisoes, oParede_one_way)) 
        {
            var _index = array_get_index(colisoes, oParede_one_way)
            //pegando index do meu array que se refere ao objeto oParede_one_way
            array_delete(colisoes, _index, 1)
            //usando um array delete para limpar meu array 
            //colisoes[2] = oParede;
        }
        
        ////se eu apertei espaço e soltei o botão então eu paro de subir
        //if(jump_r)
        //{
            ////eu corto minha velv pela metade
            //velv *= 0.5;
        //}
    }
    else
    {
        //se não ou seja se eu estiver em queda ele mudará para a sprite de queda
        lista_sprites = [spr_player_pulo_para_queda, spr_player_queda]
        transicao_sprite()
        //criando a colisão com o one way
        //se eu não estou tocando no oParede_one_way
        if(!place_meeting(x, y, oParede_one_way))
        {
            //verificando se o one way existe dentro da lista de array
            if(!array_contains(colisoes, oParede_one_way))
            {
                //empurrando meu one way na array 
                array_push(colisoes, oParede_one_way);
            }
            //então meu colisor passará a ser ele
            //colisoes[2] = oParede_one_way
        }
        
    }
    //
    ////criando um if para vermos se temos a possibilidade de pular de novo
    //if(jump && qtd_jump_atual > 0)
    //{
        ////se não ou seja se eu estiver em queda ele mudará para a sprite de queda
        //lista_sprites = [spr_player_pulo_para_queda, spr_player_queda]
        //transicao_sprite()
        //velv = -velv_max
        //qtd_jump_atual--;
    //}
    //
    //
    //ele vai verificar se estou colisão com o chão
    if(chao)
    {
        ////informando que meu inicio do pulo e true
        //inicio_pulo = true;
        ////resetando tambem a quantidade pulo
        //qtd_jump_atual = qtd_jump;
        
        //se eu colidi com o chão então eu mudo meu estado para parado e rodo a animação de transição
        //[spr_player_pouso, spr_player_idle]
        troca_estado(estado_parado, [spr_player_pouso, spr_player_idle]);
        //toda vez que apertar o espaço ou seja pular ele vai criar um efeito
        var cria_efeito = instance_create_layer(x, y, "Player", oParticulas_pulofim)
        
        //se eu toquei no chão então mudo o efeito da mola
        efeito_mola(1.3, 0.2);
    }
}

//Criando o estado dano
estado_dano = function()
{
    //criando uma variavel para identificar se o player tomou dano
    if(!levo_dano) 
    {
        //se meu levo dano tiver um resultado diferente de false ou seja true
        levo_dano = true;
        //ele passa a ser realmente true
        //se eu levei dano eu tambem sofre um efeito de hitflash
        //sendo c_white a cor dele e 3 a intensidade dele
        aplica_brilho(c_white, 3)
        //se eu tomei dano então eu chamo a minha sprite de dano
        troca_sprite(spr_player_dano);
        //se eu morri então eu paro a musica e os outros ons
        audio_stop_all();
        velh = 0;
        //tomei dano então minha velh e zerada
        velv = 0;
        //velv tambem e zerada
    }
    //se eu tomei dano o jogo recomeça 
    //criando um if para ver se minha animação de dano terminou 
    if(image_index > image_number - 1) 
    {
        //se minha image_index ou seja o index que estou atualmente for maior ou igual
        //a meu image_number ou seja numero de imagens menos uma delas
        cria_transicao_inicia(room)
        //então eu chamo o metodo de transição e recomeço a room
        //se eu estou com chaves e morr, então eu perco elas
        global.chaves = 0;
    }
}


//criando um metodo para entrar no estado de pegar powerup
estado_coletapowerup = function()
{
    //show_message("peguei")
    estado = estado_pegapowerup_inicio;
    //rodando a musica do power up
    audio_play_sound(snd_powerup_1, 1, 0)
}


//Criando o estado de pegar power
estado_pegapowerup_inicio = function()
{
    troca_sprite(spr_player_powerup_inicio)
    //zerando a velocidade dele
    velh = 0;
    velv = 0;
    //rodando o metodo para ver se minha animação acabou
    if(anim_acabou())
    {
        //se minha animação acabou então ele mudará o estado para o meio
        estado = estado_pegapowerup_meio;
    }
}

//meio do estado power up
estado_pegapowerup_meio = function()
{
    troca_sprite(spr_player_pegapowerup)
    
    //eu so vou para o proximo estado se não exister mais particulas
    var part_exists = instance_exists(oParticulapowerup)
    //vendo se ainda existe a instancia particulas
    if(!part_exists)
    {
        //caso não exista então meu estado vai mudar 
        estado = estado_pegapowerup_fim;
    }
    
    //if(anim_acabou())
    //{
        ////se minha animação acabou então ele mudará o estado para o fim
        //estado = estado_pegapowerup_fim;
    //}
}

//fim do estado powerup
estado_pegapowerup_fim = function()
{
    troca_sprite(spr_player_powerup_fim)
    if(anim_acabou())
    {
        //se minha animação acabou então ele mudará o estado para o parado
        troca_estado(estado_parado, [spr_player_idle]);
    }
}

//criando estado de entrada e saida da tinta
estado_entra_tinta = function()
{
    velh = 0;
    troca_sprite(spr_player_tintaentra)
    if(anim_acabou())
    {
        troca_estado(entra_tinta, [spr_tinta_inicio, spr_tinta_loop]);
    }
    
}

//Criando o estado de loop da tinta
entra_tinta = function()
{
    transicao_sprite()
    //chamando a função de mover dentro do estado
    //com isso podemos mover nosso personagem dentro do estado da tinta
    move_player()
    
    
    velv = 0;
    //zerando a velv para eu não poder pular no estado da tinta
    
    //se eu entrei no estado do entra tinta ou seja dentro do poder da tinta
    //então minha mascará de colisão vai mudar
    mask_index = spr_mascara_colisao
    //se eu estou nesse estado então minha mascara de colisão sera spr_mascara_colisao
    
    
    //criando uma variavel para o limitador
    //ele vai olhar um pouco a frente com base no velh multiplado por 12
    //e vai ver um pixel abaixo do meu tile
    //como parametro de colisão do modo tinta ele vai ver se existem mais tiles de tinta
    //ou não na minha frente
    var para = !place_meeting(x + (velh * 12), y + 1, _tile);
    //se não tiver ele roda e zera minha velh com base no if se não se move normalmente dentro
    //tile da tinta
    
    //Criando um limitador para eu não cair se eu estiver no modo de tinta
    if(para)
    {
        //então a velh para
        velh = 0
        show_debug_message(para)
    }
    
    
    if(tinta)
    {
        troca_estado(estado_sai_tinta, [spr_tinta_fim, spr_player_tintasair])
        //se eu estou saindo da tinta então minha mascará muda tambem
        mask_index = spr_player_idle;
        //sai do modo tinta então minha mascará volta a ser a do spr_player_correndo
        
        
        //se eu estou saindo do estado sai tinta ele cria o efeito
        //então ele cria o efeito 
        var cria_efeito = instance_create_layer(x, y, "Efeitos", oParticulas_saitinta)
    }
    
}

//saindo da tinta
estado_sai_tinta = function()
{
    velh = 0
    //zerando a minha velh
    //criando a variavel qtd para ver quantas array tenho
    var _qtd = array_length(lista_sprites) - 1;
    if(anim_acabou() && index_sprite >= _qtd )
    {
        //se minha animação acabou então e meu index for maior que minha lista de arrays
        //ele muda o estado e roda a sprite
        troca_estado(estado_parado, [spr_player_tintasair, spr_player_idle])
    }
    //chamando o metodo de transição
    transicao_sprite()
}




#endregion

#region Debugs

//Criando um metodo que rodará nosso debug
roda_debug = function()
{
    //if(!global.debug) return;
    show_debug_overlay(1);
    
    view_player = dbg_view("View Player", 1, 40, 100, 200, 200)
    
    //Como funciona o dbg_watch ele pede uma referencia da variavel 
    //ou seja nosso velv e pede um texto que será nosso velv
    dbg_watch(ref_create(self ,"velv"), "velocidade vertical")
    //rodando o debug para nossa gravidade
    dbg_watch(ref_create(self ,"grav"), "gravidade")
    
    
    //Como modificar uma informação de debug?
    dbg_slider(ref_create(self ,"velv"), 0, 10, "velocidade vertical max", .1)
    //mudando a gravidade dele
    dbg_slider(ref_create(self ,"grav"), 0, 1, "gravidade max", .01)
}

//rodando o metodo de ativação do debug
ativa_debug = function()
{
    if(!DEBUG_MODE) return
    
    //ao apertar a tecla tab ele rodará nosso ativando debug
    if(ativando_debug) 
    {
        //ao apertar confirmação o aperto da tecla
        //ele fará que nosso global.debug seja igual a not global.debug ou seja ele inverte de false para true
        global.debug = !global.debug
        //ao confirmar que a variavel virou a true
        //se meu global.debug for true
        if(global.debug) 
        {
            //então ele rodará meu roda debug
            roda_debug()
        }
        else 
        {
            //se não
            //ele fará meu show_debug_overlay virar false ou seja 0
        	show_debug_overlay(0);
            //se existir um debug a ser mostrado
            if(dbg_view_exists(view_player))
            {
                //então ele vai deletar esse meu debug ao apertar tab e o resultado dele for se não
               dbg_view_delete(view_player) 
            }
        }
    }
}

//roda_debug();

#endregion

//definindo o estado final do meu player
estado = estado_parado;