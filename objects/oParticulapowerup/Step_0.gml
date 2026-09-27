/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//se existe alvo então ele encerra
if(!alvo) exit;
   
//melhorando o efeito da particula
//usando um image_xscale para aumentar o tamanho dela
image_xscale = lerp(image_xscale, speed * 3, 0.2);
//passando a direção e o angulo
image_angle = direction;

//criando um if para ver se estou voltando ou não
if(volta == false)
{
    //se meu volta for igual a false
    //então ele decrementa ou seja diminui minha speed em 0.1 segundo
    speed -= 0.1;
    if(speed <= 0)
    {
        //se miha speed for menor que zero
        volta = true
        //então ele retorna o volta como true
        //defini uma posição do alvo.x e y
        //e passa essa informação no point_direction que e chamado pelo direcition
        var _x = alvo.x + random_range(-5, 5)
        var _y = alvo.y - 12 + random_range(-5, 5)
        var _dir = point_direction(x, y, _x, _y)
        direction = _dir
        //com isso ele vai ir na direção informada para o player
    }
}
else
{
    speed += 0.1
    var _player = instance_place(x, y, oPlayer)
    //criando uma forma de destruir o efeito
    if(_player)
    {
        //se estou colidindo com o player meu image alpha vai diminuir a 0.09 segundos e vai fazer
        //um efeito de mola tambem
        //rodando um efeito squash do player
        with (oPlayer) 
        {
            //chamando um with que me permite chamar funçoes e metodos de outro objeto
            var _xscale = random_range(0.1, 0.4);
            //fazendo o player ficar meio largo com o random range
            var _yscale = random_range(0.1, 0.7);
            //fazendo ele ficar alto com o random range
            //aplicando o efeito da mola
        	efeito_mola(0.8 + _xscale, 0.5 + _yscale);
            //chamando a função aplica_brilho no with do player
            aplica_brilho(choose(c_white, c_green, c_purple, 
            c_blue, c_aqua, c_orange, c_fuchsia, c_teal), 0.5)
        }
        //fazendo um efeito de screenshake ao encostar no player
        //a tela vai tremer levemente com base nos valores passados do random range
        oScreenshake.treme = random_range(1, 4.2);
        
        //o maximo de opacidade será de 1 ou seja iremos começar com 100 e vai diminuir 90, 80, 70
        image_alpha = clamp(image_alpha - 0.2, 0, 1);
        //show_debug_message(image_alpha)
        //ao atingir zero
        anim++;
        //vou ganhar anim ou seja tempo de animação
        //se meu imagem alpha for menor que zero então ele destroi o objeto ou se meu anim for maior
        //que meu anim_max ele destroi meu objeto
        if(image_alpha <= 0 || anim >= anim_max)
        {
            //eu vou destruir o objeto
            instance_destroy()
            //resetando o anim
            anim = 0;
        }
    }
}