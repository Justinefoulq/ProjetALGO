
//MainsProtocol


// MainsProtocol est une collection de couple (identifiantCarte, Carte)
// Cette collection peut être parcourue par 1 itérateur.
import Foundation
protocol MainsProtocol : Sequence {
	associatedtype TPioche : PiocheProtocol
    associatedtype TCarte : CarteProtocol
    associatedtype IteratorIdentifiantCarte : IteratorProtocol

    
    
	//init:  ->MainSProtocol
	//Creation de la main d'un joueur
	//Résultat: Renvoie une MainsProtocol avec 1 roi et 3 cartes piochées au hasard dans la pioche
	//post-conditions: non vide
	init(Pioche : TPioche)


	// getmain() -> MainsProtocol
	//fonction qui renvois la main 
	//
	func getmain() 


	

	//ajouterCarte: CarteProtocol -> MainsProtocol
	//Ajoute la carte passée en paramètre dans la main
	//Résultat: Une carte est ajoutée dans la main du joueur
	//post-conditions nombreCartes augmente de 1
	mutating func ajouterCarte(carte : TCarte)


	//enleverCarte: Int ->MainsProtocol
	//Pré-conditions: l'entier entré en paramètre est compris entre 0 et le nombre de cartes dans la main
	//Résultat: Enleve la carte qui à pour identifiant celui passé en paramètre (utiliser getCarteparIdentifiant)
	//post-conditions nombreCartes diminue de 1
	mutating func enleverCarte(identifiantCarte : Int)
	


	//nombreCartes:  MainsProtocol-> Int
	//Renvoie le nombre de cartes qu'il y a dans la main du joueur
	//Résultat: renvoie un entier, 0 si vide
	//Post-conditions: entier renvoyé supérieur ou égal à 0
	func nombreCartes() -> Int


	//getCarteparIdentifiant: Int -> CarteProtocol
	//renvoie une carte à partir d'un identifiant passé en paramètre
	//précondition: identifiantCarte.estDansMain() renvoie True
	//post-conditions: renvoie une Carte qui est dans la main et qui a pour identifiantCarte celui passé en paramètre
	func getCarteparIdentifiant(identifiantCarte : Int) -> TCarte
	

	//estDansMain: Int -> Bool
	//Résultat: renvoie vrai si l'entier est compris entre 1 et le nb deCartes
	func estDansMain(identifiantCarte : Int ) -> Bool
	

	//estVide: -> Bool
	//Résultat: renvoie vrai si la main est vide
	func estVide() -> Bool
	
	
	//setID: CarteProtocol -> MainsProtocol
	//Attribue un id aux cartes de la main
	//Post-conditions: numérote les cartes de 1 à n (n=nombre de cartes de la main, entier) dans l'ordre dans lequel elles ont été piochées (le roi a pour id 1 après init)
	//				   attribue un identifiant à chaque fois qu'on pioche une carte et met à jour quand on en pose une (si on a 5 cartes, lorsque l'on pose la 3, la 4 et 5 deviennent respectivement 3 et 4)
	//Résultat: main avec ses cartes numérotées
	//func setID(carte:carte)--------------------arrive pas -----------------
	
	//getId: CarteProtocol -> Int
	//Renvoie l'identifiant de la carte passée en paramètre
	//Pré-conditions:carte passée en paramètre est dans la main
	//Résultat: entiern identifiant de la carte (attribué par setID)
	func getID(carte:TCarte) -> Int
	
	
	// makeIterator : Mains -> IteratorIdentifiantCarte
	// crée un itérateur sur la collection de couple (identifiantCarte, Carte)
	//Résultat: Renvoie un Iterateur
	//A une fonction next qui renvoie l'identifiant de la carte parcourue 
	func makeIterator() -> IteratorIdentifiantCarte
		
	
}


