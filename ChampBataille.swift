<<<<<<< HEAD

import Foundation
class ChampBataille : ChampDeBatailleProtocol {
	 associatedtype Zone : ZoneProtocol
    associatedtype IteratorNomZone : IteratorProtocol
    private var PositionDispo : [String]
	private var champBataille : [String: Zone]()
	private var ZoneA1 : Zone
	private var ZoneA2 : Zone
	private var ZoneA3 : Zone
	private var ZoneF1 : Zone
	private var ZoneF2 : Zone
	private var ZoneF3 : Zone
   


	//ligne de front, ligne arriere
	//init:  ->ChampDeBatailleProtocol
	//création d'un champ de bataille
	//post-conditions: 2 lignes avec chacune 3 Zones 
	//				   ligne de front: positions F1, F2, F3
	//				   ligne arriere: positions A1, A2, A3
	//Résultat: Champ de bataille avec 6 Zones vides
	
	 init(){
	self.PositionDispo= nil
	self.ZoneA1=nil
	self.ZoneA2=nil
	self.ZoneA3=nil
	self.ZoneF1=nil
	self.ZoneF2=nil
	self.ZoneF3=nil
    let champBataille = ["A1": ZoneA1, "A2": ZoneA2, "A3": ZoneA3, "F1": ZoneF1 , "F2": ZoneF2, "F3": ZoneF3]
    }


	//estVide: ChampDeBatailleProtocol -> Bool
	//indique si un champ de bataille est vide ou non
	//résultat: true si le champ de bataille est vide, false sinon
	
	func estVide()->Bool {
		return champBataille.count == 0 
	}




	//getPositionDispo: ChampDeBatailleProtocol ->[String]
	//renvoie les positions où il est possible de poser une carte, destiné à l'utilisateur
	//résultat: tableau de chaines de caractères qui présente à l'utilisateur les positions où il peut poser une carte sur le champ de bataille
	//post-conditions: positions renvoyées: F1, F2, F3 ou A1, A2, A3
	//				   Si position sur ligne de front libre alors la position correspondante sur la ligne arrière ne l'est pas, exemple: si F1 disponible, alors même si A1 vide, elle n'est pas disponible
	//				   Même s'il y a une carte déjà présente sur une zone, cette dernière est considérer disponible
	
	func getPositionDispo()->[String] {
		var liste : [String]
		liste=["F1","F2","F3"]

		if !(estVide(champBataille["F1"])) { 
			liste = liste + ["A1"]
		}
		if !(estVide(champBataille["F2"])) { 
			liste = liste + ["A2"]
		}
		if !(estVide(champBataille["F3"])) { 
			liste = liste + ["A3"]
		}

	}



	//checkPositionDispo: String -> Bool
	//renvoie vrai si la chaine de caractère en entrée correspond à une des positions disponible renvoyée par getPositionDispo
	
	func checkPositionDispo(nomZone : String)->Bool {
		var compt : Int
		compt=0
		var listedispo : [String]
		listedispo=getPositionDispo()

		for i in 0..<listedispo.count {
			if listedispo[i]==nomZone {
				compt=compt+1
			}
		}
		return compt!=0
	}


	//listeAttaquant: ChampDeBatailleProtocol-> [String] | nil
	//Résultat : renvoie un tableau de chaines de caractères comportant chaque nom de zone /----------------et une description détaillée des cartes du joueur pouvant attaquer donc étant en position défensive
	//Renvoie nil si aucune carte ne peut attaquer
	
	func listeAttaquant()-> [String]? {
		var liste= [String]
		var liste=nil

		for (cle, valeur) in champbataille {
			if valeur.getCarteZone.estDefensif() {
				liste=liste + [cle]
			}
		}
	}

	//initialiserPointdeDefTour: ChampDeBatailleProtocol -> ChampDeBatailleProtocol
	//parcourt toutes les zones du champ de bataille après la phase d'action du joueur adverse et ré-initialise les points de défense de toutes les cartes du champs de bataille en fonction de leur position( defense / attaque) et de leur type d'unité
	
