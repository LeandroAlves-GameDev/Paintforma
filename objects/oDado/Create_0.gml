/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//criando a maquina de estados do dado
estado = choose("Parada", "Estado_x")
//deixando o estado do dado aleatorio

tempo_estado = irandom_range(60, 180);

//criando um metodo de contador
//nosso contador estado vai guardar o parametro _estado_destino que se refere ao estado atual
contador_estado = function(_estado_destino = "Parada")
{
    //ele vai decrementar nosso tempo que pode mudar devido o irandom_range
    tempo_estado--;
    //se nosso tempo estado for menor ou igual a zero
    if(tempo_estado <= 0)
    { 
        //então ele reseta meu tempo estado para irandom_range novamente
        tempo_estado = irandom_range(60, 180);
        //e chama meu estado atual
        estado = _estado_destino;
    }
}


//criando os metodos que vão armazenar a maquina de estado
estados_dados = function()
{
    //chamando o switch na maquina de estados
    switch (estado) 
    {
        //nosso primeiro case se refere ao estado parado ou seja o dado está parado
        //esse e o estado onde podemos se mover encima dele
        case "Parada":
        {
            //por padrão o estado parado guardar o index zero da imagem
            //ou seja o frame 100% parado da imagem
            image_index = 0;
            //ele tambem informa nosso mask_index que seria nossa sprite index ou seja
            //nosso mask index e igual a spr_dado
            mask_index = sprite_index;
            //chamando a função que armazena nosso metodo de tempo e passando o parametro dentro dela
            //informando qual o proximo estado devo seguir
            contador_estado("Transicao_pro_x")
        }	
        break;
        case "Transicao_pro_x":
        {
            //rodando a transição
            if(image_index >= 8)
            { 
               //se meu image_index for maior ou igual que 8
               estado = "Estado_x"; 
               //então o estado muda para o Estado_x
            }
        }
        break;   
        case "Estado_x":
        {
            //ao atingir o estado x ele verifica define que meu image index e igual a 8
            image_index = 8;
            //ele informa que meu mask index e o spr_vazio ou seja ele perde a mascará de colisão
            //se eu estiver encima do dado e ele mudar para esse estado eu vou cair dele
            mask_index = spr_vazio;
            //chamando o metodo de tempo de novo e informando o proximo estado ele deve ir
            contador_estado("Transicao_pra_seta")
        }
        break;  
        case "Transicao_pra_seta":
        {
            //ao chegar no estado Transicao_pra_seta
            //ele vai verificar se meu image_index e maior ou igual
            //a minha quantidade numeros de imagens - 1
            if(image_index >= image_number - 1)
            {
                //se for maior ou seja atingiu o maximo ou igual o maximo
                //ele volta para o estado parada novamente podendo subir no dado de novo
                estado = "Parada";
            }
            
        }
        break;          
    }
}