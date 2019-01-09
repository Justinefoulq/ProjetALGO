// Pioche
import Foundation
public class pioche : PiocheProtocol{
	typealias TCarte = carte
    
   
	private var nombreCarteSoldat: Int 
	private var nombreCarteArcher: Int
	private var nombreCarteGarde: Int
	private var pioche: [carte]
	//init:  -> PiocheProtocol
	// créer une pioche
	//postCondition: nombreCarte = 20, nombreCarteSoldat=9 , nombreCarteGarde=6,  nombreCarteArcher=5
	public required init(){

        var carte1 : carte = carte()

        carte1.creerSoldat()

        self.pioche.append(carte1)

        var carte2 : carte = carte()

        carte2.creerSoldat()

        self.pioche.append(carte2)

        var carte3 : carte = carte()

        carte3.creerSoldat()

        self.pioche.append(carte3)

        var carte4 : carte = carte()

        carte4.creerSoldat()

        self.pioche.append(carte4)

        var carte5 : carte = carte()

        carte5.creerSoldat()

        self.pioche.append(carte5)

        var carte6 : carte = carte()

        carte6.creerSoldat()

        self.pioche.append(carte6)

        var carte7 : carte = carte()

        carte7.creerSoldat()

        self.pioche.append(carte7)

        var carte8 : carte = carte()

        carte8.creerSoldat()

        self.pioche.append(carte8)

        var carte9 : carte = carte()

        carte9.creerSoldat()

        self.pioche.append(carte9)

        

        var carte10 :carte = carte()

        carte10.creerGarde()

		self.pioche.append(carte10)

        var carte11 :carte = carte()

        carte11.creerGarde()

		self.pioche.append(carte11)

        var carte12 :carte = carte()

        carte12.creerGarde()

		self.pioche.append(carte12)

        var carte13 :carte = carte()

        carte13.creerGarde()

		self.pioche.append(carte13)

        var carte14 :carte = carte()

        carte14.creerGarde()

		self.pioche.append(carte14)

        var carte15 :carte = carte()

        carte15.creerGarde()

		self.pioche.append(carte15)

        

        var carte16 :carte = carte()

        carte16.creerArcher()

		self.pioche.append(carte16)

        var carte17 :carte = carte()

        carte17.creerArcher()

        self.pioche.append(carte16)

        var carte18 :carte = carte()

        carte18.creerArcher()

        self.pioche.append(carte16)

        var carte19 :carte = carte()

        carte19.creerArcher()

        self.pioche.append(carte16)

        var carte20 :carte = carte()

        carte20.creerArcher()

        self.pioche.append(carte16)

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
	func piocher()-> carte{           //----------------il faudrais pas enlever la carte de la pioche ? ------------------
		var taille = self.pioche.count
		let number = Int.random(in: 0 ..< taille-1)
		var renvoyer=self.pioche[number];
		if self.pioche[number].estArcher(){
			nombreCarteArcher = nombreCarteArcher-1
		}else{
			if self.pioche[number].estSoldat(){
				nombreCarteSoldat = nombreCarteSoldat-1
			}else{
				nombreCarteGarde = nombreCarteGarde-1
			}
		}
		return renvoyer
	}

	
	//nombreCartes: PiocheProtocol -> Int
	//renvoie le nombre de cartes qu'il y a dans la pioche
	func nombreCarte()-> Int{
		return self.pioche.count
	}
	
	//getNombreCarteSoldat: Piocheprotocol-> Int
	//renvoie le nombre de cartes soldat restant dans la pioche
	func getNombreCarteSoldat()->Int{
		var compteur = 0
		for carte in pioche {
    			if (carte.getNom()=="Soldat"){
				compteur = compteur+1
			}
		}
		return compteur
	}
	

	//getNombreCarteGarde: Piocheprotocol-> Int
	//renvoie le nombre de cartes garde restant dans la pioche
	func getNombreCarteGarde()-> Int{
		var compteur = 0
		for carte in pioche {
    			if (carte.getNom()=="Garde"){
				compteur = compteur+1
			}
		}
		return compteur
	}

	//getNombreCarteArcher: Piocheprotocol-> Int
	//renvoie le nombre de cartes archer restant dans la pioche
	func getNombreCarteArcher()-> Int{
		var compteur = 0
		for carte in pioche {
    			if (carte.getNom()=="Archer"){
				compteur = compteur+1
			}
		}
		return compteur
	}

	//estVide: Piocheprotocol-> Bool
	//renvoie vrai si la pioche est vide
	//postCondition Si estVide renvoie vrai alors nombreCarte = 0
	func estVide()-> Bool{
		if(pioche.count == 0){
			return true
		}else{
			return false
		}
	}

}
