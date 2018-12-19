//Zone : (Zone | nil )

//ZoneProtocol

//ZoneProtocol est un couple (nomZone, Carte)

import Foundation
protocol ZoneProtocol{
	// Carte ou nul
    associatedtype Carte : CarteProtocol
	//init: String -> ZoneProtocol
	//creer une zone vide
	//précondition: String passé en paramètre peut être (F1 , F2 , F3 , A1, A2 , A3)
	//Initialise le nom de la zone avec la chaine de caractère passé en paramètre
	init(nomZone : String) throws

	//getNomZone: ZoneProtocol -> String
	//Renvoie le nom de la zone (F1 , F2 , F3 , A1, A2 , A3)
	func getNomZone() -> String

	//setNomZone: String -> ZoneProtocol
	//Initialise le nom de la zone avec la chaine de caractère passé en paramètre
	mutating func setNomZone(nomZone: String) -> String

	//getCarteZone: ZoneProtocol -> CarteProtocol | nil
	//Renvoie la valeur (et description) de la carte présente dans la zone passée en paramètre, si la zone est vide, renvoie nil
	func getCarteZone() -> Carte?

	//setCarteZone: ZoneProtocol x carteProtocol -> Zone
	//Met la carte passée en paramètre dans la zone passée en paramètre
	//post-conditions: si la zone n'est pas vide, la carte qui était dedans est renvoyée dans la main et remplacée par celle passée en paramètre
	mutating func setCarteZone(carteSelectionné : Carte)

	//estVide: ZoneProtocol -> Bool
	//Renvoie vrai si la zone est vide
	//sinon renvoie faux
	func estVide()-> Bool


}
