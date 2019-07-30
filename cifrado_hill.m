function [n_elementos,x_encriptada] = cifrado_hill(a,link_original,link_encriptada)
printf("Encriptando...\n");

%Leemos la imagen, obteniendo una matriz de 3 dimensiones
[I map alpha] = imread(link_original);
[xx yy zz]=size(I);

n = xx*yy*zz;

%Convertimos la matriz en un vector para que sea posible su 
%cifrado
x = zeros(1,n);
current_x = 1;
for z=1:3
  for i=1:xx
    for j=1:yy
      %vector unidimensional
       x(current_x) = I(i,j,z);
       current_x = current_x+1;
    endfor
  endfor
endfor

%Se usan numeros del 0-255 y una matriz de 2x2
BASE = 256;
NUM = 2;
det_a = mod(a(1,1)*a(2,2) - a(1,2)*a(2,1), BASE);
det_a;
det_a_inv = 1;
%Hallar inverso det_a mod 256

%Si la matriz no cumple con los requisitos, no es posible hacer el cifrado
if(gcd(det_a, BASE) != 1)
  printf("Matriz no valida para encriptacion")
else
  
  %Proceso para obtener la inversa mod 256 de la matriz de cifrado
  for i=1:BASE
    temp = mod(det_a*i, BASE);
    if(temp == 1)
      det_a_inv = i;
      break
   endif
  endfor
  
  det_a_inv;
  
  %Matriz de cofactores
  nueva_a = a;
  nueva_a(1,1) = a(2,2);
  nueva_a(2,2) = a(1,1);
  nueva_a(1,2) = -a(1,2);
  nueva_a(2,1) = -a(2,1);
  nueva_a;
  
  %Matriz inversa
  matriz_inv = det_a_inv * nueva_a;
  matriz_inv = mod(matriz_inv, BASE);
 
  matriz_inv;

  n_elementos = length(x);
  
  %Matriz inversa mod 256
  if rem(n_elementos, NUM) != 0
    n_elementos = n_elementos+1;
  endif
  
  %Matriz donde se guardara la informacion encriptada
  x_encriptada = zeros(1,n_elementos);
  x(n_elementos) = BASE-1;
  matriz_temp = zeros(NUM,1);
  n_elementos;
  
  %Se construye el vector que representa la imagen encriptada
  for i=1:NUM:n_elementos
    
    for j=1:NUM
      matriz_temp(j,1) = x(i+j-1);
    endfor
    
    %Aplicacion de congruencia lineal de tranformacion de cifrado
    matriz_temp = a*matriz_temp;
    
    matriz_temp = mod(matriz_temp, BASE); 
    
    matriz_temp;
    
    %Elementos de imagen encriptada
    for k=1:NUM
      x_encriptada(i+k-1) = matriz_temp(k,1);
    endfor
   endfor
   
   %se pasa a vector que represente una imagen
   NI = I;
   current_xx = 1;
   for z=1:3
     for i=1:1:xx
      for j=1:1:yy
        
        %Proceso inverso, se pasa de un vector a una matriz
        %tridimensional que si se puede representar
       NI(i,j,z) = x_encriptada(current_xx);
       current_xx = current_xx+1;
      endfor
    endfor
   endfor
   
   [xxx yyy zzz]=size(NI);
   
   %Imagen encriptada
   imwrite (NI, link_encriptada);
printf("Encriptación finalizada.\n");
endif

endfunction