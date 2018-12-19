//Zone : (Zone | nil )

//ZoneProtocol

//ZoneProtocol est un couple (nomZone, Carte)

import Foundation
class zone{
	// Carte ou nul
    associatedtype Carte : CarteProtocol
	
	private var nom : String
	private var carte : carte
	//init: String -> ZoneProtocol
	//creer une zone vide
	//précondition: String passé en paramètre peut être (F1 , F2 , F3 , A1, A2 , A3)
	//Initialise le nom de la zone avec la chaine de caractère passé en paramètre
	init(nomZone : String) throws{
		if let nomZone =="F1"||nomZone =="F2"||nomZone=="F3"||nomZone=="A1"||nomZone=="A2"||nomZone=="A3"{
			self.nom = nomZone
		}else{
			Error
		}
	}

	//getNomZone: ZoneProtocol -> String
	//Renvoie le nom de la zone (F1 , F2 , F3 , A1, A2 , A3)
	func getNomZone() -> String{
		return self.nom
	}

	//setNomZone: String -> ZoneProtocol
	//Initialise le nom de la zone avec la chaine de caractère passé en paramètre
	mutating func setNomZone(nomZone: String) -> String{
		self.nom = nomZone
	}

	//getCarteZone: ZoneProtocol -> CarteProtocol | nil
	//Renvoie la valeur (et description) de la carte présente dans la zone passée en paramètre, si la zone est vide, renvoie nil
	func getCarteZone() -> Carte?{
		if (self.carte == nil){
			return nil
		}else{
			return self.carte
		}  
	}

	//setCarteZone: ZoneProtocol x carteProtocol -> Zone
	//Met la carte passée en paramètre dans la zone passée en paramètre
	//post-conditions: si la zone n'est pas vide, la carte qui était dedans est renvoyée dans la main et remplacée par celle passée en paramètre
	mutating func setCarteZone(carteSelectionne : Carte){
		self.carte = carteSelectionne		
	}

	//estVide: ZoneProtocol -> Bool
	//Renvoie vrai si la zone est vide
	//sinon renvoie faux
	func estVide()-> Bool{
		if (self.carte==nil){
			return true
		}else{
			return false
		}
	}


}
