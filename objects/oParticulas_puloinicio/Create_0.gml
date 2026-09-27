/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Criando timer para destruir a animação
anim_acabou = 0
anima_deletada = 30

//Criando o metodo para destruir a animação
destroi_anim = function()
{
    //fazendo eu ganhar tempo
    anim_acabou++
    //rodando o if para destruir ele
    if(anim_acabou >= anima_deletada)
    {
        //se meu anim for maior ou igual a anima deletada
        //então ele vai destruir esse objeto
        instance_destroy()
    }
}