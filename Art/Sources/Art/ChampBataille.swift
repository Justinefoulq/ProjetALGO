

import Foundation


public class IteratorNomZone : IteratorProtocol {
	typealias TZone = zone

	let champ: champBataille
    var i : String = "A1" //------Je sais pas a quoi initialiser

    public required init(champ: champBataille) {
        self.champ = champ
    }


    public func next() -> zone? { // peut être changer dico avec A1=1 , A2=2 , A2=3 , F1=4,F2=5,F3=6 etC... pour faciliter iteratteur 
    	
		let liste = self.champ
		var ret : String = self.i
		if self.i == "A1" {
			self.i = "A2"
		}else if self.i == "A2" {
			self.i = "A3" 
		}else if self.i == "A3" {
			self.i = "F1" 
		}else if self.i == "F1" {
			self.i = "F2" 
		}else if self.i == "F2" {
			self.i = "F3" 
		}else if self.i == "F3" {
			self.i = "A1" 
		}
		return liste[ret]
    }
    




}



public class champBataille : ChampDeBatailleProtocol {
	typealias TZone = zone

	//associatedtype Zone : ZoneProtocol
   // associatedtype IteratorNomZone : IteratorProtocol
    private var PositionDispo : [String]
	private var champBataille : [String: zone]
	private var Joueur : joueur
   


	//ligne de front, ligne arriere
	//init:  ->ChampDeBatailleProtocol
	//création d'un champ de bataille
	//post-conditions: 2 lignes avec chacune 3 Zones 
	//				   ligne de front: positions F1, F2, F3
	//				   ligne arriere: positions A1, A2, A3
	//Résultat: Champ de bataille avec 6 Zones vides
	
	public required init(){
		self.PositionDispo = []
		self.Joueur = joueur()
		self.champBataille = ["A1": zone(nomZone: "A1"), "A2": zone(nomZone: "A2"), "A3": zone(nomZone: "A3"), "F1": zone(nomZone: "F1") , "Fé": zone(nomZone: "F2"), "F3": zone(nomZone: "F3")]
    }


	//estVide: ChampDeBatailleProtocol -> Bool
	//indique si un champ de bataille est vide ou non
	//résultat: true si le champ de bataille est vide, false sinon
	
