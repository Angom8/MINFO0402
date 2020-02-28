//TODO
function [x]=RESOUTRI(a, b, c, d, n)

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

//Début du script

n=10//Taille de la matrice
interval=10//Répartition des valeurs entre 1 et interval

a = round(interval*rand(n,1));
b = round(interval*rand(n,1));
c = round(interval*rand(n,1));
d = round(interval*rand(n,1));

disp("a :")
disp(a)

disp("b :")
disp(b)

disp("c :")
disp(c)

disp("d :")
disp(d)

sleep(5, "s")

X = RESOUTRI(a, b, c, d, n);

f=PRODMATTAB(a, b, c,d,X, n);

resultat= norm(f-d);

disp("X :")
disp(X)

disp("Norme de MX-D (vérifications). Satisfaisant si très proche de 0:")
disp(resultat)

