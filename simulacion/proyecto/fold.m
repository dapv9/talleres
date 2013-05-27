function [ fold , Efi] = fold( direccion_bd,h,k)
    fold = [zeros(3,1),zeros(3,1)];
    Efi=zeros(3,1);
    media1 = zeros(10,1);
    media2 = zeros(10,1);
    media3 = zeros(10,1);

    for i=1:10
	[Ytest,Yestimado] = gauss(direccion_bd);
	[Conf1,efi1] = MatrizConfusion(Ytest,Yestimado);
	media1(i) = efi1;
	[Ytest,Yestimado] = kvecinos(direccion_bd,k);
	[Conf2,efi2] = MatrizConfusion(Ytest,Yestimado);
	media2(i) = efi2;
	[Ytest,Yestimado] = Parzen(direccion_bd,h);    
	[Conf3,efi3] = MatrizConfusion(Ytest,Yestimado);
	media3(i) = efi3;
    end


    fold(1,1) = mean(media1);
    fold(2,1) = mean(media2);
    fold(3,1) = mean(media3);

    fold(1,2) = std(media1);
    fold(2,2) = std(media2);
    fold(3,2) = std(media3);

end
