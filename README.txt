Membre du projet : Sylvain Courtin


Lien github : https://github.com/SylvainCourtin/PPC

Lancement du projet à partir des jeux de données donneesX.dzn
Au a partir de votre propre jeu
int:N //Dimensions
int:M //Dimensions
array[1..N] of int: HAUT //tab de N element
array[1..N] of int: BAS //tab de N element


Affichage :
L'affichage affiche la premiere et derniere ligne les tableaux HAUT et BAS
Ensuite nous affichons la matrice de taille N*M

Pour différiencier les différentes liaisons, l'affichage du numéro de la liaison à une coordonnée x,y est données sous format d'un set
exemple : 

1..1|2..2|3..3|0..0    //HAUT
1..1|1..2|{1,3}|1..1
2..2|2..2|3..3|1..1
2..2|{}|3..3|1..1
2..2|{}|3..3|1..1
2..2|0..0|3..3|1..1  //BAS

les coordonnées par une set de deux éléments différent indique un croisement (une barre horizontal et l'autre vertical)
les coordonnées noté par {} ne possède aucune liaison passant par cette emplacement

Compte-rendu

Actuellement le programme fonctionne pour les jeux de données no dog-legs, la partie avec deux segmement horizontal n'est pas fonctionnelle, hélas
Par ailleurs même si le programme fonctionne, il n'est pas assez optimisé, visible avec l'utilisation du jeu de données n°3 (< 15min ) et le jeu n°4 (~3min)

Soucis lors du projet :

Vous pouvez constater, via les logs de git, que mon partenaire,Azri Ridha, n'a pas pu participer au développement du projet. 
Etant abscent aux deux derniers TD, et avec des réponses de mails tardif( avec comme réponse "un sinistre ces dernier jours" le 14/12/2017), 
il n'a pas pu m'aider sur le développement du projet, je me suis donc retrouvé seul lors de l'analyse et sa réalisation.
