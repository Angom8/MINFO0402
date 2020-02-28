function [A,b]=REDUC(A, b, n)//TODO

    for k=1:(n-1)
        for i=(k+1):n
            Aux = A(i,k)/A(k,k)
            A(i,k) = 0
            for j=(k+1):n
                A(i,j) = A(i, j) - Aux*A(k,j)
            end
            b(i) = b(i) - Aux*b(i)
        end
    end

endfunction//On retourne A et b réduits

//Partie 2

//Pour résoudre à la Gauss, on applique simplement une réduction de Gauss sur A et b avant d'obtenir le résultat via RESOUSUP
function [X]=GAUSS(A, b, n)

   [A, b] = REDUC(A,b, n)
   [X] = RESOUSUP(A,b, n)

endfunction//On retourne X

//Début du script

n=5//Taille de la matrice
interval=10//Répartition des valeurs entre 1 et interval

A = round(interval*rand(n,n))
b = round(interval*rand(n,1))

verification = A\b//AX = b peut être résolu avec X = A\b

X = GAUSS(A, b, n)

disp("A :")
disp(A)

disp("b :")
disp(b)

disp("X (Par la fonction) :")
disp(X)

disp("X (Par Scilab) :")
disp(verification)

