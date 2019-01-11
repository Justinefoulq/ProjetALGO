
import Foundation

public class IteratorIdentifiantCarte : IteratorProtocol {
	typealias TCarte = carte
	let ItMain: mains
    var i : Int = 0
    

    public required init(Main: mains) {
        self.ItMain = Main
    }

    public func next() -> carte? {
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
   
public class mains : MainsProtocol{
	typealias TCarte = carte
	typealias TPioche = pioche 
    
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
	public required init( Pioche : pioche){

		//---------------problème initialiser créerRoi1() ou créer roi 2 mais comment on sais c'est la main de quel joueur ?
		self.carte0 = carte()
		self.carte1 = carte()
		self.carte2 = carte()
		self.carte3 = carte()

		self.carte0 = carte0.creerRoi2()
		self.carte1 = Pioche.piocher()
		self.carte2 = Pioche.piocher()
		self.carte3 = Pioche.piocher()

		let mains = ["0": carte0, "1": carte1, "2": carte2, "3": carte3 ]
	}


	

	func getMain() -> [Int : carte]{
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
	 func ajouterCarte(carte : carte){
		self.mains[nombreCartes()] = carte
	}

	//estDansMain: Int -> Bool
	//Résultat: renvoie vrai si l'entier est compris entre 1 et le nb deCartes //-----erreur 0 pas 1
	
	func estDansMains(identifiantCarte : Int ) -> Bool {
		return (identifiantCarte>=0) && (identifiantCarte<nombreCartes())
	}
	
	func estDansMainsCarte(carte : carte) ->Bool{
		var res : Bool = false 
		for i in 0..<self.nombreCartes() {
			if carte === self.mains[i] {
				res = true
			}
		}
		return res
	}

	//enleverCarte: Int ->MainsProtocol
	//Pré-conditions: l'entier entré en paramètre est compris entre 0 et le nombre de cartes dans la main
	//Résultat: Enleve la carte qui à pour identifiant celui passé en paramètre (utiliser getCarteparIdentifiant)
	//post-conditions nombreCartes diminue de 1
	//--------j'ai rajouter les propriete de la fonction setID ici : mettre a jour les identifiant quand on supprime une carte ( car set ID pas utilisé dans le main)
	
	func enleverCarte( identifiantCarte : Int) throws  {
		guard estDansMains(identifiantCarte: identifiantCarte) else {
			throw MainsError.pasDansMains
		}
		var trans : carte
		mains.removeValue(forKey: identifiantCarte)
		for i in (identifiantCarte+1)..<self.mains.count {
			trans = self.mains[i]!
			mains.removeValue(forKey: i)
			self.mains[i-1] = trans
		}
		
	}
	


	//getCarteparIdentifiant: Int -> CarteProtocol
	//renvoie une carte à partir d'un identifiant passé en paramètre
	//précondition: identifiantCarte.estDansMain() renvoie True
	//post-conditions: renvoie une Carte qui est dans la main et qui a pour identifiantCarte celui passé en paramètre
	func getCarteparIdentifiant( identifiantCarte : Int) throws -> carte  {
		guard estDansMains(identifiantCarte: identifiantCarte) else {
			throw MainsError.pasDansMains
		}
		return self.mains[identifiantCarte]!
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
	
	func getID(carte : carte) throws -> Int  {
		guard estDansMainsCarte(carte : carte) else {
			throw MainsError.pasDansMains
		}
		for i in 0 ..< self.nombreCartes() {
			if carte === self.mains[i] {
				return i 
			}
		}
	}


	

	
	// makeIterator : Mains -> IteratorIdentifiantCarte
	// crée un itérateur sur la collection de couple (identifiantCarte, Carte)
	//Résultat: Renvoie un Iterateur
	//A une fonction next qui renvoie l'identifiant de la carte parcourue  // C'ets quoi l'interet d'avoir un iterateur qui renvois que l'id de la carte ? sachant que ils veulent incrémenter a chaque fois que ce soit 1,2,3,4... bizarre

	
	public func makeIterator() -> IteratorIdentifiantCarte { //--------------j'ai fait un iterateur sur les cartes et pas sur les id car id ca sert pas a grand chose
		return IteratorIdentifiantCarte(Main:self)
	}

}

enum MainsError: Error {
    case pasDansMains
    
	}