	func estVide()->Bool {
		return self.champBataille.count == 0 
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

		if !(self.champBataille["F1"].estVide()) { 
			liste = liste + ["A1"]
		}
		if !(self.champBataille["F2"].estVide()) { 
			liste = liste + ["A2"]
		}
		if !(self.champBataille["F3"].estVide()) { 
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
		return compt != 0
	}


	//listeAttaquant: ChampDeBatailleProtocol-> [String] | nil
	//Résultat : renvoie un tableau de chaines de caractères comportant chaque nom de zone /----------------et une description détaillée des cartes du joueur pouvant attaquer donc étant en position défensive
	//Renvoie nil si aucune carte ne peut attaquer
	
	func listeAttaquant()-> [String]? {
		var liste = [String]() 
		for (cle, valeur) in self.champBataille {
			if valeur.getCarteZone.estDefensif() {
				liste=liste + [cle]
			}
		}
	}

	//initialiserPointdeDefTour: ChampDeBatailleProtocol -> ChampDeBatailleProtocol
	//parcourt toutes les zones du champ de bataille après la phase d'action du joueur adverse et ré-initialise les points de défense de toutes les cartes du champs de bataille en fonction de leur position( defense / attaque) et de leur type d'unité
	
	func initialiserPointdeDefTour(){

		for (cle, valeur) in self.champBataille {
			//Pour le joueur 1 et 2 roi different-------creation Joueur dans champ bataille + fonction getnom() dans joueur.swift
			if valeur.getCarteZone.estRoi() {
				if self.Joueur.getNomJoueur()=="Joueur1"{
					valeur.getCarteZone(setPointsDefTour(4))	
					}else {
						valeur.getCarteZone(setPointsDefTour(5))
					}
					
			}else{
				if valeur.getCarteZone(estSoldat()) {
					if valeur.getCarteZone(estDefensif()){
						valeur.getCarteZone(setPointsDefTour(2))
					}else {
						valeur.getCarteZone(setPointsDefTour(1))
					}					
				}else{
					if valeur.getCarteZone(estGarde()) { //EstGarde n'existais pas : creation dans carte de la fonction
						if valeur.getCarteZone(estDefensif()){
							valeur.getCarteZone(setPointsDefTour(3))
						}else {
							valeur.getCarteZone(setPointsDefTour(1))
						}		

					}else{ //cas si la carte est un archer 
						if valeur.getCarteZone(estDefensif()){
							valeur.getCarteZone(setPointsDefTour(2))
						}else {
							valeur.getCarteZone(setPointsDefTour(1))
						}	
					}
				}


			}
		}
	}

    //initialiserAttaqueSoldat: ChampDeBatailleProtocol -> ChampDeBatailleProtocol
    //parcourt toutes les zones du champ de bataille au début de la phase d'attaque du joueur adverse et ré-initialise les points d'attaque des soldats du champs de bataille en fonction du nombre de cartes qu'il ya dans la main du joueur
   

   //----------Comment je trouve le nombre de cartes dans la main ? J'ai un champ de bataille mais comment je sais a quel joueur il appartient ? Un joueur a une main et un champ de bataille mais comment relis chp bataille a main
    func initialiserAttaqueSoldat() {
    	for (cle, valeur) in self.champBataille {
    		if valeur.getCarteZone(estSoldat()) {
    			valeur.getCarteZone(setAttaque(Joueur.getMain.nombreCartes())) //--------- pb nbcartemain
    		}
    	}
    }



	//replacerCarte: ChampDeBatailleProtocol -> ChampDeBatailleProtocol
	//Parcourt le champ de bataille et appelle la fonction mettreEnPositionDefensive sur chaque carte
	//pre-conditions: champ de bataille non vide
	//résultat: champ de bataille avec ses cartes en position défensive
	
	func replacerCarte() throws {
		guard !estVide() else {
			throw ChampBatailleError.ChampBatailleVide
		}

		for (cle, valeur) in self.champBataille {
			if !(valeur.estVide()) {
				valeur.getCarteZone(mettreEnPositionDefensive())
			} 
		}			
    	
	}


	//Je pense que check avancement et une fonction mutating qui renvoie un chp de bataille modifié
	//checkAvancement: ChampDeBatailleProtocol->
	// Parcourt le champ de bataille et vérifie si une carte doit avancer(si une zone du front vide alors que celle derrière non), et appelle la fct avancerCarte() si c'est le cas
	
	func checkAvancement() {
		if (zone.estVide(self.champBataille["F1"])) && !(zone.estVide(self.champBataille["A1"])) { 
			avancerCarte("A1")	
		}
		if (zone.estVide(self.champBataille["F2"])) && !(zone.estVide(self.champBataille["A2"])){ 
			avancerCarte("A2")	
		}
		if (zone.estVide(self.champBataille["F3"])) && !(zone.estVide(self.champBataille["A3"])) { 
			avancerCarte("A3")	
		}


	}

	//avancerCarte: ZoneProtocol ->
	//avance la carte qui se trouve dans la zone passée en paramètre en ligne de front, sur la zone juste devant
	//pré-conditions: Zone passée en paramètre est une zone arrière (A1,A2 ou A3)
	//Résultat: carte avancée dans la zone devant elle
	//-------------est ce qu'il faut mettre let avat les condition de mon throw , Arnaud la mis dans Zone ----------------------------------------------------
	func avancerCarte(nomZone : zone) throws {
		guard (nomZone=="A1" || nomZone=="A2" || nomZone=="A3") else {
			throw ChampBatailleError.CarteZoneAvant
		}

		if nomZone=="A1" {
			self.champBataille["F1"].setCarteZone(getCarteZone(self.champBataille["A1"]))
			self.champBataille["A1"].setCarteZone(nil)
		}else {
			if nomZone=="A2" {
				self.champBataille["F2"].setCarteZone(getCarteZone(self.champBataille["A2"]))
				self.champBataille["A2"].setCarteZone(nil)
			}else {
				self.champBataille["F3"].setCarteZone(getCarteZone(self.champBataille["A3"]))
				self.champBataille["A3"].setCarteZone(nil)
			}
		}	
	}

	//carteAttaquable: String X ChampDeBatailleProtocol -> [Zone]
	//Pré-conditions: Zone en entrée non vide
	//Résultat: renvoie les zones non vides attaquables dans le champs de bataille de l'ennemie par la carte dans la zone dont le nom est entré en paramètre(utiliser getZone et getCarteZone) en fonction de la portée de la carte présente dans la zone
   	// problème car portée impossible 
    func carteAttaquable(cdb : champBataille , nomZone : String) throws -> [String] {}
    
    //getZone: String -> Zone
    //Renvoie la zone dont le nom est passé en paramètre
    //pré-conditions: Chaîne de caactères entrée en paramètre correspond à une zone initialisée 
    //Resultat: renvoie un zone, celle dont le nom est passé en paramètre
    
    //func getZone(nomZone: String) -> Zone-----------------------------Pas utile ici car dictionnaire mais peut etre a mettre dans zone--------------------
	
    
    //affichageCible: [String] -> 
    //Renvoie les cartes //pas possible la suite ------et toutes leurs propritétés détailées (point de défense restant...) //--- des zones présentes dans la tableau de chaine de caractères passé en paramètre, qui est le résultat de carteAttaquable
    //Résultat: une chaîne de caractères
   
    func affichageCible(carteAttaquable : [String]) -> String{
    	var str : String = ""

    	for i in 0..<champBataille.count {
    		str = str + carteAttaquable[i]
    	}
    }

	// makeIterator : ChampDeBatailleProtocol -> IteratorNomZone
	// crée un itérateur sur la collection de ZoneProtocol 
	//Résultat: Renvoie un Iterateur  // ca sert pas a grand chose de faire un iterateur qui renvois le nom de la zone ? plutot renvoiyer les carte serais mieux...
	
	public func makeIterator() -> IteratorNomZone{
		return IteratorNomZone( champ : self)
	}
	
}

enum ChampBatailleError: Error {
    	case ChampBatailleVide
    	case CarteZoneAvant
	}


