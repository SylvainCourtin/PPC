include "globals.mzn";
%-------------------- Les données sont a utiliser via les fichiers donnees.dzn --------------------------%
%%Constantes
%Dims MxN
int:M; 
int:N;

%Le 0 indique qu'il n'est pas utilisé
array[1..N] of int:HAUT;
array[1..N] of int:BAS;

%Variables
%On va générer une matrice binaire, 1 on a une soudure, 0 sinon
%attention au sens NORD et SUD de la plaque, pour l'instant on gérera comme ça mais on pourrait rajouter une variable pour mieux la gérer si besoin
array[1..M,1..N] of var 0..1:Plaque;

solve satisfy;