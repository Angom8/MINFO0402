//A est supposée une matrice triangulaire supérieur (et inversible)
function [X]=RESOUSUP(A, b, n)

    X = zeros(b)//On initialise X à 0 en fonction de la taille de b (X étant aussi un vecteur colonne à n composantes)
    
    //Cette fonction adopte un format plus compact que la fonction RESOUINF. Nous avons également renommé s en aux pour bien les différencier (Matrice sup => en haut => aux)
    for i=n:-1:1//On commence par le bas (calcul du premier membre comme pour RESOUINF, mais à l'envers)
        aux = b(i)
        for k=(i+1):n
            aux = aux - A(i, k)*X(k)//Ici, on aura X(n)*A(n,n) = b(n) et b(1) sera égal à la somme de toutes les valeurs de A(1, j) multipliées par la valeur X(j)
        end
        X(i) = aux/A(i,i)
    end

endfunction//On retourne X

//Transforme AX = b en UX = Y
//U est une matrice triangulaire supérieure (et inversible)
function [A,b]=REDUC(A, b, n)

    for k=1:(n+1)
        for i=(k+1):n
            Aux = A(i,k)/A(k,k) // Calcul le nouveau coefficient
            A(i,k) = 0 // Transforme la partie inférieur de la matrice en 0
            for j=(k+1):n
                A(i,j) = A(i, j) - Aux*A(k,j) // Réduit la matrice A
            end
            b(i) = b(i) - Aux*b(k) // Calcul Y(i) qui remplace b(i)
        end
    end

endfunction//On retourne A et b réduits

//Partie 2

//Pour résoudre à la Gauss, on applique simplement une réduction de Gauss sur A et b avant d'obtenir le résultat via RESOUSUP
function [X]=GAUSS(A, b, n)

   [A,b] = REDUC(A,b, n)
   disp("A réduit :")
   disp(A)
   disp("b réduit :")
   disp(b)
   sleep(5, "s")
   [X] = RESOUSUP(A,b, n)

endfunction//On retourne X

//Début du script

n=5//Taille de la matrice
interval=10//Répartition des valeurs entre 1 et interval

A = round(interval*rand(n,n));
b = round(interval*rand(n,1));

disp("A :")
disp(A)

disp("b :")
disp(b)

X = GAUSS(A, b, n);

verification2 = A\b; 

disp("X (Par la fonction) :")
disp(X)

disp("X (Par Scilab) :")
disp(verification2)

