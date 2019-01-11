import Foundation
import Art
//fonctions du main

func saisieEntier()-> Int{
  var isAInt = false
  var numCarte: Int
  while(!isAInt){
    if let saisie = readLine(){
      if let n = Int(saisie){
        numCarte = n
        isAInt = true
      }
      else{
        print("veuillez choisir un nombre")
      }
    }
  }
  return numCarte
}
func saisieChaine()-> String{
  var isAString = false
  var position: String
  while(!isAString){
    if let saisie = readLine(){
      position = saisie
      isAString = true	
    }
    else{
        print("Vous devez rentrer une chaine de caractères")
    }
  }
  return position
}

func choisirCarteMain(joueurCourant: Joueur)-> Int{
  var saisieVerifiee = false
  var numCarte : Int
  while(saisieVerifié == false){
    print("Choisissez une carte de votre main (Rentrer le numéro de la carte)")
    print(joueurCourant.main().affichage())
    numCarte = saisieEntier()
    saisieVerifiee = joueurCourant.main().estDansMain(identifiantCarte : numCarte)
  }
  return numCarte
}
func afficherTabString(positionDisponible : [String]){
     var i = 0
     var res : String
     while(i < positionDisponible.count){
       res = res + " " + positionDisponible[i]
       i += 1
     }
}

func choisirPosition(joueurCourant : Joueur) -> String{
  var saisieVerifiee = false
  var positionDisponible : [String]
  var position : String
  while(saisieVerifié == false){
    print("Choisissez où poser la carte")
    positionDisponible = joueurCourant.champDeBataille().getPositionDispo()
    print(positionDisponible)
    position = saisieChaine()
    saisieVerifiee = joueurCourant.champDeBataille().checkPositionDispo(nomZone : position)
  }
  return position
}

func verificationFinDeGuerre(joueurCourant: Joueur, adversaire : Joueur)-> Joueur{
    if(joueurCourant.royaume().nombreCitoyens() > adversaire.royaume().nombreCitoyens()){
      gagnant = joueurCourant

    }
    else{
      gagnant = adversaire
    }
    return gagnant
}

func choixAction() -> Int{
  var action = -1
  while(action != 1 || action != 2 || action != 3){
    print("Choisissez quelle action réaliser ce tour : Tapez 1 pour passer votre tour, Tapez 2 pour Déployer une unité, Tapez 3 pour Attaquer")
    action = saisieEntier()
  }	
}

func afficherChampsdeBataille(cdbAllie : ChampsDeBataille) -> String{
// faire un print du champs de bataille en mettant dans une str ce qu'on veut afficher
  //[F1  ][F2  ][F3  ]   = plateau vide
  //[A1  ][A2  ][A3  ]
  
  //[F1:S][F2:R][F3:G]  = plateau avec 
  //[A1:A][A2  ][A3  ]
  var afficher : String
  var ItZone  = cdbAllie.makeIterator()
  var i = 0
  var carte : Carte
  var nomZone : String
  var nomCarte : String
  while(i < 6){
    if( i%3 == 0){
      afficher = afficher + "\n"
    }
    if let v = ItZone.next(){
      nomZone = v.getNomZone()
      if let carte = v.getCarteZone(){
        nomCarte = carte.getNom()
        afficher = afficher + "[" + nomZone + ":" + nomCarte + "]"
      }
      else{
        afficher = afficher + "[" + nomZone + "      ]"
      }
    }
	}
	return afficher
}





func afficherCarte(carte : Carte) -> String{
  var nom = carte.getNom()
  var orientationBool = carte.estDefensif()
  var ptDefTour = carte.getPointdeDefduTour()
  var attaque = carte.getAttaque()
  var defPDef = carte.getDefPDef()
  var defPOff = carte.getDefPOff()
  var portee = carte.getPortee()
  var orientation : String
  var affichage : String
  if orientationBool == True {
  	orientation = "Défensive"
  }
  else{
  	orientation = "Offensive"
  }
  
  affichage = "Nom: " + nom + " \n Points d'attaque: \(attaque) \n Portée: \(portee) \n Points de défense en position défensive: \(defPDef) \n Points de défense en position offensive: \(defPOff)  \n Position: \(orientation) Points de défense actuels: \(ptDefTour)" )
	return affichage
}
// print("Royaume adverse : " + tavariable) STRING
  //print("Tour : \(i)") ENTIER