	mutating func initialiserPointdeDefTour(){

		for (cle, valeur) in champbataille {
			//Pour le joueur 1 et 2 roi different---------------determiner le joueur--------
			if valeur.getCarteZone.estRoi() {
				valeur.getCarteZone.setPointsDefTour(4)		
			}else{
				if valeur.getCarteZone.estSoldat() {
					if valeur.getCarteZone.estDefensif(){
						valeur.getCarteZone.setPointsDefTour(2)
					}else {
						valeur.getCarteZone.setPointsDefTour(1)
					}					
				}else{
					if valeur.getCarteZone.estGarde() { //EstGarde n'existe pas ---------------------
						if valeur.getCarteZone.estDefensif(){
							valeur.getCarteZone.setPointsDefTour(3)
						}else {
							valeur.getCarteZone.setPointsDefTour(1)
						}		

					}else{
						if valeur.getCarteZone.estDefensif(){
							valeur.getCarteZone.setPointsDefTour(2)
						}else {
							valeur.getCarteZone.setPointsDefTour(1)
						}	
					}
				}


			}
		}
	}

    //initialiserAttaqueSoldat: ChampDeBatailleProtocol -> ChampDeBatailleProtocol
    //parcourt toutes les zones du champ de bataille au début de la phase d'attaque du joueur adverse et ré-initialise les points d'attaque des soldats du champs de bataille en fonction du nombre de cartes qu'il ya dans la main du joueur
   

   //----------Comment je trouve le nombre de cartes dans la main ? J'ai un champ de bataille mais comment je sais a quel joueur il appartient ? Un joueur a une main et un champ de bataille mais comment relis chp bataille a main
    mutating func initialiserAttaqueSoldat() {
    	for (cle, valeur) in champBataille {
    		if valeur.getCarteZone.estSoldat() {
    			valeur.getCarteZone.setAttaque(nbcartemain) //--------- pb nbcartemain
    		}
    	}
    }



	//replacerCarte: ChampDeBatailleProtocol -> ChampDeBatailleProtocol
	//Parcourt le champ de bataille et appelle la fonction mettreEnPositionDefensive sur chaque carte
	//pre-conditions: champ de bataille non vide
	//résultat: champ de bataille avec ses cartes en position défensive
	
	mutating func replacerCarte() throws {

		if !estVide(self.champBataille){
			for (cle, valeur) in champBataille {
				if !(valeur.estVide()) {
					valeur.getCarteZone.mettreEnPositionDefensive()
				} 			
    		}	
		}else{
			Error
		}
	}


	//Je pense que check avancement et une fonction mutating qui renvoie un chp de bataille modifié
	//checkAvancement: ChampDeBatailleProtocol->
	// Parcourt le champ de bataille et vérifie si une carte doit avancer(si une zone du front vide alors que celle derrière non), et appelle la fct avancerCarte() si c'est le cas
	
