/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//Criando um sistema de screenshake para tremer a tela
treme = 0


//Criando um metodo Screenshake
treme_tela = function()
{
    if(treme > 0.1)
    {
        //ele vai ver se meu treme a maior que meu valor de 0.1
        //caso seja ele vai deslocar 50 pixels o range de forma aleatoria
        //dando a sensação de movimentos da camera
        var _x = random_range(treme, -treme)
        //o mesmo será aplicado para o eixo y
        var _y = random_range(-treme, treme)
        //chamando o view_set_xport que define a posição da minha janela
        //passando a variavel _x para dar a sensação de tremor 
        view_set_xport(view_current, _x)
        //o mesmo se aplica para y
        view_set_yport(view_current, _y)
    }
    else 
    {
    	//Resentando meu tremor
        treme = 0
        //ele vai resetar o tremor 
        //e fará com que a minha janela volte ao normal
        view_set_xport(view_current, 0)
        view_set_yport(view_current, 0)
    }
    //rodando um lerp para suavizar o movimento
    treme = lerp(treme, 0, .1)
}