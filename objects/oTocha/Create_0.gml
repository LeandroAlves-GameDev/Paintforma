/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Criando o sistema de particulas encima das tochas
cria_part_tocha = function()
{
    ps = part_system_create(ps_brilho)
    
    part_system_position(ps, x, y)
    
}


//chamando o metodo de criação dentro do create para rodar uma vez
cria_part_tocha();