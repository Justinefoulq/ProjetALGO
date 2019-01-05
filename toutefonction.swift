//TOUTE FONCTIONS

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
		for i in 0..<self.royaume.count {
				if self.royaume[i]==carteSelectionne {
					self.royaume.remove(at : i)
				}
			}



		
	}

	enum RoyaumeError: Error {
    case royaumeVide
    case cartePasDansRoyaume
	}
	
	func ajouterCarte(carteSel : carte){
		self.royaume.append(carteSel);
	}

}

//-----------------------------------------------------------------------------------------------------



import Foundation

class mainsIterator : IteratorProtocol {
    let ItMain: mains
    var i : Int = 0

    init(Main: mains) {
        self.ItMain = Main
    }

    func next() -> Carte? {
    	let liste = self.ItMain.getMain()
        if self.i < 0 || self.i >= self.ItMain.getMain().count{
        	return nil 
        }
        else {
        	self.i = self.i+1
        	return liste[self.i-1]
        }
    }
}
   
class mains : MainsProtocol{
	//associatedtype Carte : CarteProtocol
	//associatedtype IteratorIdentifiantCarte : IteratorProtocol
	//associatedtype Pioche :  PiocheProtocol // Rajout car on ne peut pas initilaliser en piochant une carte si on a pas acces a la pioche----------------------------
	
	
	private var mains : [Int : carte] //()
	private var carte0 : carte 
	private var carte1 : carte 
	private var carte2 : carte 
	private var carte3 : carte 

	

    
	//init:  ->MainSProtocol
	//Creation de la main d'un joueur
	//Résultat: Renvoie une MainsProtocol avec 1 roi et 3 cartes piochées au hasard dans la pioche
	//post-conditions: non vide
	init(){
		//---------------problème initialiser créerRoi1() ou créer roi 2 mais comment on sais c'est la main de quel joueur ?
		self.carte0=carte.creerRoi1()
		self.carte1=pioche.piocher()
		self.carte2=pioche.piocher()
		self.carte3=pioche.piocher()
		let mains = ["0": carte0, "1": carte1, "2": carte2, "3": carte3 ]
	}


	

	func getMain() -> [Int : Carte]{
		return self.mains
	}

	//nombreCartes:  MainsProtocol-> Int
	//Renvoie le nombre de cartes qu'il y a dans la main du joueur
	//Résultat: renvoie un entier, 0 si vide
	//Post-conditions: entier renvoyé supérieur ou égal à 0
	
	
	func nombreCartes() -> Int {
			return self.mains.count
	}

	//ajouterCarte: CarteProtocol ->MainsProtocol
	//Ajoute la carte passée en paramètre dans la main
	//Résultat: Une carte est ajoutée dans la main du joueur
	//post-conditions nombreCartes augmente de 1
	 func ajouterCarte(carte : Carte){
		self.mains[nombreCartes()] = carte
	}

	//estDansMain: Int -> Bool
	//Résultat: renvoie vrai si l'entier est compris entre 1 et le nb deCartes //-----erreur 0 pas 1
	
	func estDansMains(identifiantCarte : Int ) -> Bool {
		return (identifiantCarte>=0) && (identifiantCarte<nombreCartes())
	}
	

	//enleverCarte: Int ->MainsProtocol
	//Pré-conditions: l'entier entré en paramètre est compris entre 0 et le nombre de cartes dans la main
	//Résultat: Enleve la carte qui à pour identifiant celui passé en paramètre (utiliser getCarteparIdentifiant)
	//post-conditions nombreCartes diminue de 1
	//--------j'ai rajouter les propriete de la fonction setID ici : mettre a jour les identifiant quand on supprime une carte ( car set ID pas utilisé dans le main)
	
	func enleverCarte( identifiantCarte : Int) throws  {
		guard !estDansMains(identifiantCarte: identifiantCarte) else {
			throw MainsError.pasDansMains
		}
		var trans : carte
		mains.removeValue(forKey: identifiantCarte)
		for i in (identifiantCarte+1)..<self.mains.count {
			trans = self.main[i]
			mains.removeValue(forKey: i)
			self.mains[i-1] = trans
		}
		
	}
	


