function [Media] = caracteristicasXcancion( y, Fs, nbits )

    %Algoritmo para sacar las características MFCC y LPCC de la canción
    m1 = mean(y(:,1));

    if length(y(2,:)) == 2
        m2 = mean(y(:,2));

        if (m1 > m2)
            b=y(:,1);
        else
            b=y(:,2);
        end
    else
        b=y(:,1);
    end

    s10 = Fs*10;
    s15 = Fs*15;

    senal=b(s10:s15);

    v=enframe(senal, hamming(ceil(0.03*Fs)), ceil(0.03*Fs/2));
    w=zeros(size(v(:,1),1),32);
    for j = 1:size(v)
        c=lpc(v(j,:),19);
        c1=melcepst(v(j,:),Fs,'R',12,length(v(j,:)),12,length(v(j,:)));
        w(j,:)=[c c1];
    end

    for i=1:32
        Media(i)=mean(w(i,:));
    end
end
