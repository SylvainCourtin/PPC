Membre du projet : Sylvain Courtin


Lien github : https://github.com/SylvainCourtin/PPC

Lancement du projet � partir des jeux de donn�es donneesX.dzn
Au a partir de votre propre jeu
int:N //Dimensions
int:M //Dimensions
array[1..N] of int: HAUT //tab de N element
array[1..N] of int: BAS //tab de N element


Affichage :
L'affichage affiche la premiere et derniere ligne les tableaux HAUT et BAS
Ensuite nous affichons la matrice de taille N*M

Pour diff�riencier les diff�rentes liaisons, l'affichage du num�ro de la liaison � une coordonn�e x,y est donn�es sous format d'un set
exemple : 

1..1|2..2|3..3|0..0    //HAUT
1..1|1..2|{1,3}|1..1
2..2|2..2|3..3|1..1
2..2|{}|3..3|1..1
2..2|{}|3..3|1..1
2..2|0..0|3..3|1..1  //BAS

les coordonn�es par une set de deux �l�ments diff�rent indique un croisement (une barre horizontal et l'autre vertical)
les coordonn�es not� par {} ne poss�de aucune liaison passant par cette emplacement

Compte-rendu

Actuellement le programme fonctionne pour les jeux de donn�es no dog-legs, la partie avec deux segmement horizontal n'est pas fonctionnelle, h�las
Par ailleurs m�me si le programme fonctionne, il n'est pas assez optimis�, visible avec l'utilisation du jeu de donn�es n�3 (< 15min ) et le jeu n�4 (~3min)

Soucis lors du projet :

Vous pouvez constater, via les logs de git, que mon partenaire,Azri Ridha, n'a pas pu participer au d�veloppement du projet. 
Etant abscent aux deux derniers TD, et avec des r�ponses de mails tardif( avec comme r�ponse "un sinistre ces dernier jours" le 14/12/2017), 
il n'a pas pu m'aider sur le d�veloppement du projet, je me suis donc retrouv� seul lors de l'analyse et sa r�alisation.
