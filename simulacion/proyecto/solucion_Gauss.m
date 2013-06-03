function [ ] = solucion_Gauss( num_clases)


eficiencia_global=0;
vector_eficiencia=[];
datos = xlsread('base_de_datos.xlsx');
h = crossvalind ('kfold', 20000,10);

c1 = 1;
c2 = 1;
c3 = 1;
c4 = 1;
c5 = 1;
c6 = 1;
c7 = 1;
c8 = 1;
c9 = 1;
c10 =1;


for i=1:20000
   
    if(h(i)==1)
       muestra = datos(i,:);
       fold_1(c1,:) = muestra; 
       c1 = c1+1;
    end
    
    if(h(i)==2)
       muestra = datos(i,:);
       fold_2(c2,:) = muestra; 
       c2 = c2+1;
    end
    
    if(h(i)==3)
       muestra = datos(i,:);
       fold_3(c3,:) = muestra;
       c3 = c3+1;
    end
    
    if(h(i)==4)
       muestra = datos(i,:);
       fold_4(c4,:) = muestra;
       c4 = c4+1;
    end
    
    if(h(i)==5)
       muestra = datos(i,:);
       fold_5(c5,:) = muestra; 
       c5 = c5+1;
    end
    
    if(h(i)==6)
       muestra = datos(i,:);
       fold_6(c6,:) = muestra;
       c6 = c6+1;
    end
    
    if(h(i)==7)
       muestra = datos(i,:);
       fold_7(c7,:) = muestra;  
       c7 = c7+1;
    end
    
    if(h(i)==8)
       muestra = datos(i,:);
       fold_8(c8,:) = muestra; 
       c8 = c8+1;
    end
    
    if(h(i)==9)
       muestra = datos(i,:);
       fold_9(c9,:) = muestra; 
       c9 = c9+1;
    end
    
    if(h(i)==10)
       muestra = datos(i,:);
       fold_10(c10,:) = muestra; 
       c10 = c10+1;
    end
    
end

matriz_test = [];
matriz_train = [];
celda = {fold_1,fold_2,fold_3,fold_4,fold_5,fold_6,fold_7,fold_8,fold_9,fold_10};

for i=1:10
    
    matriz_test = celda{i};
    
    for j=1:10
       
        if(j~=i)
            
           matriz_train = [matriz_train;celda{j}];
            
        end
        
    end
    
    ytest = matriz_test(:,1);
    xtest = matriz_test(:,2:end);
    ytrain = matriz_train(:,1);
    xtrain = matriz_train(:,2:end);
   
    %%%%%%%%%%%%%%%%%%% normalizacion %%%%%%%%%%%%%%%%
    
    [xtrain, mu, sigma] = zscore(xtrain);
    xtest = (xtest-repmat(mu,size(xtest,1),1))./repmat(sigma,size(xtest,1),1);
    
    
    y_estimado = Gauss(xtrain,xtest, ytrain, num_clases);
    
    matriz_confusion = zeros(26,26);
    
    for k=1:size(ytest,1)
       
        m = ytest(k); %%%%%%% real
        %disp(m);
        n = y_estimado(k); %%%%%%%%%%% estimado
        %disp(n);
        matriz_confusion(m,n)= matriz_confusion(m,n)+1;
        
    end
    
    
    vector_diagonal = diag(matriz_confusion);
    sum_diagonal = sum(vector_diagonal);
    sum_matriz = sum(sum(matriz_confusion));
    eficiencia = sum_diagonal/sum_matriz;
    vector_eficiencia=[vector_eficiencia,eficiencia];
    disp(eficiencia);
    eficiencia_global = eficiencia_global+(eficiencia/10);
    
    
     
end
disp('la eficiencia del sistema es:  ');
disp(eficiencia_global);
desviacion_estandar= std(vector_eficiencia);
disp('La desviación estándar es: ');
disp(desviacion_estandar);
   
    
end



