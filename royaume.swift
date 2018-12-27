
//Royaume
import Foundation
   
class royaume : RoyaumeProtocol {
	//typealias royaume = Carte
	//associatedtype Carte : CarteProtocol
	//associatedtype Pioche :  PiocheProtocol // Rajout car on ne peut pas initilaliser en piochant une carte si on a pas acces a la pioche----------------------------

	private var royaume : [carte]

	
	
	//init:  ->RoyaumeProtocol
	//Création d'un royaume
	//Post-conditions: non vide, 1 carte piochée au hasard 
	//le royaume se comporte comme une file d'attente, on peut reprendre les cartes qu'il y a dedans dans l'ordre où on les y a mises
	//Résultat: Royaume non vide
	init() {
		self.royaume=[pioche.piocher()]

	}



	//nombreCitoyens: RoyaumeProtocol -> Int
	//Résultat: Renvoie le nombre de citoyens (cartes) qu'il y a dans le royaume, si royaume vide, renvoie 0
	//Post-conditions: renvoie un entier supérieur ou égal à 0
	func nombreCitoyens() -> Int {
		return self.royaume.count
	}



	//estVide:  -> bool
	// renvoie vrai si le royaume est vide et faux sinon
	//Post-conditions: renvoie faux si nombreCitoyens > 0 et renvoie Vrai si nombreCitoyens = 0
	func estVide() -> Bool{
		return nombreCitoyens()==0
	}

	

	//getfirstCarte: -> CarteProtocol
	//Résultat : renvoie la valeur de la première carte qui a été mise dans le royaume
	func getfirstCarte() -> Carte {
		return nombrecitoyens[0]
	}

	//créer une fonction estDansRoyaume pour faire la fonction removeCarte ( le throws)
	//estDansRoyaume : RoyaumeProtocol x CarteProtocol -> Bool
	//preconditon: Le royaume n'est pas vide
	//Resultat : true si la carte placé en parametre est dans le royaume, false sinon
	func estDansRoyaume(carte : Carte) throws -> Bool  {
		guard estVide() else {
			throw RoyaumeError.royaumeVide
    	}
    	var bool : Bool 
		bool=false
		
    	for i in 0..<self.royaume.count {
				if self.royaume[i]==carte {
					bool=true
				}
			}
		return bool

	}

	//removeCarte: CarteProtocol ->
	//précondition: Carte est dans le Royaume
	//Résultat enlève la carte du Royaume
	//Post-conditions nombreCitoyens à baissé de 1
	func removeCarte(carteSelectionne : Carte) throws { //-------------il faudrait une file -----------------------
		guard !estDansRoyaume(carteSelectionne) else {
			throw RoyaumeError.cartePasDansRoyaume
		}


		
	}

	enum RoyaumeError: Error {
    case royaumeVide
    case cartePasDansRoyaume
	}

}

