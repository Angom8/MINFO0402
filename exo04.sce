//A est supposée une matrice triangulaire inférieure (et inversible)
function [X]=RESOUINF(A, b, n)

    X = zeros(b)//On initialise X à 0 en fonction de la taille de b (X étant aussi un vecteur colonne à n composantes)

    X(1)= b(1)/A(1,1)//La première valeur de X est solution de X(1)*A(1,1) = b(1) (Soit AX = b)

    for i=2:n//La nème valeur est solution de la somme de toutes les valeurs de A(i,j) multipliéé chacune par la valeur X(j) correspondant dans le vecteur X, égale à b(i)
        s = 0
        for j=1:(i-1)
            s = s + A(i, j)*X(j)
        end
        X(i) = (b(i)- s)/A(i, i)
    end

endfunction//On retourne X

//Partie 2

//A est supposée une matrice triangulaire inférieure (et inversible)
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


//Début du script

n=5//Taille de la matrice
interval=10//Répartition des valeurs entre 1 et interval

A = round(interval*rand(n,n))
b = round(interval*rand(n,1))

resultat1 = RESOUINF(tril(A),b,n)
resultat2 = RESOUSUP(triu(A),b,n)

verification1 = tril(A)\b
verification2 = triu(A)\b

disp("A :")
disp(A)

disp("b :")
disp(b)

disp("X (RESOUINF) :")
disp(resultat1)
disp("X (RESOUSUP) :")
disp(resultat2)

disp("Vérification X (RESOUINF) :")
disp(verification1)
disp("Vérification X (RESOUSUP) :")
disp(verification2)
