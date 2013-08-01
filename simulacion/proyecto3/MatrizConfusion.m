function [ Conf , Eficiencia] = MatrizConfusion(Ytest, Yestimado)
    Conf = zeros(max(Ytest), max(Ytest));

    for i = 1:length(Ytest)
    if Ytest(i) ~= 0 && Yestimado(i)
        Conf(Ytest(i), Yestimado(i)) = Conf(Ytest(i), Yestimado(i)) + 1;
        end
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
