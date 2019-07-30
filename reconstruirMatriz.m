function matriz = reconstruirMatriz(X,Y)
  
  w=length(X);
  
  %Matriz para guardar los polinomios coeficientes
  L=zeros(w,w);
  
  %Se usa la interpolacion de lagrange como algoritmos
  %para generar el polinomio a partir de los puntos dados
  %por los vectores X,Y
  for k=1:w
    V=1;
    for j=1:w
      if k!=j
        V=conv(V,poly(X(j)))/(X(k)-X(j));
      endif
    endfor
    
    %Termino L del polinomio
    L(k,:)=V;
  endfor
  
  %Vector de coeficientes del polinomio
  C=Y*L;
  %polinomio recuperado
  y=polyout(C,"x");
  
  %Empieza proceso de recuperacion de matriz a partir del polinomio
  clave = num2str(polyval(C,0));
  matriz = zeros(2,2);
  count=1;
  for i=1:1:2
    for j=1:1:2
      %Proceso inverso, se pasa de string a un numero que representa
      %un elemento de la matriz
      matriz(i,j)=str2num(clave(count));
      count=count+1;
    endfor
  endfor
endfunction
