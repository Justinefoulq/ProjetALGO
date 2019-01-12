//Zone : (Zone | nil )

//ZoneProtocol

//ZoneProtocol est un couple (nomZone, Carte)

import Foundation



public class zone : ZoneProtocol {
	// Carte ou nul
	typealias TCarte = carte
	
	fileprivate var nom : String
	fileprivate var carte : carte?

	
	//init: String -> ZoneProtocol
	//creer une zone vide
	//précondition: String passé en paramètre peut être (F1 , F2 , F3 , A1, A2 , A3)
	//Initialise le nom de la zone avec la chaine de caractère passé en paramètre
	public required init(nomZone : String) throws{
		guard (nomZone=="F1" || nomZone=="F2" || nomZone=="F3" || nomZone=="A1" || nomZone=="A2" || nomZone=="A3") else {
			throw zoneError.zoneincorrecte
		}		
		self.nom = nomZone
	}
		
	



	//getNomZone: ZoneProtocol -> String
	//Renvoie le nom de la zone (F1 , F2 , F3 , A1, A2 , A3)
	public func getNomZone() -> String{
		return self.nom
	}

	//setNomZone: String -> ZoneProtocol
	//Initialise le nom de la zone avec la chaine de caractère passé en paramètre
	func setNomZone(nomZone : String) {
		self.nom = nomZone
	}

	//getCarteZone: ZoneProtocol -> CarteProtocol | nil
	//Renvoie la valeur (et description) de la carte présente dans la zone passée en paramètre, si la zone est vide, renvoie nil
	public func getCarteZone() -> carte?{
		if (self.carte == nil){
			return nil
		}else{
			return self.carte
		}  
	}

	//setCarteZone: ZoneProtocol x carteProtocol -> Zone
	//Met la carte passée en paramètre dans la zone passée en paramètre
	//post-conditions: si la zone n'est pas vide, la carte qui était dedans est renvoyée dans la main et remplacée par celle passée en paramètre
	func setCarteZone(carteSelectionne : carte ){
		self.carte = carteSelectionne		
	}

	func setCarteZone (){
		self.carte = nil		
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



enum zoneError: Error {
    case zoneincorrecte

}