	//getCarteparIdentifiant: Int -> CarteProtocol
	//renvoie une carte à partir d'un identifiant passé en paramètre
	//précondition: identifiantCarte.estDansMain() renvoie True
	//post-conditions: renvoie une Carte qui est dans la main et qui a pour identifiantCarte celui passé en paramètre
	func getCarteparIdentifiant( identifiantCarte : Int) throws -> Carte  {
		guard !estDansMains(identifiantCarte: identifiantCarte) else {
			throw MainsError.pasDansMains
		}
		return self.mains[identifiantCarte]
	}
	



	//estVide: -> Bool
	//Résultat: renvoie vrai si la main est vide
	
	func estVide() -> Bool {
		return self.mains.count == 0 
	}
	
	
	//setID: CarteProtocol -> MainsProtocol  
	//Attribue un id aux cartes de la main
	//Post-conditions: numérote les cartes de 1 à n (n=nombre de cartes de la main, entier) dans l'ordre dans lequel elles ont été piochées (le roi a pour id 1 après init)
	//				   attribue un identifiant à chaque fois qu'on pioche une carte et met à jour quand on en pose une (si on a 5 cartes, lorsque l'on pose la 3, la 4 et 5 deviennent respectivement 3 et 4)
	//Résultat: main avec ses cartes numérotées
	//-----------------------------------------------------vois pas comment faire -----j'ai fait direct dans enlevercarte car setId non utilisé dans le main donc plus simple pour moi
	

	//func setID(carte:Carte) { // nom mal apparoprié c'est plus ne mise a jour de la mains , comment on differencie de cas ou on enlevela carte ou le cas //soit fait plsr fonction soit on specifie mieux les fonction ajout et surpimmer elem de la mains pour que ca incremente ou decremente les id
	//	var nbcarte : Int = nombreCartes() 


	//}

	

	//getId: CarteProtocol -> Int
	//Renvoie l'identifiant de la carte passée en paramètre
	//Pré-conditions:carte passée en paramètre est dans la main
	//Résultat: entiern identifiant de la carte (attribué par setID)
	
	func getID(carte:Carte) throws -> Int  {
		guard !estDansMains(self.mains[carte]) else {
			throw MainsError.pasDansMains
		}
		return self.mains[carte]
		
	}
	
	
	// makeIterator : Mains -> IteratorIdentifiantCarte
	// crée un itérateur sur la collection de couple (identifiantCarte, Carte)
	//Résultat: Renvoie un Iterateur
	//A une fonction next qui renvoie l'identifiant de la carte parcourue  // C'ets quoi l'interet d'avoir un iterateur qui renvois que l'id de la carte ? sachant que ils veulent incrémenter a chaque fois que ce soit 1,2,3,4... bizarre

	
	func makeIterator() -> IteratorIdentifiantCarte { //--------------j'ai fait un iterateur sur les cartes et pas sur les id car id ca sert pas a grand chose
		return MainIterator(main:self)
	}

	enum MainsError: Error {
    case pasDansMains
    
	}

		
	
}




//------------------------------------------------------------------------------------------------



import Foundation


class IteratorNomZone : IteratorProtocol {
	let champ: ChampBataille
    var i : String = "A1" //------Je sais pas a quoi initialiser

    init(champ: ChampBataille) {
        self.champ = champ
    }


