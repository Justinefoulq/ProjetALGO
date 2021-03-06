
//Carte
import Foundation

public class carte : CarteProtocol{

	typealias TZone = zone
	fileprivate var Nom: String
	fileprivate var DefPDef: Int 
	fileprivate var Attaque: Int 
	fileprivate var PointdeDefduTour: Int 
	fileprivate var DefPOff: Int 
	fileprivate var Portee: Int //OU String pb----------------------
	fileprivate var Position: Bool // true carte en offensive ; false defensive
	fileprivate var Zone : zone
	
    //init: -> CarteProtocol
    //Crée une carte vide (en attendant d'appeler les fonctions creer, creerRoi1 par exemple)
   public required init(){
	self.Nom = ""
	self.DefPDef = 0
	self.Attaque = 0  
	self.PointdeDefduTour = 0
	self.DefPOff = 0   
	self.Portee = 0    
	self.Position = true
	self.Zone = try! zone(nomZone : "") 
	    }
    
    //getNom: CarteProtocol -> String
    //Renvoie le nom de la carte
    //-> String
    public func getNom() -> String{
	    return self.Nom
    }     

	//mettreEnPositionOffensive: CarteProtocol -> CarteProtocol
	//met la carte en position offensive ( horizontale )
	public func mettreEnPositionOffensive(){
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
	public func getPointdeDefduTour() -> Int{
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
		self.Attaque=0//PB on sait pas quel main appartient la carte --------------------------------------------------
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
	public func getAttaque() -> Int{
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
	public func getDefPDef() -> Int{
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
	public func getDefPOff() -> Int{
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
	public func getPortee() -> Int  { //PB portee----------------------
		return self.Portee
	}

	//setAttaque: Int -> CarteProtocol
	//Attribue la valeur de la force d'attaque à une carte
	//Pré-conditions: Valeur de la force d'attaque = entier rentré en paramètre = 1 si l'carte est un roi1, roi2, garde ou archer ou égal au nombre d'cartes qu'il y a dans la main (donnée par la fonction NbreCartes du type Mains)
	//Résultat: La carte à une valeur de force d'attaque affectée
	public func setAttaque(valeur: Int){
		self.Attaque=valeur
	}
	 
	//setDefPDef: Int -> CarteProtocol
	//Attribue la valeur de la force de défense en position défensive à une carte
	//Pré-conditions: Valeur de la force de défense en position défensive = entier rentré en paramètre = 2 si l'carte est un soldat ou archer, 3 si c'est un garde, 4 si c'est un Roi1, 5 si c'est un Roi2
	//Résultat: La carte à une valeur de force de défense en position défensive affectée
	public func setDefPDef(valeur: Int) {
		self.DefPDef=valeur
	}

	//setDefPOff: Int -> CarteProtocol
	//Attribue la valeur de la force de défense en position offensive à une carte
	//Pré-conditions: Valeur de la force de défense en position offensive = entier rentré en paramètre = 1 si l'carte est un soldat ou archer, 2 si c'est un garde, 4 si c'est un Roi1 ou Roi2
	//Résultat: La carte à une valeur de force de défense en position offensive affectée
	public func setDefPOff(valeur: Int) {
		self.DefPOff=valeur
	}

	//setPortee: 
	//setPointsDefTour: Int -> CarteProtocol
	// Attibue la valeur de defense de ce tour à une carte
	//Pré-conditions: valeur >= 0 et valeur <= Points de def en fonction de la position de la carte
	//Résultat: La carte à une nouvelle valeur de défense pour ce tour qui lui est affectée
	public func setPointsDefTour(valeur: Int) {
		self.PointdeDefduTour=valeur
	}


	//estRoi:CarteProtocol -> Bool
	//Indique si une carte est un roi ou pas, appelle getNom
	//Résultat: Booléen: vrai si la fonction getNom renvoie  Roi1 ou Roi2, faux sinon
	public func estRoi() -> Bool{
		if self.Nom=="Roi1" || self.Nom=="Roi2"{
			return true
		}else {
			return false
		}
	}

	//estSoldat:CarteProtocol -> Bool
	//Indique si une carte est un soldat ou pas, apelle getNom
	//Résultat: Booléen: vrai si la fonction getNom renvoie Soldat, faux sinon
	public func estSoldat() -> Bool{
		if self.Nom=="Soldat"{
			return true
		
		}else {
			return false
		}
	}

	//EstDefensif: CarteProtocol -> Bool
	//Indique si la carte est en position défensive (vertical)
	//Résultat: retourne true si carte en position défensive, false sinon
	public func estDefensif() -> Bool{
		if self.Position==false{
			return true
		}else {
			return false
		}
	}

	public func getZone() -> zone{
		return self.Zone		
	}

	func setZone(Zone : zone){
		self.Zone=Zone	
	}

	//estGarde:CarteProtocol -> Bool
	//Indique si une carte est un Garde ou pas, appelle getNom
	//Résultat: Booléen: vrai si la fonction getNom renvoie  Garde1 ou Garde2, faux sinon
	public func estGarde() -> Bool{
		if self.Nom=="Garde1" || self.Nom == "Garde2"{
			return true
		}else{
			return false
		}
	}
	public func estArcher() -> Bool{
		if self.Nom=="Archer1" || self.Nom == "Archer2"{
			return true
		}else{
			return false
		}
	}
}
