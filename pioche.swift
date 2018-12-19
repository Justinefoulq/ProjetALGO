// Pioche
import Foundation
class pioche{
    
    associatedtype Carte: CarteProtocol
	private var nombreCarteSoldat : int 
	private var nombreCarteArcher : int
	private var nombreCarteGarde : int
	private var pioche : [carte]
	//init:  -> PiocheProtocol
	// créer une pioche
	//postCondition: nombreCarte = 20, nombreCarteSoldat=9 , nombreCarteGarde=6,  nombreCarteArcher=5
	init(){
		self.pioche.append(carte.creerSoldat())
		self.pioche.append(carte.creerSoldat())
		self.pioche.append(carte.creerSoldat())
		self.pioche.append(carte.creerSoldat())
		self.pioche.append(carte.creerSoldat())
		self.pioche.append(carte.creerSoldat())
		self.pioche.append(carte.creerSoldat())
		self.pioche.append(carte.creerSoldat())
		self.pioche.append(carte.creerSoldat())
		self.pioche.append(carte.creerGarde())
		self.pioche.append(carte.creerGarde())
		self.pioche.append(carte.creerGarde())
		self.pioche.append(carte.creerGarde())
		self.pioche.append(carte.creerGarde())
		self.pioche.append(carte.creerGarde())
		self.pioche.append(carte.creerArcher())
		self.pioche.append(carte.creerArcher())
		self.pioche.append(carte.creerArcher())
		self.pioche.append(carte.creerArcher())
		self.pioche.append(carte.creerArcher())
	}

	//piocher: -> CarteProtocol
	//précondition: La pioche n'est pas vide
	//renvoie la valeur de la carte tirée aléatoirement parmi les cartes de la pioche et place la carte dans la main
	// si la carte piochée est un soldat (utiliser getNom()) alors nombreCarteSoldat est décrémenté de 1
	// si la carte piochée est un Garde (utiliser getNom()) alors nombreCarteGarde est décrémenté de 1
	// si la carte piochée est un Archer (utiliser getNom()) alors nombreCarteArcher est décrémenté de 1
	// postCondition : nombreCarte est décrémenté de 1 et >=0
	// postCondition : nombreCarteSoldat est >=0
	// postCondition : nombreCarteGarde est  >=0
	// postCondition : nombreCarteArcher est >=0
	mutating func piocher()-> Carte{
		let number = Int.random(in: 0 ..< len(self.pioche)-1)
		return pioche[number];
	}

	
	//nombreCartes: PiocheProtocol -> Int
	//renvoie le nombre de cartes qu'il y a dans la pioche
	func nombreCarte()-> Int
	
	//getNombreCarteSoldat: Piocheprotocol-> Int
	//renvoie le nombre de cartes soldat restant dans la pioche
	func getNombreCarteSoldat()->Int

	//getNombreCarteGarde: Piocheprotocol-> Int
	//renvoie le nombre de cartes garde restant dans la pioche
	func getNombreCarteGarde()-> Int

	//getNombreCarteArcher: Piocheprotocol-> Int
	//renvoie le nombre de cartes archer restant dans la pioche
	func getNombreCarteArcher()-> Int

	//estVide: Piocheprotocol-> Bool
	//renvoie vrai si la pioche est vide
	//postCondition Si estVide renvoie vrai alors nombreCarte = 0
	func estVide()-> Bool

}