    func next() -> zone? { // peut être changer dico avec A1=1 , A2=2 , A2=3 , F1=4,F2=5,F3=6 etC... pour faciliter iteratteur 
    	
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



class ChampBataille : ChampDeBatailleProtocol {
	//associatedtype Zone : ZoneProtocol
   // associatedtype IteratorNomZone : IteratorProtocol
    private var PositionDispo : [String]
	private var champBataille : [String: zone]
	private var ZoneA1 : zone
	private var ZoneA2 : zone
	private var ZoneA3 : zone
	private var ZoneF1 : zone
	private var ZoneF2 : zone
	private var ZoneF3 : zone
	private var Joueur : joueur
   


	//ligne de front, ligne arriere
	//init:  ->ChampDeBatailleProtocol
	//création d'un champ de bataille
	//post-conditions: 2 lignes avec chacune 3 Zones 
	//				   ligne de front: positions F1, F2, F3
	//				   ligne arriere: positions A1, A2, A3
	//Résultat: Champ de bataille avec 6 Zones vides
	
	init(){
		self.PositionDispo = []
		self.ZoneA1 = nil
		self.ZoneA2 = nil
		self.ZoneA3 = nil
		self.ZoneF1 = nil
		self.ZoneF2 = nil
		self.ZoneF3 = nil
		self.Joueur = nil
		let champBataille = ["A1": ZoneA1, "A2": ZoneA2, "A3": ZoneA3, "F1": ZoneF1 , "F2": ZoneF2, "F3": ZoneF3]
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

		if !(zone.estVide(self.champBataille["F1"])) { 
			liste = liste + ["A1"]
		}
		if !(zone.estVide(self.champBataille["F2"])) { 
			liste = liste + ["A2"]
		}
		if !(zone.estVide(self.champBataille["F3"])) { 
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
		guard estVide() else {
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
	func avancerCarte(nomZone:Zone) throws {
		guard (nomZone=="F1" || nomZone=="F2" || nomZone=="F3") else {
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
    func carteAttaquable(cdb: champBataille ,nomZone:String) throws -> [String] {}
    
    //getZone: String -> Zone
    //Renvoie la zone dont le nom est passé en paramètre
    //pré-conditions: Chaîne de caactères entrée en paramètre correspond à une zone initialisée 
    //Resultat: renvoie un zone, celle dont le nom est passé en paramètre
    
    //func getZone(nomZone: String) -> Zone-----------------------------Pas utile ici car dictionnaire mais peut etre a mettre dans zone--------------------
	
    
    //affichageCible: [String] -> 
    //Renvoie les cartes //pas possible la suite ------et toutes leurs propritétés détailées (point de défense restant...) //--- des zones présentes dans la tableau de chaine de caractères passé en paramètre, qui est le résultat de carteAttaquable
    //Résultat: une chaîne de caractères
   
    func affichageCible(carteAttaquable: [String]) -> String{
    	var str : String = ""

    	for i in 0..<champBataille.count {
    		str = str + carteAttaquable[i]
    	}
    }

	// makeIterator : ChampDeBatailleProtocol -> IteratorNomZone
	// crée un itérateur sur la collection de ZoneProtocol 
	//Résultat: Renvoie un Iterateur  // ca sert pas a grand chose de faire un iterateur qui renvois le nom de la zone ? plutot renvoiyer les carte serais mieux...
	
	func makeIterator() -> IteratorNomZone{
		return IteratorNomZone( champ : self)
	}

	enum ChampBatailleError: Error {
    	case ChampBatailleVide
    	case CarteZoneAvant
	}
	
}




///----------------------------------------------------------------------

//Carte
import Foundation

class carte {

	
	private var Nom: String
	private var DefPDef: Int 
	private var Attaque: Int 
	private var PointdeDefduTour: Int 
	private var DefPOff: Int 
	private var Portee: Int //OU String pb----------------------
	private var Position: Bool // true carte en offensive ; false defensive
	private var Zone : zone
	
    //init: -> CarteProtocol
    //Crée une carte vide (en attendant d'appeler les fonctions creer, creerRoi1 par exemple)
    init(){
	self.Nom = ""
	self.DefPDef = 0
	self.Attaque = 0  
	self.PointdeDefduTour = 0
	self.DefPOff = 0   
	self.Portee = 0    
	self.Position = true
	self.Zone = nil
    }
    
    //getNom: CarteProtocol -> String
    //Renvoie le nom de la carte
    //-> String
    func getNom() -> String{
	    return self.Nom
    }     

	//mettreEnPositionOffensive: CarteProtocol -> CarteProtocol
	//met la carte en position offensive ( horizontale )
	func mettreEnPositionOffensive(){
		self.Position=true 
	
	}
    
    //mettreEnPositionDefensive: CarteProtocol -> CarteProtocol
    //met la carte en position Defensive ( verticale )
	func mettreEnPositionDefensive(){
	self.Position=false
    }	    

	//getPointdeDefduTour:  CarteProtocol-> Int
	//Résultat : renvoie les points de def de la carte (au cas où elle a déjà eu des dégâts) après une attaque (points de dégâts cumulésjusqu'à la fin du tour)
	//post conditions: les points de def du tour son > 0 et <= au point de Def en vigueur de la carte
	func getPointdeDefduTour() -> Int{
		 return self.PointdeDefduTour
	}


	//initialiserPointdeDefTour: CarteProtocol -> CarteProtocol 
	//Initialise en début de tour les pointsDeDefTour de la carte en fonction de sa position( offensive ou defensive).  
    //Si elle est en position offensive, alors ptDefDeTour sera égal au résultat de getDefPOff(), sinon il sera égal au résultat de getDefPDef())
	func initialiserPointdeDefTour(){
		if self.Position==true{
			self.PointdeDefduTour=self.getDefPOff() 
		}else{
			self.PointdeDefduTour=self.getDefPDef() 
		}
	}


	//creerRoi1:  ->CarteProtocol
	//Crée un roi1, vous pouvez utiliser les fonctions set
	//Résultat: 1 carte de type roi1
	//Post-conditions: caractéristiques: attaque=1 ; défense/position défensive= 4 ; défense/position oﬀensive = 4 ; portée = toute la ligne devant lui, et la position à une distance 2 devant lui (c’est à dire la case juste derrière celle devant lui); nom=Roi1 ; positionDéfensive=true
	func creerRoi1(){
		self.Attaque=1
		self.DefPDef=4
		self.DefPOff=4
		self.Position=true
		self.Nom="Roi1"
		self.Portee=3 //PB-----------------------------------------------------------
	}


	//CreerRoi2:  ->CarteProtocol
	//Crée un roi2, vous pouvez utiliser les fonctions set
	//Résultat: 1 carte de type Roi2
	//Post-conditions: caractéristiques: attaque=1 ; défense/position défensive = 5 ; défense/position oﬀensive = 4 ; portée= toute la ligne devant lui ; nom=Roi2 ; positionDéfensive=true
	func creerRoi2(){
		self.Attaque=1
		self.DefPDef=4
		self.DefPOff=4
		self.Position=true
		self.Nom="Roi2"
		self.Portee=3 //PB-----------------------------------------------------------
	}

	//CreerSoldat:  ->CarteProtocol
	//Crée un soldat, vous pouvez utiliser les fonctions set
	//Résultat: 1 carte de type Soldat
	//Post-conditions: caractéristiques: attaque = autant que d’cartes dans la Main ; défense/position défensive=2 ; défense/position oﬀensive= 1 ; portée =la position devant lui ; nom=Soldat ; positionDéfensive=true
	func creerSoldat(){
		self.Attaque=nil//PB on sait pas quel main appartient la carte --------------------------------------------------
		self.DefPDef=2
		self.DefPOff=2
		self.Position=true
		self.Nom="Soldat"
		self.Portee=1 //PB-----------------------------------------------------------
	}

	//creerGarde:  ->CarteProtocol
	//Crée un garde, vous pouvez utiliser les fonctions set
	//Résultat: 1 carte de type Garde
	//Post-conditions: caractéristiques: attaque = 1 ; défense/position défensive=3 ; défense/position oﬀensive = 2 ; portée=la position devant lui ; nom=Garde ; positionDéfensive=true
	func creerGarde(){
		self.Attaque=1
		self.DefPDef=3
		self.DefPOff=2
		self.Position=true
		self.Nom="Garde"
		self.Portee=1 //PB-----------------------------------------------------------
	}

	//creerArcher:  ->CarteProtocol
	//Crée un archer, vous pouvez utiliser les fonctions set
	//Résultat: 1 carte de type Archer
	//Post-conditions: caractéristiques: attaque=1 ; défense/position défensive = 2 ; défense/position oﬀensive= 1 ; portée= les 4 positions devant lui qui serait les cases d’arrivée par un mouvement de cavalier aux échecs, c'est-à-dire la position d'arrivée d'un L majuscule (tourné vers la gauche ou la droite) formé par les positions, soit en parcourant 2 positions horizontales + 1 verticale ou 2 positions verticales et 1 horizontale ; nom=Archer ; positionDéfensive=true
	func creerArcher(){
		self.Attaque=1
		self.DefPDef=2
		self.DefPOff=1
		self.Position=true
		self.Nom = "Archer"
		self.Portee=3 //PB-----------------------------------------------------------
	}

	//getAttaque: CarteProtocol -> Int
	//Renvoie la force d'attaque d'une carte
	//Résultat: entier correspondant à la force d'attaque de l'carte
	//Post-conditions: Valeur de la force d'attaque pour chaque carte: Roi1: 1; 
	//																   Roi2: 1; 
	//																   Soldat: égale au nombre d'cartes qu'il y a dans la main (donnée par la fonction NbreCartes du type Mains); 
	//																   Garde: 1;
	//																   Archer: 1
	func getAttaque() -> Int{
		return self.Attaque
	}


	//getDefPDef: CarteProtocol -> Int
	//Renvoie la valeur de la force de défense en position défensive (La carte en position verticale) d'une carte
	//Résultat: entier correspondant à la force de défense en position défensive 
	//Post-conditions:  Valeur de la force de défense en position défensive: Roi1: 4; 
	//																   		 Roi2: 5; 
	//																   		 Soldat: 2; 
	//																   		 Garde: 3;
	//																   		 Archer: 2
	func getDefPDef() -> Int{
		return self.DefPDef
	}

	//getDefPOff: CarteProtocol -> Int
	//Renvoie la valeur de la force de défense en position offensive (La carte en position horizontale) d'une carte
	//Résultat: entier correspondant à la force de défense en position offensive 
	//Post-conditions:  Valeur de la force de défense en position offensive: Roi1: 4; 
	//																   		 Roi2: 4; 
	//																   		 Soldat: 1; 
	//																   		 Garde: 2;
	//																   		 Archer: 1
	func getDefPOff() -> Int{
		return self.DefPOff
	}

	//getPortee: CarteProtocol -> String // -------------> Int 
	//Renvoie la portée d'une carte
	//Résultat: 
	//Post-conditions:  Valeur de la force de défense en position défensive: Roi1: toute la ligne devant lui, et la position à une distance 2 devant lui (c’est à dire la case juste derrière celle devant lui); 
	//																   		 Roi2: toute la ligne devant lui; 
	//																   		 Soldat: la position devant lui; 
	//																   		 Garde: la position devant lui;
	//																   		 Archer: les 4 positions devant lui qui serait les cases d’arrivée par un mouvement de cavalier aux échecs, c'est-à-dire la position d'arrivée d'un L majuscule (tourné vers la gauche ou la droite) formé par les positions, soit en parcourant 2 positions horizontales + 1 verticale ou 2 positions verticales et 1 horizontale
	func getPortee() -> Int  { //PB portee----------------------
		return self.Portee
	}

	//setAttaque: Int -> CarteProtocol
	//Attribue la valeur de la force d'attaque à une carte
	//Pré-conditions: Valeur de la force d'attaque = entier rentré en paramètre = 1 si l'carte est un roi1, roi2, garde ou archer ou égal au nombre d'cartes qu'il y a dans la main (donnée par la fonction NbreCartes du type Mains)
	//Résultat: La carte à une valeur de force d'attaque affectée
	func setAttaque(valeur: Int){
		self.Attaque=valeur
	}
	 
	//setDefPDef: Int -> CarteProtocol
	//Attribue la valeur de la force de défense en position défensive à une carte
	//Pré-conditions: Valeur de la force de défense en position défensive = entier rentré en paramètre = 2 si l'carte est un soldat ou archer, 3 si c'est un garde, 4 si c'est un Roi1, 5 si c'est un Roi2
	//Résultat: La carte à une valeur de force de défense en position défensive affectée
	func setDefPDef(valeur: Int) {
		self.DefPDef=valeur
	}

	//setDefPOff: Int -> CarteProtocol
	//Attribue la valeur de la force de défense en position offensive à une carte
	//Pré-conditions: Valeur de la force de défense en position offensive = entier rentré en paramètre = 1 si l'carte est un soldat ou archer, 2 si c'est un garde, 4 si c'est un Roi1 ou Roi2
	//Résultat: La carte à une valeur de force de défense en position offensive affectée
	func setDefPOff(valeur: Int) {
		self.DefPOff=valeur
	}

	//setPortee: 
	//setPointsDefTour: Int -> CarteProtocol
	// Attibue la valeur de defense de ce tour à une carte
	//Pré-conditions: valeur >= 0 et valeur <= Points de def en fonction de la position de la carte
	//Résultat: La carte à une nouvelle valeur de défense pour ce tour qui lui est affectée
	func setPointsDefTour(valeur: Int) {
		self.PointdeDefduTour=valeur
	}


	//estRoi:CarteProtocol -> Bool
	//Indique si une carte est un roi ou pas, appelle getNom
	//Résultat: Booléen: vrai si la fonction getNom renvoie  Roi1 ou Roi2, faux sinon
	func estRoi() -> Bool{
		if self.Nom=="Roi1" || self.Nom=="Roi2"{
			return true
		}else {
			return false
		}
	}

	//estSoldat:CarteProtocol -> Bool
	//Indique si une carte est un soldat ou pas, apelle getNom
	//Résultat: Booléen: vrai si la fonction getNom renvoie Soldat, faux sinon
	func estSoldat() -> Bool{
		if self.Nom=="Soldat"{
			return true
		
		}else {
			return false
		}
	}

	//EstDefensif: CarteProtocol -> Bool
	//Indique si la carte est en position défensive (vertical)
	//Résultat: retourne true si carte en position défensive, false sinon
	func estDefensif() -> Bool{
		if self.Position==false{
			return true
		}else {
			return false
		}
	}

	func getZone() -> zone{
		return self.Zone		
	}

	func setZone(Zone : zone){
		self.Zone=Zone	
	}
	//estGarde:CarteProtocol -> Bool
	//Indique si une carte est un Garde ou pas, appelle getNom
	//Résultat: Booléen: vrai si la fonction getNom renvoie  Garde1 ou Garde2, faux sinon
	func estGarde() -> Bool{
		if self.Nom=="Garde1" || self.Nom == "Garde2"{
			return true
		}else{
			return false
		}
	}
}
//-----------------------------------------------------------------------------------

//JoueurProtocol
import Foundation
class joueur{
	//main, champ de bataille, royaume, pioche
    
	
	private var nom : String // Joueur1 ou Joueur2
	private var pioche : pioche
	private var royaume : royaume
	private var mains : mains
	private var champDeBataille : ChampDeBataille
	
	//init : ->JoueurProtocol
	//creation d'un joueur avec initialisation de: sa main, son champ de bataille, son royaume, sa pioche
	//post-conditions pour la main: 1 roi, 3 unités piochées au hasard
	//post-conditions pour le champ de bataille: 2 lignes de positions; ligne devant=lignede front avec positions: F1,F2,F3; ligne derriere=ligne arriere avec positions: A1,A2,A3
	//post-conditions pourle royaume: 1 carte piochée au hasard dedans, les cartes devront être reprises dans le royaume dans l'ordre où elles sont arrivées, c'est-à-dire par exemple, 1ere carte placée dans le royaume=1ere carte à pouvoir être déployée
	//post-conditions pour la pioche: 16 carte au hasard, au debut du jeu chaque joueur a 21 cartes dont: 1 roi, 9 soldats, 6 gardes, 5archers, dans les 16 cartes de la pioche il ne peut donc pas avoir de roi
	init(){
		self.mains.init()
		self.champDeBataille.init()
		self.royaume.init()
		self.pioche.init()
	}


	//poserCarte: JoueurProtocol x Int x String ->
	//pose une carte correspondant à l'entier entré en paramètre (numero de carte choisi précédemment, utiliser getCarteparIdentifiant du type Mains) à la position choisie (chaine de caractère entrée en paramètre)
	//pré-conditions: numéro de carte: entier compris entre 1 et 6 (sinon echoue)
	//position choisie: chaîne de caractère, uniquement A1,A2, A3, F1, F2, F3, sinon échoue
	//Si le numéro de carte entré en paramètre ne correspond à une carte présente dans la main (utiliser getMain) alors échoue (exemple: 6 entré en paramètre alors qu'il n'y a que 4 cartes dans la main)
	// Si la position choisie ne correspond pas à une position disponible sur le champs de bataille (utiliser getChampDeBtaille) du joueur alors échoue
	//résultat: la carte indiquée est posée à la position choisie sur le champ de bataille
	//post-conditions: 1 carte en moins dans la main, 1 carte en plus sur le champ de bataille (à la bonne position)
	func poserCarte( identifiantCarte: Int, positionCarte: String) throws{
		guard identifiantCarte>0 || identifiantCarte<7 else {
			throw joueurError.mainincorrecte}		
		if self.champDeBataille.checkPositionDispo(positionCarte){
			self.champDeBataille.AjouterCarte(positionCarte.getZone())
			self.mains.enleverCarte(identifiantCarte)
			
		}
		
	}


	//mobiliser: CarteProtocol x String -> ChampDeBatailleProtocol
	//Prend la carte passée en paramètre dans le royaume (utiliser getRoyaume) et la place sur le champs de bataille (utiliser getChampDeBataille) à la position indiquée (utiliser getZone)
	//Résultat: ChampDeBataille avec n cartes en plus aux positions choisies
	//post-conditions: n cartes en moins dans le royaume, n cartes en plus sur le ChampDeBataille
	func mobiliser(CarteMobilisee: carte, nomZone: String) throws{
		self.royaume.retirerCarte(CarteMobilisee)
		self.champDeBataille.ajouterCarte(CarteMobilisee, nomZone.getZone())//pb de fonction manquante dans champ de bataille---------------------
	}




	//demobiliser: Joueur x Int -> MainsProtocol 
	//retire la carte qui a pour identifiant l'entier passé en paramètre (utiliser getCarteparIdentifiant) de la main et la place dans le royaume (utiliser getMain et getRoyaume)
	//pré-conditions: entier compris entre 1 et 6, sinon échoue
	//Résultat: Main avec une carte en moins
	//Post-conditions: Main avec une carte en moins, royaume avec une carte en plus 
	func demobiliser( identifiantCarte: Int) throws -> mains {
		guard identifiantCarte>0 || identifiantCarte<7 else {
			throw joueurError.mainincorrecte}
		self.mains.enleverCarte(identifiantCarte)
		self.royaume.AjouterCarte(identifiantCarte) //pb manque cette fonction dans royaume ------------------------
		return self.main
	}



	//piocherCarte:  Joueur-> CarteProtocol
	// pioche une carte au hasard dans la pioche (utiliser getPioche), la créer suivant la chaine de caractère renvoyé par la fonction piocher de PiocheProtocol
	// en utilisant les fonctions de création adéquate du type CarteProtocol puis la met dans la main du joueur
	//pré-conditions: pioche non vide
	//résultat: 1 carte 
	//post-conditions: nombrecarte de la pioche à baisssé de 1, 1 carte en plus dans la main
	func piocherCarte() -> carte{
		var carte = self.pioche.piocher()
		self.main.ajouterCarte(carte)
		return carte
	}

	 

	 
	//attaque: CarteProtocol x CarteProtocol-> Int
	//Calcule le résultat d'une attaque entre une carteAttaquante et une carteCiblé
	//précondition: Le premier paramètre est une carte du joueurCourant
	//précondition: Le deuxième paramètre est une carte de l'adversaire
	// renvoie 0 si la première carte correspondant à la carte attaquante à autant d'attaque que les points de défense actuels ( suivant qu'elles soit en position verticale ou horizontale)
	// de la carte attaqué
	// renvoie 1 si la première carte correspondant à la carte attaquante à plus d'attaque que les points de défense actuels ( suivant qu'elles soit en position verticale ou horizontale)
	// de la carte attaqué
	// renvoie 2 si la première carte correspondant à la carte attaquante à plus d'attaque que les points de défense actuels ( suivant qu'elles soit en position verticale ou horizontale)
	// de la carte attaqué et change les pointdeDefduTour de la carte attaqué
	func attaque(carteAttaquante : Carte, carteCiblé: Carte) throws -> Int{
		var test : Int
		if carteAttaquante.getAttaque()==carteCiblé.getDefPDef(){
			test = 0
		}else{
			if carteAttaquante.getAttaque()>carteCiblé.getDefPDef(){
				test=1
			}else {
				test=2
			}
		}
		return test
	}
	
	
	
	//attaquantDispo: String ->Bool 
    //Appelle la fonction ListeAttaquant() du ChampDeBataille du joueur et Vérifie grâce au nom de la zone(chaine de caractère passée en paramètre)  si la carte qui se trouve dans cette zone (utiliser getZone de ChampDeBataille) peut attaquer
	//Résultat: return true si la carteAttaquante(nom de ma zone où se trouve la carte ) est dans listeAttaquant() sinon renvoie false
	func attaquantDispo(carteAttaquante: String) -> Bool{
		var test=false
		var liste=self.champDeBataille.listeAttaquant()
		for (carte) in liste{
			if carte==carteAttaquante{
				test=true
			}
		}
		return test
	}


	//checkCarteAttaque: String x [String] -> Bool
	//Résultat: renvoie vrai si la première chaine de caractères (correspondant à la zone de la carte que veut attaquer le joueur) est dans le tableau de chaîne de caractères passé en 2e paramètre
	// Sinon renvoie faux
    func checkCarteAttaque(nomZoneAttaquant: String, carteAttaquableparJ: [String]) -> Bool{
	    var test=false
	    for (carte) in carteAttaquableparJ{
		    if carte.getNom()==nomZoneAttaquant{
			    test=true
		    }
		    
	    }
	    return test
    }
	
	
	// estAPortee: String x String-> bool
	//Vérifie que la carte dans la première zone (nom passé en premier paramètre) peut attaquer celle dans la zone adverse (nom passé en 2e paramètre) (utiliser getCarteZone et getZone)
	// Pre-conditions : 1ère chaine de caractères passée en paramètre: nom de la zone dans laquelle il y a la carte attaquante, 2e chaine de caractères passée en paramètre: nom de la zone adverse ciblée
	// Resultat : True si la cible est à portée, false sinon
	func estAPortee(zoneAttaquant: String, zoneCible: String) -> Bool{
		var test=false
		var CarteZoneAttaquant: carte
		CarteZoneAttaquant = zoneAttaquant.getCarteZone()
		var CarteZoneCible: carte
		CarteZoneCible=zoneCible.getCarteZone()
		//PB zone attaquanr 
		if (CarteZoneAttaquant.attaquePossible(zoneCible)){
			test=true
		}
		return true
	}
	
	//checkCible: ChampDeBatailleProtocol x [String]->Bool
	//Appelle la fonction de ChampDeBatailleProtocol listeAttaquant et regarde pour chaque carte donné par liseAttaquant si au moins une d'entre elles peut cibler une carte du champs de bataille de l'ennemie
	//Résultat: renvoie vrai si au moins une carte de la listeAttaquant() à une cible à sa porté
	func checkCible(champAdversaire : ChampDeBataille) -> Bool{
		var tab=champAdversaire.listeAttaquant()
		var test=false
		if (tab!=nil){
			test=true
		}
		return test		
	}



	//Capturer: JoueurProtocol x CarteProtocol ->
	//Prend la carte passée en paramètre, la retire du champ de bataille adverse et la place dans le royaume du joueur courant
	//Résultat: Carte en moins dans le champ de bataille adverse et 1 en plus dans le royaume
	func Capturer(carteCapturée : carte){
		self.champDeBataille.CapturerCarte(carteCapturée)
	}
	
    //getPioche: JoueurProtocol -> PiocheProtocol
    //Renvoie la pioche du JoueurProtocol
    func getPioche() -> pioche{
	    return self.pioche
    }
    	
	
    //getRoyaume: JoueurProtocol -> RoyaumeProtocol
    //Renvoie le Royaume du JoueurProtocol
    func getRoyaume() -> royaume{
	    return self.royaume
    }
    
    
    
    //getMain: JoueurProtocol -> MainsProtocol
    //Renvoie la main du JoueurProtocol
    func getMain() -> mains {
	    return self.mains
    }
    
    
    //getChampDeBataille: JoueurProtocol -> ChampDeBatailleProtocol
    //Renvoie le ChampDeBataille du JoueurProtocol
    func getChampDeBataille() -> ChampDeBataille{
	    return self.champDeBataille
    }
    
    //getNomJoueur: JoueurProtocol -> String
	//Renvoie le nom du Joueur : Joueur1 ou Joueur2
	func getNomJoueur() -> String{
		return self.nom
	}
    
    enum joueurError: Error {
    case mainincorrecte
    
	}
    

}
//-----------------------------------------------------------------------------------------------------


//Zone : (Zone | nil )

//ZoneProtocol

//ZoneProtocol est un couple (nomZone, Carte)

import Foundation
class zone{
	// Carte ou nul
    
	
	private var nom: String
	private var carte: carte

	
	//init: String -> ZoneProtocol
	//creer une zone vide
	//précondition: String passé en paramètre peut être (F1 , F2 , F3 , A1, A2 , A3)
	//Initialise le nom de la zone avec la chaine de caractère passé en paramètre
	init(nomZone : String) throws{
		guard (nomZone=="F1" || nomZone=="F2" || nomZone=="F3" || nomZone=="A1" || nomZone=="A2" || nomZone=="A3") else {
			throw zoneError.zoneincorrecte
		}		
		self.nom = nomZone
		}
		
	}



	//getNomZone: ZoneProtocol -> String
	//Renvoie le nom de la zone (F1 , F2 , F3 , A1, A2 , A3)
	func getNomZone() -> String{
		return self.nom
	}

	//setNomZone: String -> ZoneProtocol
	//Initialise le nom de la zone avec la chaine de caractère passé en paramètre
	 func setNomZone(nomZone: String) -> String{
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
	func setCarteZone(carteSelectionne : Carte){
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

enum zoneError: Error {
    case zoneincorrecte


}
//------------------------------------------------------------------------------------

// Pioche
import Foundation
class pioche{
    
    
	private var nombreCarteSoldat: Int 
	private var nombreCarteArcher: Int
	private var nombreCarteGarde: Int
	private var pioche: [carte]
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
