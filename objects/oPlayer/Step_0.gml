/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//chamando os metodos no step
pega_input();

movimentos();

ativa_debug();

ajusta_escala();

retorna_mola();

retorna_efeito_brilho();

bloqueia_passagem();

//chamando nosso metodo coyote jump 
coyote_jump();

//chamando o metodo de buffer no step
buffer_jump();

modo_corrida();

//rodando um debug de cor 
//if(keyboard_check_pressed(ord("C")))
//{
    ////ele vai pegar a nossa variavel brilho e deixar aleatorio usando a função choose
    ////que permite escolher um valor aleatorio dentro do parametro informado
    //brilho = choose(c_red, c_white, c_aqua, c_green)
    //
//}

//rodando o debug do alpha brilho
//ao apertarmos K ele vai fazer com nosso alpha brilho seja = 1
//if(keyboard_check_pressed(ord("K"))) aplica_brilho()
//{
    ////chamando minha funcão e _vel dele
    //retorna_efeito_brilho();
//}
 

//rodando um debug de reset do jogo
if(keyboard_check_pressed(ord("R")))
{
    //toda vez que eu apertar enter o jogo reseta
    cria_transicao_inicia(room);
    //se eu resetei a room então eu zero as chaves
    global.chaves = 0;
}

//if(keyboard_check_pressed(ord("U")))
//{
    //cria_transicao_inicia(rm_modelo)
//}

if (room == rm_menu) // Substitua rm_menu pelo nome exato da sua room de menu
{
    // Zera a velocidade para ele ficar parado na tela
    velh = 0;
    velv = 0;
    
    exit; // Para a execução do código do player aqui
}


estado();

