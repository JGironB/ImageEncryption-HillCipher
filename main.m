clc
#link_ori= "imagen.jpg";
#link_enc= "imagen_encriptada.jpg";
#link_des= "imagen_desencriptada.jpg";
#n=6;
#matriz= [3 7; 2 5];
#[X,Y] = generarPuntos(matriz,n);
#[n,x_s]=cifrado_hill(matriz,link_ori,link_enc);
#matriz_reconstruida = reconstruirMatriz(X,Y);
#descifrado_hill(matriz_reconstruida,n,x_s,link_enc,link_des);


%Menu de prueba para el usuario
printf("Bienvenido\n");
boleano = 1;
x_s=0;
n=6;
while boleano
  
  %Opciones de generar claves, encriptar imagen, o salir
  printf("1. Encriptar Imagen y generar claves\n");
  printf("2. Desencriptar Imagen\n");
  printf("3. Salir\n");
  opcion= input("Que opcion desea?\n");
  switch (opcion)
    case 1
      printf("Opción 1\n");
      link_ori = input("Ingrese link de imagen original\n","s");
      link_enc = input("Ingrese nombre de imagen encriptada a guardar\n","s");
      matriz = input("Ingrese matriz para encriptar\n");
      [usuarios,claves] = generarPuntos(matriz,n);
      usuarios
      claves
      [n_s,x_s]=cifrado_hill(matriz,link_ori,link_enc);
    case 2
      printf("Opción 2\n");
      link_enc = input("Ingrese link de imagen encriptada\n","s");
      link_des = input("Ingrese nombre de imagen desencriptada a guardar\n","s");
      puntos = input("Ingrese numero de contraseñas a ingresar\n");
      x = 1:1:puntos;
      y = zeros(1,puntos);
      for i = 1:1:puntos
        x(i) = input("Ingrese usuario\n");
        y(i) = input("Ingrese contraseña\n");
      endfor
      matriz_reconstruida = reconstruirMatriz(x,y);
      descifrado_hill(matriz_reconstruida,n_s,x_s,link_enc,link_des);
    case 3
      printf("Opción 3\n");
      boleano = 0;
    otherwise
      printf("Opción Incorrecta");
  endswitch
endwhile