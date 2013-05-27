function [ Conf , Eficiencia] = MatrizConfusion(Ytest,Yestimado)
    Conf = zeros(length(Ytest),length(Yestimado));
    for i=1:length(Ytest)
        for j=1:length(Yestimado)
            if Ytest(i) == Yestimado(i)
                Conf(i,j) = Conf(i,j) + 1;
            end
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

