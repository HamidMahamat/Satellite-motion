clear
clf
// Projet d'approx

// Donnees initiales
m=1.;
g=1;

//Definition de quelques fonctions utiles

deff('r=norm2(x1,x2)', 'r=sqrt(x1^2+x2^2)'); // norme euclidienne
deff('F=Ecin(x1,x2)', 'F=m/2*(x1^2+x2^2)');  // Expression cinetique
deff('G=Ep(x1,x2)', 'G=g*m^2/norm2(x1,x2)');  // Expression poteniel
deff('dy=f(t,x1,x2,x3,x4)', 'dy=[x3 x4 -G*m*x1/(x1^2+x2^2)^(3/2) -G*m*x1/(x1^2+x2^2)^(3/2)]');            //  fonction definissant l'edo
ti=0.;              // temps initial
tf=1;               // temps final
xi=[2 1  3 1]       // valeurs initiale
n=6500              // nombre de points
t=linspace(ti, tf, n+1) // subdivision

// Valeur exacte de E (Eexac)
function[F,t]=Exacte(ti,tf,N,x0)
    h=(tf-ti)/N
    t(1)=ti
    F(1)=(x0(3)^2+x0(4)^2)/2-1/(x0(1)^2+x0(2)^2)^(1/2)
    for i=1:N
        F(i+1)=(x0(3)^2+x0(4)^2)/2-1/(x0(1)^2+x0(2)^2)^(1/2)
        t(i+1)=t(i)+h
    end
endfunction
Eexac=Exacte(ti,tf,n,xi)

//Eexac=0
//Eexac =Eexac+ Ecin(xi(3),xi(4))-Ep(xi(1),xi(2)) 


// Euler explicite

function [E, X1, X2, V1, V2]=EulerExp(ti, tf, N, x0)
    h=(tf-ti)/N;
    X1=[x0(1)];
    X2=[x0(2)];
    V1=[x0(3)];
    V2=[x0(4)];
    E=[Ecin(x0(3),x0(4))-Ep(x0(1),x0(2))];
    x1=x0(1);
    x2=x0(2);
    v1=x0(3);
    v2=x0(4);
    e=Ecin(x0(3),x0(4))-Ep(x0(1),x0(2));
    for k=0:N-1
        y1=x1;
        y2=x2;
        x1=x1+h*v1;
        x2=x2+h*v2;
        v1=v1-h*y1/norm2(y1, y2)^3;
        v2=v2-h*y2/norm2(y1, y2)^3;
        e=Ecin(v1,v2)-Ep(x1,x2);
        X1=[X1; x1];
        X2=[X2; x2];
        V1=[V1; v1];
        V2=[V2; v1];
        E=[E; e];
    end
endfunction

// Resultat du calcul
[E1, X1, X2, V1, V2]=EulerExp(ti,tf,n,xi) // approximation de E, q1, q2, q1 point et q2 point


// Schema d'Euler Semi-explicite
function [E, X1, X2, V1, V2]=EulerSemiExp(ti, tf, N, x0)
    h=(tf-ti)/N;
    X1=[x0(1)];
    X2=[x0(2)];
    V1=[x0(3)];
    V2=[x0(4)];
    E=[Ecin(x0(3),x0(4))-Ep(x0(1),x0(2))];
    x1=x0(1);
    x2=x0(2);
    v1=x0(3);
    v2=x0(4);
    e=Ecin(x0(3),x0(4))-Ep(x0(1),x0(2));
    for k=1:N
        y1=x1;
        y2=x2;
        x1=x1/(1+h^2/(norm2(x1,x2))^3) + v1*h/((1+h^2/(norm2(x1,x2))^3));
        x2=x2/(1+h^2/(norm2(y1,y2))^3) + v2*h/((1+h^2/(norm2(y1,y2))^3));
        v1=-y1*(h/(norm2(y1,y2))^3)/(1+h^2/((norm2(y1,y2))^3)) + v1/(1+h^2/(norm2(y1,y2))^3);
        v2=-y2*(h/(norm2(y1,y2))^3)/(1+h^2/((norm2(y1,y2))^3)) + v2/(1+h^2/(norm2(y1,y2))^3);
        e=Ecin(v1,v2)-Ep(x1,x2);
        X1=[X1; x1];
        X2=[X2; x2];
        V1=[V1; v1];
        V2=[V2; v1];
        E=[E; e];
    end
endfunction

[E2, Y1, Y2, W1, W2]=EulerSemiExp(ti,tf,n,xi)


// Quelques autres fonctions utiles
deff('k=l(N)', 'k=max(abs(Exacte(ti, tf, N, xi)-EulerExp(ti, tf, N, xi)))') // renvoie le sup de la difference entre Eexac et E1 pour une subdivison donne
deff('z=s(N)', 'z=max(abs(Exacte(ti, tf, N, xi)-EulerSemiExp(ti, tf, N, xi)))') // renvoie le sup de la difference entre Eexac et E2 pour une subdivison donne

function A=S(X)  // vectorialise s
   A=[];
   for k=1:length(X)
       A=[A;s(X(k))];
   end 
endfunction

function A=L(X)   //vectorialise l
   A=[];
   for k=1:length(X)
       A=[A;l(X(k))];
   end 
endfunction


// trace des graphes

subplot(1,3,1) //trace de Eexac, E1 et E2  
linewidth=3
xlabel('le temps [t]');
ylabel('Energie mecanique [E]')
legends(['Valeur Exacte de E';'Approximation de E par Euler Explicite';'Approximation par Euler semi explicte'],[2,3,5], with_box=%t, opt="ll")
xset("thickness",2.4)

plot2d(t,[Eexac,E1,E2], [2,3,5])


subplot(1,3,3)  // trace de (q1,q2)
xlabel('x')
ylabel('y')
plot2d(X1, X2, style=-1)


//Etude de la convergence des schemas



// N1 doit etre entier
N=linspace(11,210,200)
M1=L(N)
M2=S(N)

subplot(1,3,2)  
xset("thickness",2.4)
plot2d(N, [M1,M2],style=2,[3,5], leg="max(|Exac-E(euler Exp)|@max(|Exac-E(euler Semi Exp)|") // trace de l'erreur sup en fonction de la subdivision




