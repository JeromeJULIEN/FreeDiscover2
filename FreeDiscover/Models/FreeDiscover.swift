//
//  FreeDiscover.swift
//  FreeDiscover
//
//  Created by apprenant 101 on 19/10/2023.
//

// MARK: - FreeDiscover

/*
 Abstract:
 `FreeDiscover` Type de objet reprèsentant les activités.
 */

import SwiftUI
import CoreLocation
import MapKit

/// Un modèle représentant une activité `FreeDiscover` et ses différentes caractéritiques.
///
/// Ce modèle incorpore l'énumération ``ActivityType``, permettant de catégoriser l'activité.
///
/// Cette structure ce conforme aux protocoles standards `Identifiable` et `Hashable`.
///
class FreeDiscover: Identifiable, ObservableObject {
    
    /// Identifiant unique.
    var id : Int
    
    /// Nom de l'activité.
    var name: String
    
    /// Photo de l'activité.
    var image: [String]
    
    /// Propriété  `location` qui stocke  les données géographique de l'endroit ou ce trouve l'activité.
    var location: CLLocationCoordinate2D
    
    /// Description de l'activité.
    var description: String
    
    /// Vote pour l'activité.
    @Published var voteCounter: Int
    
    /// Accès aux personnes à mobilité réduite.
    var accessibiliy: Bool
    
    /// Activité adaptée pour la famille.
    var family: Bool
        
    /// Type de l'activité.
    var type: ActivityTypes
    
    /// Activité ponctuelle.
    var temporary: Bool
    
    /// Date de début
    var startingDate: Date?
    
    /// Date de fin
    var endingDate: Date?
    
    /// Index de l'utilisateur ayant créé l'activité
    var contributor: Int
    
    
    /// Crée des activités pour la map.
    ///
    /// - Parameters:
    ///   - id: Identifiant unique du modèle FreeDiscover.
    ///   - name: Nom du bodyboard.
    ///   - image: Nom du bodyboard.
    ///   - location: Stocke les données géographique de l'endroit ou ce trouve l'acitivité.
    ///   - shortDescription: Courte description de l'activité.
    ///   - summary: Description détaillée de l'activité.
    ///   - voteCounter: Ajoute un vote sur l'activité.
    ///   - accessibiliy: Accès aux personnes à mobilité réduite.
    ///   - family: Adaptée pour la famille.
    ///   - favorite:  Ajoute au favori l'activité.
    ///   - type: Catégorise le type de l'activité.
    ///   - temporary: Activité ponctuelle.
    ///   - date: Ajoute une date de création de l'activité.

    init(id: Int = 0, name: String = "", image: [String] = [""], location: CLLocationCoordinate2D = .init(), description: String = "", voteCounter: Int = 0, accessibiliy: Bool = false, family: Bool = false, favorite: Bool = false, type: ActivityTypes = .nature, temporary: Bool = false, date: Date = Date(), startingDate: Date? = nil, endingDate: Date? = nil, contributor: Int = 0) {
        self.id = id
        self.name = name
        self.image = image
        self.location = location
        self.description = description
        self.voteCounter = voteCounter
        self.accessibiliy = accessibiliy
        self.family = family
        self.type = type
        self.temporary = temporary
        self.startingDate = startingDate
        self.endingDate = endingDate
        self.contributor = contributor
    }
    
}

/// Une extension facilitant la crèation, la gestion, et l'affichage détaillée d'une activité dans l'interface utilisateur.
///
extension FreeDiscover {
    static var musee1 = FreeDiscover(
        id:1,
        name: "Musée d'histoires naturelles",
        image: ["musee-archeo"],
        location: CLLocationCoordinate2D(latitude: 43.303727, longitude: 5.394671),
        description: "Ce musée est célèbre pour le semi-marathon. Ce n'est pas pour l'entraînement, mais pour la course. Les défis incluent le boulevard Michelet, une étendue de béton, et la montée du col de la Gineste. Après, on découvre le port de Cassis, un lieu emblématique couru par de nombreux sportifs marseillais. Il est recommandé de s'entraîner sur d'autres parcours avant de s'y lancer.",
        voteCounter: 1,
        accessibiliy: true,
        family: true,
        type: .culture,
        temporary: false,
        contributor: 1
    )
    
    static var sport1 = FreeDiscover(
        id:2,
        name: "Canoe-Calanques",
        image: ["canoe-calanques"],
        location: CLLocationCoordinate2D(latitude: 43.21265, longitude: 5.354158),
        description: "Au départ du petit port de Callelongue, surnommé le « bout du monde » par les Marseillais, naviguez jusqu'à Marseilleveyre en traversant la calanque de la Mounine aux eaux turquoise. Cette balade en canoë offre une vue imprenable sur les îles de l'Archipel du Riou et la beauté marine du littoral marseillais. N'oubliez pas votre masque et tuba pour explorer la faune et la flore des Calanques en nageant.",
        voteCounter: 4,
        accessibiliy: false,
        family: true,
        type: .sport,
        temporary: false,
        contributor: 1

    )
    
    static var nature1 = FreeDiscover(
        id:3,
        name: "Calanque d'en vau",
        image: ["calanque-en-vau"],
        location: CLLocationCoordinate2D(latitude: 43.20233894144298, longitude: 5.498078687708157),
        description: "Située entre Marseille et Cassis, c’est la calanque la plus grandiose du parc national avec ses eaux turquoise.",
        voteCounter: 10,
        accessibiliy: false,
        family: false,
        type: .nature,
        temporary: false,
        contributor: 2

    )
    
    static var bonPlan1 = FreeDiscover(
        id:4,
        name: "Concert-vieux-port",
        image: ["concert-vieux-port"],
        location: CLLocationCoordinate2D(latitude: 43.29534870002289, longitude: 5.374253259297408),
        description: "Ambiance folf et blues pour ce concert en plein air",
        voteCounter: 20,
        accessibiliy: false,
        family: false,
        favorite: true,
        type: .culture,
        temporary: true,
        startingDate: .distantFuture,
        endingDate: .distantFuture,
        contributor: 3
    
    )
    
    static var social1 = FreeDiscover(
        id:5,
        name: "Brocante du bois sacré",
        image: ["vide-grenier"],
        location: CLLocationCoordinate2D(latitude: 43.282387, longitude: 5.37092),
        description: "Au pied de la Bonne Mère, trouvez des trésors d'antan dans notre marché de charme. Chinez des habits vintage et jouets rétro, et plongez dans une atmosphère accueillante imprégnée d'histoire marseillaise.",
        voteCounter: 15,
        accessibiliy: true,
        family: true,
        type: ActivityTypes.social,
        temporary: true,
        startingDate: .distantFuture,
        endingDate: .distantFuture,
        contributor: 4
    )
    
    /// Tableau de statistique ` allFreeDiscover` regroupant tous les modèles de `FreeDiscover` disponible.
    /// 
    static var allFreeDiscover = [musee1, sport1, nature1, bonPlan1,social1]

}

extension FreeDiscover {
    
    /// Incrémente le compteur de votes de l'activité si elle est de type nature.
    func upVote() {
        self.voteCounter += 1
    }
    
    func downVote(){
        self.voteCounter -= 1
    }
}

