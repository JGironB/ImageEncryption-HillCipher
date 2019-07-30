function [x,y] = generarPuntos(matriz,n)
  
  %convertimos la matriz en un numero, se manera que sea mas
  %sencillo trabajar con la clave o secreto
  texto = "";
  [o l]=size(matriz);
  x = zeros(1,n);
  y = zeros(1,n);
  
  for i=1:1:l
    for j=1:1:o
      num=matriz(i,j);
      %usamos el texto generado por los distintos numeros para
      %concatenar elementos de la matriz
      texto=strcat(texto,num2str(matriz(i,j)));
    endfor
  endfor
  
  texto;
  clave = str2num(texto);
  
  %para generar puntos, solo son necesarios los k fragmentos que al menos
  %deben ser la mitad de ellos
  
  k=n/2;
  a = zeros(1,k);
  for i=1:1:k-1
    a(i)=randi(255);
  endfor
  
  %la clave se guarda en el termino sin x del polinomio
  a(k)= clave;
  
  %polinomio generado
  f=polyout(a,"x");
  count=1;
  
  %se construyen los vectores que representaran los fragmentos
  %con sus respectivos indices
  for i=1:1:n
    x(count)=count;
    count = count+1;
  endfor
  
  y= polyval(a,x);
endfunction