include "globals.mzn";
%-------------------- Les données sont a utiliser via les fichiers donnees.dzn --------------------------%
%%Constantes
%Dims MxN
int:M; 
int:N;
%On intègre le HAUT et le BAS à la matrice
int:MCOMPLET=M+2;

set of int:COLS= 1..MCOMPLET;% ->
set of int:ROWS= 1..N;% ↓

int: NBHORIZONTALMAX=1;

%La valeur 0 indique qu'il n'est pas utilisé
array[ROWS] of int:HAUT;
array[ROWS] of int:BAS;

int:MAX=max(max(HAUT),max(BAS));

%Variables
 
array[COLS,ROWS] of var set of 0..MAX: plaque;

%init
constraint forall(i in ROWS)(
  (HAUT[i] in plaque[1,i] /\ card(plaque[1,i]) == 1)
);
constraint forall(i in ROWS)(
  (BAS[i] in plaque[MCOMPLET,i] /\ card(plaque[MCOMPLET,i]) == 1)
);

%On limite le nbr d'élément à 2  (un croisement horizontal et l'autre vertical max)
constraint forall(i in COLS, j in ROWS where i!=1 /\ i!= MCOMPLET)(card(plaque[i,j]) <= 2);

%On vérifie que le croisement ne continue pas sur la suite (on veut une + en croisement)
constraint forall(j in 2..N-1, i in 3..MCOMPLET-2)(
    if card(plaque[i,j]) == 2 then
   card(plaque[i,j] intersect plaque[i-1,j]) == 1 /\
   card(plaque[i,j] intersect plaque[i+1,j]) == 1 /\
    card(plaque[i,j] intersect plaque[i,j-1]) == 1 /\
    card(plaque[i,j] intersect plaque[i,j+1]) == 1
    else true endif
  );
  
%je relis le début
constraint forall(j in ROWS)(
  HAUT[j] == 0 \/ HAUT[j] in plaque[2,j]
);

constraint forall(j in ROWS)(
  BAS[j] == 0 \/ BAS[j] in plaque[MCOMPLET-1,j]
);

%on retire le 0
constraint forall(i in 2..MCOMPLET-1, j in ROWS)
(   plaque[i,j] diff {0} == plaque[i,j]
);
%On trace un chemin, on vérifie que pour une liaison il a exactement 2 voisins (comme le début est fixé ça devrait pas poser de soucis)
constraint forall(j in 2..N-1, i in 2..MCOMPLET-1)(
  (plaque[i,j] intersect plaque[i-1,j] == plaque[i,j] intersect plaque[i+1,j] \/ card(plaque[i,j] intersect plaque[i-1,j]) == 1)  xor % 
  (plaque[i,j] intersect plaque[i,j-1] == plaque[i,j] intersect plaque[i,j+1] \/ card(plaque[i,j] intersect plaque[i,j+1]) == 1) xor %
  
  (plaque[i,j] intersect plaque[i-1,j] == plaque[i,j] intersect plaque[i,j+1] \/ card(plaque[i,j] intersect plaque[i-1,j]) == 1) xor %droite + bas
  (plaque[i,j] intersect plaque[i-1,j] == plaque[i,j] intersect plaque[i,j-1] \/ card(plaque[i,j] intersect plaque[i-1,j]) == 1) xor  %droite + haut
  
  (plaque[i,j] intersect plaque[i+1,j] == plaque[i,j] intersect plaque[i,j+1] \/ card(plaque[i,j] intersect plaque[i+1,j]) == 1) xor %gauche + bas
  (plaque[i,j] intersect plaque[i+1,j] == plaque[i,j] intersect plaque[i,j-1] \/ card(plaque[i,j] intersect plaque[i+1,j]) == 1)   %gauche + haut
);

%la on fait de même mais en vérifiant les bords
constraint forall(i in 2..MCOMPLET-1)( 
  %bord gauche
   (plaque[i,1] intersect plaque[i-1,1] == plaque[i,1] intersect plaque[i+1,1] \/ card(plaque[i,1] intersect plaque[i-1,1]) == 1) xor %vertical
   (plaque[i,1] intersect plaque[i-1,1] == plaque[i,1] intersect plaque[i,2] \/ card(plaque[i,1] intersect plaque[i-1,1]) == 1) xor %bas droite
   (plaque[i,1] intersect plaque[i+1,1] == plaque[i,1] intersect plaque[i,2] \/ card(plaque[i,1] intersect plaque[i+1,1]) == 1) %haut droite
);

constraint forall(i in 2..MCOMPLET-1)(   
  %bord droit
   (plaque[i,N] intersect plaque[i-1,N] == plaque[i,N] intersect plaque[i+1,N] \/ card(plaque[i,N] intersect plaque[i-1,N]) == 1) xor %vertical
   (plaque[i,N] intersect plaque[i-1,N] == plaque[i,N] intersect plaque[i,N-1] \/ card(plaque[i,N] intersect plaque[i-1,N]) == 1) xor %bas gauche
   (plaque[i,N] intersect plaque[i+1,N] == plaque[i,N] intersect plaque[i,N-1] \/ card(plaque[i,N] intersect plaque[i+1,N]) == 1) %haut gauche
);

%On vérifie qu'il n'y a pas plus de deux lignes horizontal (cas no dog-legs) pour une liaison
array[1..MAX] of var 0..N : liaison;

%on compte le nbr d'horizontal par liaison
constraint forall(a in 1..MAX)(
  forall(j in 2..N-1, i in 2..MCOMPLET-1)(
    (a in(plaque[i,j] intersect plaque[i,j-1]) \/ a in (plaque[i,j] intersect plaque[i,j+1])) -> liaison[a]=liaison[a]+1
  )
);
%pas plus de deux horizontal par liaison
constraint forall(i in 1..MAX)( liaison[i] <= NBHORIZONTALMAX);
solve satisfy;

output[if j==N then show(plaque[i,j])++"\n" else show(plaque[i,j])++"|" endif | i in COLS, j in ROWS];
