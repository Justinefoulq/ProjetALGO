//JoueurProtocol
import Foundation
class joueur{
	//main, champ de bataille, royaume, pioche
    associatedtype ChampDeBataille : ChampDeBatailleProtocol
    associatedtype Carte: CarteProtocol
    associatedtype Mains: MainsProtocol
    associatedtype Royaume: RoyaumeProtocol
    associatedtype Pioche: PiocheProtocol
	
	private var nom : String // Joueur1 ou Joueur2
	private var pioche : pioche
	private var royaume : royaume
	private var main : main
	private var champDeBataille : champDeBataille
	
	//init : ->JoueurProtocol
	//creation d'un joueur avec initialisation de: sa main, son champ de bataille, son royaume, sa pioche
	//post-conditions pour la main: 1 roi, 3 unités piochées au hasard
	//post-conditions pour le champ de bataille: 2 lignes de positions; ligne devant=lignede front avec positions: F1,F2,F3; ligne derriere=ligne arriere avec positions: A1,A2,A3
	//post-conditions pourle royaume: 1 carte piochée au hasard dedans, les cartes devront être reprises dans le royaume dans l'ordre où elles sont arrivées, c'est-à-dire par exemple, 1ere carte placée dans le royaume=1ere carte à pouvoir être déployée
	//post-conditions pour la pioche: 16 carte au hasard, au debut du jeu chaque joueur a 21 cartes dont: 1 roi, 9 soldats, 6 gardes, 5archers, dans les 16 cartes de la pioche il ne peut donc pas avoir de roi
	init(){}


