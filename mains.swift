
import Foundation
   
class mains : MainsProtocol{
	associatedtype Carte : CarteProtocol
	associatedtype IteratorIdentifiantCarte : IteratorProtocol
	associatedtype Pioche :  PiocheProtocol // Rajout car on ne peut pas initilaliser en piochant une carte si on a pas acces a la pioche----------------------------
	
	
	private var mains : [Int: carte]()
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


	
	//nombreCartes:  MainsProtocol-> Int
	//Renvoie le nombre de cartes qu'il y a dans la main du joueur
	//Résultat: renvoie un entier, 0 si vide
	//Post-conditions: entier renvoyé supérieur ou égal à 0
	
	func nombreCartes() -> Int {
			return mains.count
	}

	//ajouterCarte: CarteProtocol ->MainsProtocol
	//Ajoute la carte passée en paramètre dans la main
	//Résultat: Une carte est ajoutée dans la main du joueur
	//post-conditions nombreCartes augmente de 1
	mutating func ajouterCarte(carte : Carte){
		mains[nombreCartes()] = carte
	}

	//estDansMain: Int -> Bool
	//Résultat: renvoie vrai si l'entier est compris entre 1 et le nb deCartes //-----erreur 0 pas 1
	
	func estDansMain(identifiantCarte : Int ) -> Bool {
		return (identifiantCarte>=0) && (identifiantCarte<nombreCartes()
	}
	

	//enleverCarte: Int ->MainsProtocol
	//Pré-conditions: l'entier entré en paramètre est compris entre 0 et le nombre de cartes dans la main
	//Résultat: Enleve la carte qui à pour identifiant celui passé en paramètre (utiliser getCarteparIdentifiant)
	//post-conditions nombreCartes diminue de 1
	
	mutating func enleverCarte(identifiantCarte : Int) throws {
		if estDansMain(){
			mains.removeValue(forKey: identifiantCarte) 
		}else{
			Error
		}


	}
	


	//getCarteparIdentifiant: Int -> CarteProtocol
	//renvoie une carte à partir d'un identifiant passé en paramètre
	//précondition: identifiantCarte.estDansMain() renvoie True
	//post-conditions: renvoie une Carte qui est dans la main et qui a pour identifiantCarte celui passé en paramètre
	func getCarteparIdentifiant(identifiantCarte : Int) -> Carte throws {
		if estDansMain(){
			mains[identifiantCarte]
		}else{
			Error
		}

	}
	



	//estVide: -> Bool
	//Résultat: renvoie vrai si la main est vide
	
	func estVide() -> Bool {
		return mains.count == 0 
	}
	
	
	//setID: CarteProtocol -> MainsProtocol  
	//Attribue un id aux cartes de la main
	//Post-conditions: numérote les cartes de 1 à n (n=nombre de cartes de la main, entier) dans l'ordre dans lequel elles ont été piochées (le roi a pour id 1 après init)
	//				   attribue un identifiant à chaque fois qu'on pioche une carte et met à jour quand on en pose une (si on a 5 cartes, lorsque l'on pose la 3, la 4 et 5 deviennent respectivement 3 et 4)
	//Résultat: main avec ses cartes numérotées
	//-----------------------------------------------------vois pas comment faire 
	func setID(carte:Carte) { // nom mal apparoprié c'est plus ne mise a jour de la mains , comment on differencie de cas ou on enlevela carte ou le cas 
								//soit fait plsr fonction soit on specifie mieux les fonction ajout et surpimmer elem de la mains pour que ca incremente ou decremente les id

	}

	

	//getId: CarteProtocol -> Int
	//Renvoie l'identifiant de la carte passée en paramètre
	//Pré-conditions:carte passée en paramètre est dans la main
	//Résultat: entiern identifiant de la carte (attribué par setID)
	
	func getID(carte:Carte) -> Int throws {
		if estDansMain(){
			mains[carte]
		}else{
			Error
		}
	}
	
	
	// makeIterator : Mains -> IteratorIdentifiantCarte
	// crée un itérateur sur la collection de couple (identifiantCarte, Carte)
	//Résultat: Renvoie un Iterateur
	//A une fonction next qui renvoie l'identifiant de la carte parcourue 
	
	func makeIterator() -> IteratorIdentifiantCarte
		
	
}


