//Carte
import Foundation
protocol CarteProtocol {

	associatedtype TZone : ZoneProtocol


    //init: -> CarteProtocol
    //Crée une carte vide (en attendant d'appeler les fonctions creer, creerRoi1 par exemple)
    init()
    
    //getNom: CarteProtocol -> String
    //Renvoie le nom de la carte
    func getNom() -> String
    
  

	//mettreEnPositionOffensive: CarteProtocol -> CarteProtocol
	//met la carte en position offensive ( horizontale )
	
	mutating func mettreEnPositionOffensive()
    
    //mettreEnPositionDefensive: CarteProtocol -> CarteProtocol
    //met la carte en position Defensive ( verticale )
    mutating func mettreEnPositionDefensive()

	//getPointdeDefduTour:  CarteProtocol-> Int
	//Résultat : renvoie les points de def de la carte (au cas où elle a déjà eu des dégâts) après une attaque (points de dégâts cumulésjusqu'à la fin du tour)
	//post conditions: les points de def du tour son > 0 et <= au point de Def en vigueur de la carte
	func getPointdeDefduTour() -> Int


	//initialiserPointdeDefTour: CarteProtocol -> CarteProtocol 
	//Initialise en début de tour les pointsDeDefTour de la carte en fonction de sa position( offensive ou defensive).  
    //Si elle est en position offensive, alors ptDefDeTour sera égal au résultat de getDefPOff(), sinon il sera égal au résultat de getDefPDef())
	mutating func initialiserPointdeDefTour()


	//creerRoi1:  ->CarteProtocol
	//Crée un roi1, vous pouvez utiliser les fonctions set
	//Résultat: 1 carte de type roi1
	//Post-conditions: caractéristiques: attaque=1 ; défense/position défensive= 4 ; défense/position oﬀensive = 4 ; portée = toute la ligne devant lui, et la position à une distance 2 devant lui (c’est à dire la case juste derrière celle devant lui); nom=Roi1 ; positionDéfensive=true
	mutating func creerRoi1()


	//CreerRoi2:  ->CarteProtocol
	//Crée un roi2, vous pouvez utiliser les fonctions set
	//Résultat: 1 carte de type Roi2
	//Post-conditions: caractéristiques: attaque=1 ; défense/position défensive = 5 ; défense/position oﬀensive = 4 ; portée= toute la ligne devant lui ; nom=Roi2 ; positionDéfensive=true
	mutating func creerRoi2()

	//CreerSoldat:  ->CarteProtocol
	//Crée un soldat, vous pouvez utiliser les fonctions set
	//Résultat: 1 carte de type Soldat
	//Post-conditions: caractéristiques: attaque = autant que d’cartes dans la Main ; défense/position défensive=2 ; défense/position oﬀensive= 1 ; portée =la position devant lui ; nom=Soldat ; positionDéfensive=true
	mutating func creerSoldat()

	//creerGarde:  ->CarteProtocol
	//Crée un garde, vous pouvez utiliser les fonctions set
	//Résultat: 1 carte de type Garde
	//Post-conditions: caractéristiques: attaque = 1 ; défense/position défensive=3 ; défense/position oﬀensive = 2 ; portée=la position devant lui ; nom=Garde ; positionDéfensive=true
	mutating func creerGarde()

	//creerArcher:  ->CarteProtocol
	//Crée un archer, vous pouvez utiliser les fonctions set
	//Résultat: 1 carte de type Archer
	//Post-conditions: caractéristiques: attaque=1 ; défense/position défensive = 2 ; défense/position oﬀensive= 1 ; portée= les 4 positions devant lui qui serait les cases d’arrivée par un mouvement de cavalier aux échecs, c'est-à-dire la position d'arrivée d'un L majuscule (tourné vers la gauche ou la droite) formé par les positions, soit en parcourant 2 positions horizontales + 1 verticale ou 2 positions verticales et 1 horizontale ; nom=Archer ; positionDéfensive=true
	mutating func creerArcher()

	//getAttaque: CarteProtocol -> Int
	//Renvoie la force d'attaque d'une carte
	//Résultat: entier correspondant à la force d'attaque de l'carte
	//Post-conditions: Valeur de la force d'attaque pour chaque carte: Roi1: 1; 
	//																   Roi2: 1; 
	//																   Soldat: égale au nombre d'cartes qu'il y a dans la main (donnée par la fonction NbreCartes du type Mains); 
	//																   Garde: 1;
	//																   Archer: 1
	func getAttaque() -> Int