	//poserCarte: JoueurProtocol x Int x String ->
	//pose une carte correspondant à l'entier entré en paramètre (numero de carte choisi précédemment, utiliser getCarteparIdentifiant du type Mains) à la position choisie (chaine de caractère entrée en paramètre)
	//pré-conditions: numéro de carte: entier compris entre 1 et 6 (sinon echoue)
	//position choisie: chaîne de caractère, uniquement A1,A2, A3, F1, F2, F3, sinon échoue
	//Si le numéro de carte entré en paramètre ne correspond à une carte présente dans la main (utiliser getMain) alors échoue (exemple: 6 entré en paramètre alors qu'il n'y a que 4 cartes dans la main)
	// Si la position choisie ne correspond pas à une position disponible sur le champs de bataille (utiliser getChampDeBtaille) du joueur alors échoue
	//résultat: la carte indiquée est posée à la position choisie sur le champ de bataille
	//post-conditions: 1 carte en moins dans la main, 1 carte en plus sur le champ de bataille (à la bonne position)
	mutating func poserCarte( identifiantCarte: Int, positionCarte: String) throws{
		guard identifiantCarte>0 or identifiantCarte<7 else {
			throw joueurError.mainincorrecte		
		if self.champDeBataille.checkPositionDispo(PositionCarte){
			self.champDeBataille.AjouterCarte(positionCarte.getZone())
			self.main.enleverCarte(identifiantCarte)
			
		}
		
	}


	//mobiliser: CarteProtocol x String -> ChampDeBatailleProtocol
	//Prend la carte passée en paramètre dans le royaume (utiliser getRoyaume) et la place sur le champs de bataille (utiliser getChampDeBataille) à la position indiquée (utiliser getZone)
	//Résultat: ChampDeBataille avec n cartes en plus aux positions choisies
	//post-conditions: n cartes en moins dans le royaume, n cartes en plus sur le ChampDeBataille
	mutating func mobiliser(CarteMobilisee: Carte, nomZone: String) throws{
		self.royaume.retirerCarte(CarteMobilisee)
		self.champDeBataille.ajouterCarte(carteMobilisee, nomZone.getZone())//pb de fonction manquante ---------------------
	}




	//demobiliser: Joueur x Int -> MainsProtocol 
	//retire la carte qui a pour identifiant l'entier passé en paramètre (utiliser getCarteparIdentifiant) de la main et la place dans le royaume (utiliser getMain et getRoyaume)
	//pré-conditions: entier compris entre 1 et 6, sinon échoue
	//Résultat: Main avec une carte en moins
	//Post-conditions: Main avec une carte en moins, royaume avec une carte en plus 
	mutating func demobiliser( identifiantCarte: Int) throws -> Mains {
		guard identifiantCarte>0 or identifiantCarte<7 else {
			throw joueurError.mainincorrecte
		self.main.enleverCarte(identifiantCarte)
		self.royaume.AjouterCarte(identifiantCarte) //pb manque cette fonction dans royaume ------------------------
		return self.main
	}



	//piocherCarte:  Joueur-> CarteProtocol
	// pioche une carte au hasard dans la pioche (utiliser getPioche), la créer suivant la chaine de caractère renvoyé par la fonction piocher de PiocheProtocol
	// en utilisant les fonctions de création adéquate du type CarteProtocol puis la met dans la main du joueur
	//pré-conditions: pioche non vide
	//résultat: 1 carte 
	//post-conditions: nombrecarte de la pioche à baisssé de 1, 1 carte en plus dans la main
	mutating func piocherCarte() -> Carte{
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
	mutating func attaque(carteAttaquante : Carte, carteCiblé: Carte) throws -> Int{
		var test : int
		if carteAttaquante.getAttaque()==carteCiblé.getDefPDef(){
			test = 0
		}else{
			if carteAttaquante.getAttaque()>carteCiblé.getDefPDef(){
				test = 1
			}else {
				test = 2
			}
		}
		return test
	}
	
	
	
	//attaquantDispo: String ->Bool 
    //Appelle la fonction ListeAttaquant() du ChampDeBataille du joueur et Vérifie grâce au nom de la zone(chaine de caractère passée en paramètre)  si la carte qui se trouve dans cette zone (utiliser getZone de ChampDeBataille) peut attaquer
	//Résultat: return true si la carteAttaquante(nom de ma zone où se trouve la carte ) est dans listeAttaquant() sinon renvoie false
	func attaquantDispo(carteAttaquante: String) -> Bool{
		var test = false
		var liste=self.champDeBataille.listeAttaquant()
		for (carte) in liste{
			if carte == carteAttaquante{
				test = true
			}
		}
		return test
	}


	//checkCarteAttaque: String x [String] -> Bool
	//Résultat: renvoie vrai si la première chaine de caractères (correspondant à la zone de la carte que veut attaquer le joueur) est dans le tableau de chaîne de caractères passé en 2e paramètre
	// Sinon renvoie faux
    func checkCarteAttaque(nomZoneAttaquant: String, carteAttaquableparJ: [String]) -> Bool{
	    var test = false
	    for (carte) in carteAttaquableparJ{
		    if carte.getNom()==nomZoneAttaquant{
			    test = true
		    }
		    
	    }
	    return test
    }
	
	
	// estAPortee: String x String-> bool
	//Vérifie que la carte dans la première zone (nom passé en premier paramètre) peut attaquer celle dans la zone adverse (nom passé en 2e paramètre) (utiliser getCarteZone et getZone)
	// Pre-conditions : 1ère chaine de caractères passée en paramètre: nom de la zone dans laquelle il y a la carte attaquante, 2e chaine de caractères passée en paramètre: nom de la zone adverse ciblée
	// Resultat : True si la cible est à portée, false sinon
	func estAPortee(zoneAttaquant : String, zoneCible : String) -> Bool{
		var test = false
		var CarteZoneAttaquant : carte
		CarteZoneAttaquant = zoneAttaquant.getCarteZone()
		var CarteZoneCible : carte
		CarteZoneCible = zoneCible.getCarteZone()
		//PB zone attaquanr 
		if (CarteZoneAttaquant.attaquePossible(zoneCible)){
			test = true
		}
		return true
	}
	
	//checkCible: ChampDeBatailleProtocol x [String]->Bool
	//Appelle la fonction de ChampDeBatailleProtocol listeAttaquant et regarde pour chaque carte donné par liseAttaquant si au moins une d'entre elles peut cibler une carte du champs de bataille de l'ennemie
	//Résultat: renvoie vrai si au moins une carte de la listeAttaquant() à une cible à sa porté
	func checkCible(champAdversaire : ChampDeBataille) -> Bool{
		var tab =champAdversaire.listeAttaquant()
		var test =false
		if (tab !=nil){
			test = true
		}
		return test		
	}



	//Capturer: JoueurProtocol x CarteProtocol ->
	//Prend la carte passée en paramètre, la retire du champ de bataille adverse et la place dans le royaume du joueur courant
	//Résultat: Carte en moins dans le champ de bataille adverse et 1 en plus dans le royaume
	mutating func Capturer(carteCapturée : Carte){
		self.champDeBataille.CapturerCarte(carteCapturée)
	}
	
    //getPioche: JoueurProtocol -> PiocheProtocol
    //Renvoie la pioche du JoueurProtocol
    func getPioche() -> Pioche{
	    return self.pioche
    }
    	
	
    //getRoyaume: JoueurProtocol -> RoyaumeProtocol
    //Renvoie le Royaume du JoueurProtocol
    func getRoyaume() -> Royaume{
	    return self.royaume
    }
    
    
    
    //getMain: JoueurProtocol -> MainsProtocol
    //Renvoie la main du JoueurProtocol
    func getMain() -> Main{
	    return self.main
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
    
    

}