	mutating func checkAvancement() {
		if (estVide(champBataille["F1"]) && !(estVide(champBataille["A1"]) { 
			avancercarte("A1")	
		}
		if (estVide(champBataille["F2"]) && !(estVide(champBataille["A2"]) { 
			avancercarte("A2")	
		}
		if (estVide(champBataille["F3"]) && !(estVide(champBataille["A3"]) { 
			avancercarte("A3")	
		}


	}

	//avancerCarte: ZoneProtocol ->
	//avance la carte qui se trouve dans la zone passée en paramètre en ligne de front, sur la zone juste devant
	//pré-conditions: Zone passée en paramètre est une zone arrière (A1,A2 ou A3)
	//Résultat: carte avancée dans la zone devant elle
	//-------------est ce qu'il faut mettre let avat les condition de mon throw , Arnaud la mis dans Zone ----------------------------------------------------
	func avancerCarte(nomZone:Zone) throws {
		if nomZone== "A1" || nomZone== "A2" || nomZone== "A3" {
			if nomZone== "A1" {
				champBataille["F1"].setCarteZone(getCarteZone(champBataille["A1"]))
				champBataille["A1"].setCarteZone(nil)
			}else {
				if nomZone== "A2" {
					champBataille["F2"].setCarteZone(getCarteZone(champBataille["A2"]))
					champBataille["A2"].setCarteZone(nil)
				}else {
					champBataille["F3"].setCarteZone(getCarteZone(champBataille["A3"]))
					champBataille["A3"].setCarteZone(nil)
				}
			}		
		}else{
			Error
		}

	}

	//carteAttaquable: String X ChampDeBatailleProtocol -> [Zone]
	//Pré-conditions: Zone en entrée non vide
	//Résultat: renvoie les zones non vides attaquables dans le champs de bataille de l'ennemie par la carte dans la zone dont le nom est entré en paramètre(utiliser getZone et getCarteZone) en fonction de la portée de la carte présente dans la zone
   
    func carteAttaquable(cdb: Self ,nomZone:String) throws -> [String]
    
    //getZone: String -> Zone
    //Renvoie la zone dont le nom est passé en paramètre
    //pré-conditions: Chaîne de caactères entrée en paramètre correspond à une zone initialisée 
    //Resultat: renvoie un zone, celle dont le nom est passé en paramètre
    
    //func getZone(nomZone: String) -> Zone-----------------------------Pas utile ici car dictionnaire mais peut etre a mettre dans zone--------------------
	
    //affichageCible: [String] -> 
    //Renvoie les cartes //pas possible la suite ------et toutes leurs propritétés détailées (point de défense restant...) //--- des zones présentes dans la tableau de chaine de caractères passé en paramètre, qui est le résultat de carteAttaquable
    //Résultat: une chaîne de caractères
   
    func affichageCible(carteAttaquable: [String]) -> String

	// makeIterator : ChampDeBatailleProtocol -> IteratorNomZone
	// crée un itérateur sur la collection de ZoneProtocol 
	//Résultat: Renvoie un Iterateur
	
	func makeIterator() -> IteratorNomZone

}

}




=======

import Foundation
class ChampBataille : ChampDeBatailleProtocol {
	 associatedtype Zone : ZoneProtocol
    associatedtype IteratorNomZone : IteratorProtocol
    private var PositionDispo : [String]
	private var champBataille : [String: Zone]()
	private var ZoneA1 : Zone
	private var ZoneA2 : Zone
	private var ZoneA3 : Zone
	private var ZoneF1 : Zone
	private var ZoneF2 : Zone
	private var ZoneF3 : Zone
   


	//ligne de front, ligne arriere
	//init:  ->ChampDeBatailleProtocol
	//création d'un champ de bataille
	//post-conditions: 2 lignes avec chacune 3 Zones 
	//				   ligne de front: positions F1, F2, F3
	//				   ligne arriere: positions A1, A2, A3
	//Résultat: Champ de bataille avec 6 Zones vides
	
	 init(){
	self.PositionDispo= nil
	self.ZoneA1=nil
	self.ZoneA2=nil
	self.ZoneA3=nil
	self.ZoneF1=nil
	self.ZoneF2=nil
	self.ZoneF3=nil
    let champBataille = ["A1": ZoneA1, "A2": ZoneA2, "A3": ZoneA3, "F1": ZoneF1 , "F2": ZoneF2, "F3": ZoneF3]
    }


	//estVide: ChampDeBatailleProtocol -> Bool
	//indique si un champ de bataille est vide ou non
	//résultat: true si le champ de bataille est vide, false sinon
	
	func estVide()->Bool {
		return champBataille.count == 0 
	}




	//getPositionDispo: ChampDeBatailleProtocol ->[String]
	//renvoie les positions où il est possible de poser une carte, destiné à l'utilisateur
	//résultat: tableau de chaines de caractères qui présente à l'utilisateur les positions où il peut poser une carte sur le champ de bataille
	//post-conditions: positions renvoyées: F1, F2, F3 ou A1, A2, A3
	//				   Si position sur ligne de front libre alors la position correspondante sur la ligne arrière ne l'est pas, exemple: si F1 disponible, alors même si A1 vide, elle n'est pas disponible
	//				   Même s'il y a une carte déjà présente sur une zone, cette dernière est considérer disponible
	
	func getPositionDispo()->[String] {
		var liste : [String]
		liste=["F1","F2","F3"]

		if !(estVide(champBataille["F1"])) { 
			liste = liste + ["A1"]
		}
		if !(estVide(champBataille["F2"])) { 
			liste = liste + ["A2"]
		}
		if !(estVide(champBataille["F3"])) { 
			liste = liste + ["A3"]
		}

	}



	//checkPositionDispo: String -> Bool
	//renvoie vrai si la chaine de caractère en entrée correspond à une des positions disponible renvoyée par getPositionDispo
	
	func checkPositionDispo(nomZone : String)->Bool {
		var compt : Int
		compt=0
		var listedispo : [String]
		listedispo=getPositionDispo()

		for i in 0..<listedispo.count {
			if listedispo[i]==nomZone {
				compt=compt+1
			}
		}
		return compt!=0
	}


	//listeAttaquant: ChampDeBatailleProtocol-> [String] | nil
	//Résultat : renvoie un tableau de chaines de caractères comportant chaque nom de zone /----------------et une description détaillée des cartes du joueur pouvant attaquer donc étant en position défensive
	//Renvoie nil si aucune carte ne peut attaquer
	
	func listeAttaquant()-> [String]? {
		var liste= [String]
		var liste=nil

		for (cle, valeur) in champbataille {
			if valeur.getCarteZone.estDefensif() {
				liste=liste + [cle]
			}
		}
	}

	//initialiserPointdeDefTour: ChampDeBatailleProtocol -> ChampDeBatailleProtocol
	//parcourt toutes les zones du champ de bataille après la phase d'action du joueur adverse et ré-initialise les points de défense de toutes les cartes du champs de bataille en fonction de leur position( defense / attaque) et de leur type d'unité
	
	mutating func initialiserPointdeDefTour(){

		for (cle, valeur) in champbataille {
			//Pour le joueur 1 et 2 roi different---------------determiner le joueur--------
			if valeur.getCarteZone.estRoi() {
				valeur.getCarteZone.setPointsDefTour(4)		
			}else{
				if valeur.getCarteZone.estSoldat() {
					if valeur.getCarteZone.estDefensif(){
						valeur.getCarteZone.setPointsDefTour(2)
					}else {
						valeur.getCarteZone.setPointsDefTour(1)
					}					
				}else{
					if valeur.getCarteZone.estGarde() { //EstGarde n'existe pas ---------------------
						if valeur.getCarteZone.estDefensif(){
							valeur.getCarteZone.setPointsDefTour(3)
						}else {
							valeur.getCarteZone.setPointsDefTour(1)
						}		

					}else{
						if valeur.getCarteZone.estDefensif(){
							valeur.getCarteZone.setPointsDefTour(2)
						}else {
							valeur.getCarteZone.setPointsDefTour(1)
						}	
					}
				}


			}
		}
	}

    //initialiserAttaqueSoldat: ChampDeBatailleProtocol -> ChampDeBatailleProtocol
    //parcourt toutes les zones du champ de bataille au début de la phase d'attaque du joueur adverse et ré-initialise les points d'attaque des soldats du champs de bataille en fonction du nombre de cartes qu'il ya dans la main du joueur
   

   //----------Comment je trouve le nombre de cartes dans la main ? J'ai un champ de bataille mais comment je sais a quel joueur il appartient ? Un joueur a une main et un champ de bataille mais comment relis chp bataille a main
    mutating func initialiserAttaqueSoldat() {
    	for (cle, valeur) in champBataille {
    		if valeur.getCarteZone.estSoldat() {
    			valeur.getCarteZone.setAttaque(nbcartemain) //--------- pb nbcartemain
    		}
    	}
    }



	//replacerCarte: ChampDeBatailleProtocol -> ChampDeBatailleProtocol
	//Parcourt le champ de bataille et appelle la fonction mettreEnPositionDefensive sur chaque carte
	//pre-conditions: champ de bataille non vide
	//résultat: champ de bataille avec ses cartes en position défensive
	
	mutating func replacerCarte() throws {

		if !estVide(self.champBataille){
			for (cle, valeur) in champBataille {
				if !(valeur.estVide()) {
					valeur.getCarteZone.mettreEnPositionDefensive()
				} 			
    		}	
		}else{
			Error
		}
	}


	//Je pense que check avancement et une fonction mutating qui renvoie un chp de bataille modifié
	//checkAvancement: ChampDeBatailleProtocol->
	// Parcourt le champ de bataille et vérifie si une carte doit avancer(si une zone du front vide alors que celle derrière non), et appelle la fct avancerCarte() si c'est le cas
	
	mutating func checkAvancement() {
		if (estVide(champBataille["F1"]) && !(estVide(champBataille["A1"]) { 
			avancercarte("A1")	
		}
		if (estVide(champBataille["F2"]) && !(estVide(champBataille["A2"]) { 
			avancercarte("A2")	
		}
		if (estVide(champBataille["F3"]) && !(estVide(champBataille["A3"]) { 
			avancercarte("A3")	
		}


	}

	//avancerCarte: ZoneProtocol ->
	//avance la carte qui se trouve dans la zone passée en paramètre en ligne de front, sur la zone juste devant
	//pré-conditions: Zone passée en paramètre est une zone arrière (A1,A2 ou A3)
	//Résultat: carte avancée dans la zone devant elle
	//-------------est ce qu'il faut mettre let avat les condition de mon throw , Arnaud la mis dans Zone ----------------------------------------------------
	func avancerCarte(nomZone:Zone) throws {
		if nomZone== "A1" || nomZone== "A2" || nomZone== "A3" {
			if nomZone== "A1" {
				champBataille["F1"].setCarteZone(getCarteZone(champBataille["A1"]))
				champBataille["A1"].setCarteZone(nil)
			}else {
				if nomZone== "A2" {
					champBataille["F2"].setCarteZone(getCarteZone(champBataille["A2"]))
					champBataille["A2"].setCarteZone(nil)
				}else {
					champBataille["F3"].setCarteZone(getCarteZone(champBataille["A3"]))
					champBataille["A3"].setCarteZone(nil)
				}
			}		
		}else{
			Error
		}

	}

	//carteAttaquable: String X ChampDeBatailleProtocol -> [Zone]
	//Pré-conditions: Zone en entrée non vide
	//Résultat: renvoie les zones non vides attaquables dans le champs de bataille de l'ennemie par la carte dans la zone dont le nom est entré en paramètre(utiliser getZone et getCarteZone) en fonction de la portée de la carte présente dans la zone
   
    func carteAttaquable(cdb: Self ,nomZone:String) throws -> [String]
    
    //getZone: String -> Zone
    //Renvoie la zone dont le nom est passé en paramètre
    //pré-conditions: Chaîne de caactères entrée en paramètre correspond à une zone initialisée 
    //Resultat: renvoie un zone, celle dont le nom est passé en paramètre
    
    //func getZone(nomZone: String) -> Zone-----------------------------Pas utile ici car dictionnaire mais peut etre a mettre dans zone--------------------
	
    //affichageCible: [String] -> 
    //Renvoie les cartes //pas possible la suite ------et toutes leurs propritétés détailées (point de défense restant...) //--- des zones présentes dans la tableau de chaine de caractères passé en paramètre, qui est le résultat de carteAttaquable
    //Résultat: une chaîne de caractères
   
    func affichageCible(carteAttaquable: [String]) -> String

	// makeIterator : ChampDeBatailleProtocol -> IteratorNomZone
	// crée un itérateur sur la collection de ZoneProtocol 
	//Résultat: Renvoie un Iterateur
	
	func makeIterator() -> IteratorNomZone

}

}




>>>>>>> e1e08964e9d030851668dc84b14e2b685bbef96f