// faire un print d'une carte en mettant dans une str ce qu'on veut afficher



func afficherRoyaume(royaume : Royaume) -> String{
  var afficher = " Vous avez " + royaumenombreCitoyens() + " citoyens"
  return afficher
}

func afficherMain(main : Mains){
	var carte : Carte
  var ItMain = main.makeIterator()
  var id = ItMain.next()
  var affCarte
  var affichage
  while (id != nil) {
    carte = main.getCarteparIdentifiant(identifiantCarte : id)
    affichage = affichage + "Carte \(id) : \(carte.afficherCarte()) \n \n"
    id = ItMain.next()  
  }
  return affichage
  // faire un print d'une main en mettant dans une str ce qu'on veut afficher

}

//Initatialisation des variables

var saisieVerifiee : Bool  //permet de vérifier que les Saisies de l'utilisateur sont possibles
var joueurCourant : JoueurProtocol
var adversaire : JoueurProtocol
var mobilisation : Int // permet de vérifier que le joueur effectue 2 mobilisations pour éviter l'effondrement
var effondrement : Bool // permet de vérifier l'éffondrement du royaume d'une
var resultatAttaque : Int // Permet de déterminer les résultats de l'attaque
var positionDisponible : [String] // Stock les positions où le joueur peut poser une carte sur son champ de bataille
var finAttaque : Bool // Permet de terminer la phase d'attaque quand le joueur le veut ou quand il ne peut plus attaquer
var position : String // permet au joueur de saisir une position relative à des noms de Zones
var identifiantCarte : Int 
var numCarte : Int // Permet au joueur de saisir un numCarte relatif à l'identifiant de la Carte de sa main qu'il veut sélectionner
var action : Int // Permet au joueur de choisir une action à faire pendant son tour
var adversaire : JoueurProtocol // Permet d'avoir accès aux informations relative au joueur courant
var libVictoire : String // Permet d'afficher la condition de victoire
var carteAttaquableParJ : [String]? // Stock les carte attaquable par une zone, nil si aucune carte ne peut être ciblée
var strcarteAttaque : String // Permet au joueur de saisir le nom de la zone où il veut attaquer une carte
var strcarteAttaquante : String // Permet à l'utilisateur de saisir le nom de la zone où il veut selectionner une carte pour attaquer
var egalite = false   // permet de vérifier la condition d'égaliter
var carteAttaque : Carte
var cartePioche :  Carte
var carteAttaquante : Carte
var carteMobilise : Carte
var carteRemove : Carte
var continuer : Int // pour demander à l'utilisateur si il veux continuer d'attaquer
var fin = false // permet de terminer la boucle principale lorque la variable sera égale à true
var saisieVerifieDemobilisation = -1 // permet de vérifier le choix du joueur dans la phase de développement
var gagnant : Joueur //permet de déterminer le joueur gagnant

//Initialisation de la partie

print("Bienvenue dans l'Art de la Guerre")
var joueur1 = Joueur()
var joueur2 = Joueur()

//Initialisation  des joueurs

for y in 1...3 {
  if(y%2 == 1){
    joueurCourant = joueur1
    print("Joueur 1 :")
  }
  else{
    joueurCourant = joueur2
    print("Joueur 2 :")
  }
  numCarte = choisirCarteMain(joueurCourant : joueurCourant) // demande au joueur de choisir une carte parmis celle de sa main
  position = choisirPosition(joueurCourant : joueurCourant) // demande au joueur de choisir une position où placer sa carte parmis les postions disponible
  joueurCourant.poserCarte(identifiantCarte : numCarte, positionCarte: position) // pose la carte choisit à la postion choisit par l'utilisateur
  print(afficherChampsdeBataille(cdbAllie : joueurCourant.champDeBataille()))
}

// 								   DEBUT DE LA PARTIE

