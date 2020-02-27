//Globalités pour les fonctions suivantes :
//A est une matrice inversible de taille (n,n) et b un vecteur colonne avec n composantes
//X et la valeur de sortie des fonctions (correspondant la plupart du temps à la solution du problème posé)



//Exercice 4

//Partie 1

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



//Exercice 5

//Partie 1

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



//Exercice 6

//Partie 1

//TODO
function [x]=RESOUTRI(a, b, c , d, n)

    e = zeros(a)//On initialise e et f, vecteurs de même taille que a, b, c ou d
    f = zeros(a)

    e(1) = -c(1)/b(1)
    f(1) = d(1)/b(1)

   for i=2:(n-1)
        deno = a(i)*e(i-1)+b(i)
        e(i)= -c(i) / deno
        f(i) = (d(i) - a(i)*f(i-1))/deno
    end
    f(n) = (d(n)-a(n)*f(n-1))/((a(n)*e(n-1))+b(n))
    x(n) = f(n)

    for i=(n-1):-1:1
        x(i) = e(i)*x(i+1)+f(i)
    end

endfunction

//Partie 2

//On applique le produit de la matrice avec le vecteur x mais avec des tableaux séparés plutôt qu'une matrice. Nos données représentent une matrice diagonale aux valeurs a, b et c
function f=PRODMATTAB(a, b, c,d , x, n)

    f = zeros(a)

    f(1) = b(1)*x(1) + c(1)*x(2)//Première application du calcul 

   for i=2:(n-1)
        f(i) = a(i)*x(i-1)+b(i)*x(i)+c(i)*x(i+1)//ième application du calcul
    end

    f(n) = a(n)*x(n-1)+b(n)*x(n)//Traitement spécial pour la nème application (pas de valeur c(n+1)

endfunction
