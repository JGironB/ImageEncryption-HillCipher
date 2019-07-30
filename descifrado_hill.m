function  descifrado_hill(a,n_elementos,x_encriptada,link_encriptada,link_descifrada)
  
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
  
  %Se haya el el determinante mod 256 de la matriz de cifrado
  for i=1:BASE
    temp = mod(det_a*i, BASE);
    if(temp == 1)
      det_a_inv = i;
      break
    endif
  endfor
  
  det_a_inv;
  
  
  %Matriz de cofactores de la matriz a
  nueva_a = a;
  nueva_a(1,1) = a(2,2);
  nueva_a(2,2) = a(1,1);
  nueva_a(1,2) = -a(1,2);
  nueva_a(2,1) = -a(2,1);
  nueva_a;
  
  %Se haya la matriz inversa usando el inverso del determinante
  matriz_inv = det_a_inv * nueva_a;
  matriz_inv = mod(matriz_inv, BASE);
 
  matriz_inv;


%Se obtiene la imagen ahora encriptada
[I map alpha] = imread(link_encriptada);
[xx yy zz]=size(I);

n = xx*yy*zz;


%Proceso de desencriptacion
   printf("Desencriptando...\n");
   for i=1:NUM:n_elementos
    
    for j=1:NUM
      matriz_temp(j,1) = x_encriptada(i+j-1);
    endfor
    
    %Se aplica ahora la tranformacion inversa, usando la inversa mod 256 de la 
    %matriz a
    matriz_temp = matriz_inv*matriz_temp;
    
    matriz_temp = mod(matriz_temp, BASE); 
    
    matriz_temp;
    
    %Elementos de matriz desencriptada
    for k=1:NUM
      x_desencriptada(i+k-1) = matriz_temp(k,1);
    endfor
   endfor
   
   
%se pasa a vector que represente una imagen
IMAGEN = I;
current_xx = 1;
for z=1:3
  for i=1:1:xx
    for j=1:1:yy
       %Proceso inverso, se pasa de un vector a una matriz
       %tridimensional que si se puede representar
       IMAGEN(i,j,z)= x_desencriptada(current_xx);
       current_xx = current_xx+1;
    endfor
  endfor
endfor


%Imagen desencriptada   
imwrite (IMAGEN, link_descifrada);
printf("Imagen desencriptada.\n");
endif
endfunction