var i = 1 // numéro du tour
while(fin == false && egalite == false){

    print("Tour : \(i)") // affichage du numéro du tour
    print(afficherChampsdeBataille(cdbAllie : joueurCourant.champDeBataille())) 
    // les tours impairs
    if(i%2 == 1){
      print("Tour du Joueur1")
      joueurCourant = joueur1
      adversaire = joueur2
    }
    else{
      print("Tour du Joueur2")
      joueurCourant = joueur2
      adversaire = joueur1
    }
    print(afficherMain(main : joueurCourant.main()))
  	print(afficherRoyaume(royaume : joueurCourant.royaume()))
    print("Votre Royaume :  "  + afficherRoyaume(royaume : joueurCourant.royaume()))
    print("Royaume adverse : " +  afficherRoyaume(royaume : adversaire.royaume()))
    // 						PHASE DE PREPARATION
    joueurCourant.champDeBataille.replacerCarte() // remet les cartes en position défensive
    joueurCourant.champDeBataille.initialiserPointdeDefTour() // réinitialise les points de dégats subit au tour précédent
  //   					VERIFICATION FIN DE GUERRE
    if(joueurCourant.pioche().estVide()){ // Si la pioche est vide
      if(joueurCourant.royaume().nombreCitoyens() == adversaire.royaume().nombreCitoyens()){ //Si les deux joueurs ont autant de citoyens dans leur royaume
              egalite = true // permet de sortir de la boucle principale
      }
      else{
        gagnant = verificationFinDeGuerre(joueurCourant: joueurCourant, adversaire: adversaire) // vérifie quel joueur à le plus de citoyens dans son royaume ( on aurait pu faire un type partie pour éviter de mettre cette fonction dans le main)
        libVictoire = " C'est la fin de la guerre, vous avez plus de citoyens que votre adversaire"
        fin = true // permet de sortir de la boucle principale
      }
      action = 1 // pour passer le tour (ne pas rentrer dans les autres conditions)
    }
    //                      Début du Tour
    else{
      cartePioche = joueurCourant.piocherCarte() // Piocher une carte
      print("Vous avez pioché la carte")
      print(afficherCarte(carte :cartePioche))
    }
    //                                     PHASE D'ACTION
    if( action != 1){ // si on ne passe pas le tour 
        action = choixAction()
    }
    //                                     PHASE DE DEPLOIEMENT
    if(action == 2){
      print("Déploiement d'une unité")
      print(afficherMain(main : joueurCourant.main())) 
      numCarte = choisirCarteMain(joueurCourant : joueurCourant) // demande au joueur de choisir une carte parmis celle de sa main
      position = choisirPosition(joueurCourant : joueurCourant) // demande au joueur de choisir une position où placer sa carte parmis les postions disponible
      joueurCourant.poserCarte(identifiantCarte: numCarte,positionCarte: position) // pose la carte demandé à la position demander sur le champs de bataille du joueur
      print(afficherChampsdeBataille(cdbAllie : joueurCourant.champDeBataille())) 
    }
  //                                     PHASE D'ATTAQUE
  	else if(action == 3){
      joueurCourant.champDeBataille().initialiserAttaqueSoldat() 
      // réinitialise les points d'attaque du soldat en fonctions du nombre de carte dans la main du joueur
      print(afficherChampsdeBataille(cdbAllie : joueurCourant.champDeBataille())) 
      print("phase d'attaque")
      finAttaque = false
      while(joueurCourant.champDeBataille().listeAttaquant() != nil && finAttaque == false && joueurCourant.checkCible(champAdversaire : adversaire.champDeBataille() , listeAttaquant : joueurCourant.champDeBataille().listeAttaquant()) == true){
        print(joueurCourant.champDeBataille().listeAttaquant())
        saisieVerifiee = false
        while(saisieVerifiee == false){
          print("Choisissez une carte pour attaquer")
          if let saisie = readLine(){
          	strcarteAttaquante = saisie
       		}
        	if(joueurCourant.attaquantDispo(carteAttaquante : strcarteAttaquante)){ // return true si carteAttaquante est dans listeAttaquant()
            if let carteAttaquableParJ = joueurCourant.champDeBataille().carteAttaquable(cdb : adversaire.champDeBataille(), nomZone:strcarteAttaquante){ 
               saisieVerifiee = true
            }
            else{
              print("Cette carte n'a pas de cible pour le moment")
            }
        	}
      	}
      }
      afficherTabString(positionDisponible : adversaire.champDeBataille().affichageCible(carteAttaquable:carteAttaquableParJ)) // retourne un String à partir d'une liste de carte
      // retourner le champs de bataille de l'enemie avec les carte attaquable par la carte sélectionné
      saisieVerifiee = false
      while(saisieVerifiee == false){
        print("Choisissez une carte à attaquer")
        strcarteAttaque = saisieChaine()
        saisieVerifiee = joueurCourant.checkCarteAttaque(nomZoneAttaquant: strcarteAttaque,carteAttaquableparJ:carteAttaquableParJ)
      }
      carteAttaquante.mettreEnPositionOffensive()
      if(carteAttaquante.estSoldat()){
        carteAttaquante.setAttaque(valeur: joueurCourant.main().nombreCartes())
      }
      carteAttaque = getCarteZone(nomZone : strcarteAttaque)
      resultatAttaque = joueurCourant.attaque(carteAttaquante : carteAttaquante,carteCiblé : carteAttaque) // Si bléssé change les "pointDefduTour"
      if( resultatAttaque == 0 ){ // carte capturé       
        carteRemove = adversaire.champDeBataille().remove(nomZone: strcarteAttaque)
        adversaire.champDeBataille().checkAvancement() // vérifie si une carte doit avancé et appelle la fct avancerCarte() si c'est le cas
        joueurCourant.capturer(CarteCpturée : carteRemove) // met la carte capturé dans  le royaume
        if(carteAttaque.estRoi()){
          finAttaque = true
          gagnant = joueurCourant
          libVictoire = " Le roi de l'ennemie a été capturer "
          fin = true
        }
        if(adversaire.champDeBataille().estvide() && finAttaque == false){
        //								 vérifier effondrement 
          mobilisation = 0
          effondrement = true
          print("Le champ de bataille de votre adversaire est vide, il doit recruter de force pour éviter l'effondrement de son Royaume")
          while(mobilisation < 2 ){
            if(!adversaire.royaume().estVide()){  // Mobilise une carte du Royaume
              carteMobilise = adversaire.royaume().getfirstCarte() // vérifier si nil
              print(afficherCarte(carte : carteMobilise))
              print("Vous devez mobiliser cette carte de votre royaume")
              position = choisirPosition(joueurCourant : adversaire)
              mobilisation = mobilisation + 1
              effondrement = false
              adversaire.mobiliser(CarteMobilisee : carteMobilise , nomZone : position)
            }
            else if(!adversaire.main().estVide() && adversaire.royaume().estVide() && effondrement == false){
              // Demande au joueur de poser une carte de sa main
              print("Dépoiement d'une unité")
              print(afficherMain(main : adversaire.main()))
              numCarte = choisirCarteMain(joueurCourant : adversaire)
              position = choisirPosition(joueurCourant : adversaire)
              joueurCourant.poserCarte(identifiantCarte : numCarte , positionCarte : position)
              mobilisation = mobilisation + 1
              print(afficherChampsdeBataille(cdbAllie : adversaire.champDeBataille()) )
            }
            else{
              gagnant = joueurCourant
              fin = true // permet de sortir de la boucle principale
              finAttaque = true // pour sortir de la boucle d'attaque
              libVictoire = " Le Royaume de l'ennemie s'est effondré "
              mobilisation = 2
            }
          }
        }
      }
      if( resultatAttaque == 1 ){ //carte détruite
        adversaire.champDeBataille().remove(nomZone : strcarteAttaque)
        adversaire.champDeBataille().checkAvancement() // vérifie si une carte doit avancé et appelle la fct avancerCarte() si c'est le cas
        if(carteAttaque.estRoi()){
          finAttaque = true // pour sortir de la boucle d'attaque
          gagnant = joueurCourant
          libVictoire = " Le roi de l'ennemie a été capturer "
          fin = true // permet de sortir de la boucle principale
        }
        if(adversaire.champDeBataille().estvide() && finAttaque == false){
        //								 vérifier effondrement 
          mobilisation = 0
          effondrement = true
          print("Le champ de bataille de votre adversaire est vide, il doit recruter de force pour éviter l'effondrement de son Royaume")
          while(mobilisation < 2 ){
            if(!adversaire.royaume().estVide()){  // Mobilise une carte du Royaume
              carteMobilise = adversaire.royaume().getfirstCarte() 
              print(afficherCarte(carte :carteMobilise))
              print("Vous devez mobiliser cette carte de votre royaume sur le champs de bataille")
              position = choisirPosition(joueurCourant : adversaire)
              mobilisation = mobilisation + 1
              effondrement = false
              adversaire.mobiliser(CarteMobilisee : carteMobilise , positionCarte : position)
            }
            else if(!adversaire.main().estVide() && adversaire.royaume().estVide() && effondrement == false){
              // Demande au joueur de poser une carte de sa main
              print("Dépoiement d'une unité")
              print(afficherMain(main :adversaire.main()))
              numCarte = choisirCarteMain(joueurCourant : adversaire)
              position = choisirPosition(joueurCourant : adversaire)
              joueurCourant.poserCarte(identifiantCarte : numCarte , positionCarte : position)
              mobilisation = mobilisation + 1
              print(afficherChampsdeBataille(cdbAllie : adversaire.champDeBataille()))
            }
            else{
              gagnant = joueurCourant
              fin = true // permet de sortir de la boucle principale
              finAttaque = true // permet sortir de la boucle d'attaque
              libVictoire = " Le Royaume de l'ennemie s'est effondré "
              mobilisation = 2
            }
          }
        }
      }
      if( resultatAttaque == 2 ){ // carte bléssé
        print(carteAttaque.getPointdeDefduTour())
      }
      if(finAttaque == false){
        // Choix du joueur de continuer l'attaque ou de passer son tour
        while(continuer != 0 || continuer != 1){
          print("voulez vous attaquer avec une autre carte? Tapez 1 pour OUI et 0 pour NON") 
          var continuer = saisieEntier()
          if(continuer == 0){
            finAttaque = true // permet sortir de la boucle d'attaque
          }
          if(continuer == 1){
            if(joueurCourant.checkCible(champAdversaire : adversaire.champDeBataille() , listeAttaquant : joueurCourant.champDeBataille().listeAttaquant()) == false){ //return true si au moins une carte de la listeAttaquant à une cible à sa porté
              print("Il n'y a plus aucune carte ennemie à la porté de vos carte")
              finAttaque = true // permet de sortir de la boucle d'attaque
            }
          }
        }
      }
    }

  }
  //                                     PHASE DE DEVELOPPEMENT
  if(fin == false && egalite == false){
    print("phase de développement")
    print(afficherMain(main : joueur1.main()))
    while(saisieVerifieDemobilisation != 0 && saisieVerifieDemobilisation != 1 && joueurCourant.main().nombreCartes() < 6){
      print("Tapez 1 pour démobiliser une carte. Tapez 0 pour passer votre tour")
      var saisieVerifieDemobilisation = saisieEntier()
    }
    if(joueurCourant.main().nombreCartes() >= 6 || saisieVerifieDemobilisation == 1){
      if(joueurCourant.main().nombreCartes() >= 6){
        print("Vous avez "\(adversaire.main().nombreCartes())" en main, choisissez une carte à démobiliser")
      }
      numCarte = choisirCarteMain(joueurCourant : joueurCourant)
      joueurCourant.demobiliser(identifiantCarte : numCarte)
    }
    i=i+1 // Numéro du tour suivant
    action = 0 // réinitialise la variable action pour le prochain tour
  }
}

if(egalite == true){
  print("EGALITE : La guerre est finit et vos deux royaumes sont aussi prospère")
}
if(gagnant == joueur1){
  print("Bravo joueur1, vous avez gagné !")
  print(libVictoire)
}
if(gagnant == joueur2){
  print("Bravo joueur2, vous avez gagné !")
  print(libVictoire)
}
// ----------------------------------------------- RESTE A VERIFIER ---------------------------------------------


// générer les package
