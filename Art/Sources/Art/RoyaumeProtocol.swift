//Royaume
import Foundation
protocol RoyaumeProtocol {
    associatedtype Carte : CarteProtocol
	//init:  ->RoyaumeProtocol
	//Création d'un royaume
	//Post-conditions: non vide, 1 carte piochée au hasard 
	//le royaume se comporte comme une file d'attente, on peut reprendre les cartes qu'il y a dedans dans l'ordre où on les y a mises
	//Résultat: Royaume non vide
	init()
	


	//nombreCitoyens: RoyaumeProtocol -> Int
	//Résultat: Renvoie le nombre de citoyens (cartes) qu'il y a dans le royaume, si royaume vide, renvoie 0
	//Post-conditions: renvoie un entier supérieur ou égal à 0
	func nombreCitoyens() -> Int



	//estVide:  -> bool
	// renvoie vrai si le royaume est vide et faux sinon
	//Post-conditions: renvoie faux si nombreCitoyens > 0 et renvoie Vrai si nombreCitoyens = 0
	func estVide() -> Bool

	

	//getfirstCarte: -> CarteProtocol
	//Résultat : renvoie la valeur de la première carte qui a été mise dans le royaume
	func getfirstCarte() -> Carte


	//removeCarte: CarteProtocol ->
	//précondition: Carte est dans le Royaume
	//Résultat enlève la carte du Royaume
	//Post-conditions nombreCitoyens à baissé de 1
	func removeCarte(carteSelectionné : Carte) throws


}
