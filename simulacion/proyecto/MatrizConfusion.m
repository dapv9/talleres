function [ Conf , Eficiencia] = MatrizConfusion(Ytest, Yestimado)
    Conf = zeros(5, 5);

    for i = 1:length(Ytest)
        Conf(Ytest(i), Yestimado(i)) = Conf(Ytest(i), Yestimado(i)) + 1;
    end

    %Halla la eficiencia del programa
    %*Contador = 0;
        
%     for i=1:size(Conf,1)
%         for j=1:size(Conf,2)
%             if i == j
%                 Contador = Contador + Conf(i,j);
%             end
%         end
%     end
    %
    Eficiencia = sum(diag(Conf))/(sum(sum(Conf)));
end
