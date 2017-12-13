include "globals.mzn";
%-------------------- Les données sont a utiliser via les fichiers donnees.dzn --------------------------%
%%Constantes
%Dims MxN
int:M; 
int:N;
set of int:COLS= 1..N;
set of int:ROWS= 1..M;

%Le 0 indique qu'il n'est pas utilisé
array[1..N] of int:HAUT;
array[1..N] of int:BAS;

%Variables
 
array[COLS,ROWS] of var set of COLS: plaque;

%On limite le nbr d'élément à 2  (un croisement horizontal et l'autre vertical max)
constraint forall(i in COLS, j in ROWS)(card(plaque[i,j]) in 0..2);

%On vérifie que le croisement ne continue pas sur la suite
constraint forall(i in 2..N-1, j in 2..M-1)(
    card(plaque[i,j]) == 2 /\ 
   card(plaque[i,j] intersect plaque[i-1,j]) == 1 /\
   card(plaque[i,j] intersect plaque[i+1,j]) == 1 /\
    card(plaque[i,j] intersect plaque[i,j-1]) == 1 /\
    card(plaque[i,j] intersect plaque[i,j+1]) == 1
  );

%Maintenant on vérifie qu'il existe bien un chemin / trace un chemin
% nous avons FORCEMENT le début au niveau de chaque réseau
constraint forall(n in COLS)(
  HAUT[n] == 0 \/ HAUT[n] in plaque[n,1]
);
constraint forall(n in COLS)(
  BAS[n] == 0 \/ BAS[n] in plaque[n,M]
);

%On vérifie qu'il n'y a pas plus de deux lignes horizontal (cas no dog-legs) pour une liaison
constraint forall()(
);

solve satisfy;