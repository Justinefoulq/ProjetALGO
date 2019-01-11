//Champ de bataille

//Champs de Bataille est une collection contenant des ZoneProtocol
import Foundation
protocol ChampDeBatailleProtocol : Sequence {
    associatedtype TZone : ZoneProtocol
    associatedtype TCarte : CarteProtocol

    //associatedtype IteratorNomZone : IteratorProtocol


	//ligne de front, ligne arriere
	//init:  ->ChampDeBatailleProtocol
	//création d'un champ de bataille
	//post-conditions: 2 lignes avec chacune 3 Zones 
	//				   ligne de front: positions F1, F2, F3
	//				   ligne arriere: positions A1, A2, A3
	//Résultat: Champ de bataille avec 6 Zones vides
	init()


	//estVide: ChampDeBatailleProtocol -> Bool
	//indique si un champ de bataille est vide ou non
	//résultat: true si le champ de bataille est vide, false sinon
	func estVide()->Bool


	//getPositionDispo: ChampDeBatailleProtocol ->[String]
	//renvoie les positions où il est possible de poser une carte, destiné à l'utilisateur
	//résultat: tableau de chaines de caractères qui présente à l'utilisateur les positions où il peut poser une carte sur le champ de bataille
	//post-conditions: positions renvoyées: F1, F2, F3 ou A1, A2, A3
	//				   Si position sur ligne de front libre alors la position correspondante sur la ligne arrière ne l'est pas, exemple: si F1 disponible, alors même si A1 vide, elle n'est pas disponible
	//				   Même s'il y a une carte déjà présente sur une zone, cette dernière est considérer disponible
	func getPositionDispo()->[String]



	//checkPositionDispo: String -> Bool
	//renvoie vrai si la chaine de caractère en entrée correspond à une des positions disponible renvoyée par getPositionDispo
	func checkPositionDispo(nomZone : String)->Bool


	//listeAttaquant: ChampDeBatailleProtocol-> [String] | nil
	//Résultat : renvoie un tableau de chaines de caractères comportant chaque nom de zone et une description détaillée des cartes du joueur pouvant attaquer donc étant en position défensive
	//Renvoie nil si aucune carte ne peut attaquer
	func listeAttaquant()-> [String]?

	//initialiserPointdeDefTour: ChampDeBatailleProtocol -> ChampDeBatailleProtocol
	//parcourt toutes les zones du champ de bataille après la phase d'action du joueur adverse et ré-initialise les points de défense de toutes les cartes du champs de bataille en fonction de leur position( defense / attaque) et de leur type d'unité
	mutating func initialiserPointdeDefTour()

    //initialiserAttaqueSoldat: ChampDeBatailleProtocol -> ChampDeBatailleProtocol
    //parcourt toutes les zones du champ de bataille au début de la phase d'attaque du joueur adverse et ré-initialise les points d'attaque des soldats du champs de bataille en fonction du nombre de cartes qu'il ya dans la main du joueur
    mutating func initialiserAttaqueSoldat()



	//replacerCarte: ChampDeBatailleProtocol -> ChampDeBatailleProtocol
	//Parcourt le champ de bataille et appelle la fonction mettreEnPositionDefensive sur chaque carte
	//pre-conditions: champ de bataille non vide
	//résultat: champ de bataille avec ses cartes en position défensive
	mutating func replacerCarte() throws

	//checkAvancement: ChampDeBatailleProtocol->
	// Parcourt le champ de bataille et vérifie si une carte doit avancer(si une zone du front vide alors que celle derrière non), et appelle la fct avancerCarte() si c'est le cas
	func checkAvancement()

	//avancerCarte: ZoneProtocol ->
	//avance la carte qui se trouve dans la zone passée en paramètre en ligne de front, sur la zone juste devant
	//pré-conditions: Zone passée en paramètre est une zone arrière (A1,A2 ou A3)
	//Résultat: carte avancée dans la zone devant elle
	func avancerCarte(nomZone : TZone) throws

	//carteAttaquable: String X ChampDeBatailleProtocol -> [TZone]
	//Pré-conditions: Zone en entrée non vide
	//Résultat: renvoie les zones non vides attaquables dans le champs de bataille de l'ennemie par la carte dans la zone dont le nom est entré en paramètre(utiliser getZone et getCarteZone) en fonction de la portée de la carte présente dans la zone
    //func carteAttaquable(cdb: Self ,nomZone:String) throws -> [String]
    
    //getZone: String -> TZone
    //Renvoie la zone dont le nom est passé en paramètre
    //pré-conditions: Chaîne de caactères entrée en paramètre correspond à une zone initialisée 
    //Resultat: renvoie un zone, celle dont le nom est passé en paramètre
    func getZone(nomZone: String) throws -> TZone
	
    //affichageCible: [String] ->
    //Renvoie les cartes et toutes leurs propritétés détailées (point de défense restant...) des zones présentes dans la tableau de chaine de caractères passé en paramètre, qui est le résultat de carteAttaquable
    //Résultat: une chaîne de caractères
    func affichageCible(carteAttaquable: [String]) -> String

	// makeIterator : ChampDeBatailleProtocol -> IteratorNomZone
	// crée un itérateur sur la collection de ZoneProtocol 
	//Résultat: Renvoie un Iterateur
	func makeIterator() -> IteratorNomZone

	//ajouterCarte TCarte x String -> ChampDeBatailleProtocol
	mutating func ajouterCarte(carte : TCarte, zone : String) throws

	

}






