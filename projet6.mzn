include "globals.mzn";
%-------------------- Les données sont a utiliser via les fichiers donnees.dzn --------------------------%
%%Constantes
%Dims MxN
int:M; 
int:N;
int:NIVEAU=2;

set of int:COLS= 1..N;
set of int:ROWS= 1..M;

%Le 0 indique qu'il n'est pas utilisé
array[1..N] of int:HAUT;
array[1..N] of int:BAS;

%Variables
 
array[COLS,ROWS] of var set of COLS: plaque;

%On limite le nbr d'élément à 2  (un croisement horizontal et l'autre vertical max)
constraint forall(i in COLS, j in ROWS)(card(plaque[i,j]) <= 2);

%On vérifie que le croisement ne continue pas sur la suite
constraint forall(i in 2..N-1, j in 2..M-1)(
    card(plaque[i,j]) == 2 /\ 
   card(plaque[i,j] intersect plaque[i-1,j]) == 1 /\
   card(plaque[i,j] intersect plaque[i+1,j]) == 1 /\
    card(plaque[i,j] intersect plaque[i,j-1]) == 1 /\
    card(plaque[i,j] intersect plaque[i,j+1])== 1
  );

solve satisfy;