	//getDefPDef: CarteProtocol -> Int
	//Renvoie la valeur de la force de défense en position défensive (La carte en position verticale) d'une carte
	//Résultat: entier correspondant à la force de défense en position défensive 
	//Post-conditions:  Valeur de la force de défense en position défensive: Roi1: 4; 
	//																   		 Roi2: 5; 
	//																   		 Soldat: 2; 
	//																   		 Garde: 3;
	//																   		 Archer: 2
	func getDefPDef() -> Int

	//getDefPOff: CarteProtocol -> Int
	//Renvoie la valeur de la force de défense en position offensive (La carte en position horizontale) d'une carte
	//Résultat: entier correspondant à la force de défense en position offensive 
	//Post-conditions:  Valeur de la force de défense en position offensive: Roi1: 4; 
	//																   		 Roi2: 4; 
	//																   		 Soldat: 1; 
	//																   		 Garde: 2;
	//																   		 Archer: 1
	func getDefPOff() -> Int

	//getPortee: CarteProtocol -> String
	//Renvoie la portée d'une carte
	//Résultat: 
	//Post-conditions:  Valeur de la force de défense en position défensive: Roi1: toute la ligne devant lui, et la position à une distance 2 devant lui (c’est à dire la case juste derrière celle devant lui); 
	//																   		 Roi2: toute la ligne devant lui; 
	//																   		 Soldat: la position devant lui; 
	//																   		 Garde: la position devant lui;
	//																   		 Archer: les 4 positions devant lui qui serait les cases d’arrivée par un mouvement de cavalier aux échecs, c'est-à-dire la position d'arrivée d'un L majuscule (tourné vers la gauche ou la droite) formé par les positions, soit en parcourant 2 positions horizontales + 1 verticale ou 2 positions verticales et 1 horizontale
	func getPortee() -> Int

	//setAttaque: Int -> CarteProtocol
	//Attribue la valeur de la force d'attaque à une carte
	//Pré-conditions: Valeur de la force d'attaque = entier rentré en paramètre = 1 si l'carte est un roi1, roi2, garde ou archer ou égal au nombre d'cartes qu'il y a dans la main (donnée par la fonction NbreCartes du type Mains)
	//Résultat: La carte à une valeur de force d'attaque affectée
	mutating func setAttaque(valeur: Int)
	 
	//setDefPDef: Int -> CarteProtocol
	//Attribue la valeur de la force de défense en position défensive à une carte
	//Pré-conditions: Valeur de la force de défense en position défensive = entier rentré en paramètre = 2 si l'carte est un soldat ou archer, 3 si c'est un garde, 4 si c'est un Roi1, 5 si c'est un Roi2
	//Résultat: La carte à une valeur de force de défense en position défensive affectée
	mutating func setDefPDef(valeur: Int)

	//setDefPOff: Int -> CarteProtocol
	//Attribue la valeur de la force de défense en position offensive à une carte
	//Pré-conditions: Valeur de la force de défense en position offensive = entier rentré en paramètre = 1 si l'carte est un soldat ou archer, 2 si c'est un garde, 4 si c'est un Roi1 ou Roi2
	//Résultat: La carte à une valeur de force de défense en position offensive affectée
	mutating func setDefPOff(valeur: Int)

	//setPortee: 

	//setPointsDefTour: Int -> CarteProtocol
	// Attibue la valeur de defense de ce tour à une carte
	//Pré-conditions: valeur >= 0 et valeur <= Points de def en fonction de la position de la carte
	//Résultat: La carte à une nouvelle valeur de défense pour ce tour qui lui est affectée
	mutating func setPointsDefTour(valeur: Int)


	//estRoi:CarteProtocol -> Bool
	//Indique si une carte est un roi ou pas, appelle getNom
	//Résultat: Booléen: vrai si la fonction getNom renvoie  Roi1 ou Roi2, faux sinon
	func estRoi() -> Bool

	//estSoldat:CarteProtocol -> Bool
	//Indique si une carte est un soldat ou pas, apelle getNom
	//Résultat: Booléen: vrai si la fonction getNom renvoie Soldat, faux sinon
	func estSoldat() -> Bool

	//EstDefensif: CarteProtocol -> Bool
	//Indique si la carte est en position défensive (vertical)
	//Résultat: retourne true si carte en position défensive, false sinon
	func estDefensif() -> Bool
	
	func getZone() -> TZone
	
	mutating func setZone(Zone : TZone)
	
	func estGarde() -> Bool
	func estArcher() -> Bool
	

}











