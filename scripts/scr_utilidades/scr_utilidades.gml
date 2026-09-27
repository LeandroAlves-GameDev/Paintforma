// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

//Criando um sistema de macros para ativar e desativar o debug
#macro DEBUG_MODE 0

#macro modo_normal:DEBUG_MODE 0
#macro modo_debug:DEBUG_MODE 1
#macro FPS game_get_speed(gamespeed_fps) 

//criando uma variavel de controle global para podermos acessar o debug
global.debug = false;

global.chaves = 0;