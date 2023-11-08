//
//  APIUserRequestModel.swift
//  FreeDiscover
//
//  Created by jerome julien on 01/11/2023.
//

import Foundation

//MARK: ON PRÉPARE A PART LA DONNÉE ACTIVITY EN LIEN AVEC L'API

//on fait une classe parce que elle seule peuvent être appliquée sur toute l'application!
//avec le ObservableObject on indique qu'on va lire la même info partout
//
class APIActivityRequestModel : ObservableObject {
    // MARK: Données stockées
    //On définie avec le @Published toutes les variables de cette classe qui doivent être observé par l'app pour déclencher des actions ou réaction
    /// Tableau stockant toutes les activités en BDD
    @Published var allActivities = [Activity]()
    /// Tableau stockant tous les `records` contenant les objets `activités`. Les records sont nécessaire pour les fonction `PATCH`
    @Published var allActivitiesRecord = [ActivityRecord]()
   
    @Published var needsRefresh: Bool = false

    // MARK: Fonctions de call API
    /// Fonction pour lancer une mise à jour des données
    func refreshData() async {
        print("enter into activity refreshdata")
        do {
            let (activities, activitiesRecords) = try await fetchedActivity()
            DispatchQueue.main.async {
                self.allActivities = activities
                self.allActivitiesRecord = activitiesRecords
                self.needsRefresh = false
            }
        } catch {
            print(error)
        }
        print("end of activity refreshdata")
    }
    
    /// Fonction pour récupérer toutes les activités
    //on prépare une fonction asynchrone pour ne pas surcharger le main thread
    //cette méthode va être utiliser sur un autre thread secondaire
    //et on veut pouvoir utiliser de la donnée de type User donc on attend un array de ça en retour
    func fetchedActivity() async -> ([Activity],[ActivityRecord]){
        var resultActivity = [Activity]()
        var resultActivityRecord = [ActivityRecord]()
        
        //1er préparation -> est-ce-que mon url est le bon
        //si oui on continue notre fonction
        //sinon on s'arrête et on récup un erreur
        //dans le string de l'URL il faut: le url de votre table et son nom -> trouvez ça dans votre documentation API
        guard let url = URL(string : "https://api.airtable.com/v0/appg0b2X0FfkTwFJg/Activities") else {
            print("URL unavailable")
            return (resultActivity,resultActivityRecord)
        }
        
        //si on arrive
        //on prépare la requête (ou notre demande auprès du serveur
        //"je suis telle personne et je veux récup ma donnée"
        var request = URLRequest(url: url) //-> on pause la question a cette URL
        request.httpMethod = "GET" // -> le type de la demande
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization") // -> info d'auth pour airtable
        
        //fait une suite d'actions, si elles ne sont pas possibles dans ce cas -> catch
        //le catch récup une erreur en fonction du résultat négatif de l'action
        do {
            //lorsqu'on se connecte sur un service, on créer une session
            //ici on lui demande d'ouvrir une session de connexion en fonction de ma requête
            //le TRY est pour voir si l'action ce fait sinon on renvoie une erreur détaillé
            //le AWAIT est là parce qu'on a une fonction en ASYNC, donc obligatoirement on a un await pour récup le résultat
            
            
            //si j'arrive à me connecter, je récup de la donnée et une réponse (sinon je pars dans le catch plus bas)
            let (data,response) = try await URLSession.shared.data(for: request)
            print(response) //<- si vous voulez voir à quoi ressemble une réponse serveur
            
            //ensuite on s'assure d'avoir une réponse positive sinon le reste du block s'arrête là
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Activity request wasn't successful")
                return (resultActivity,resultActivityRecord)
            }
            
            //si notre HTTPResponse est a 200 on récup et décode la data
            //le TRY me permet d'essayer de décoder sinon il renvoie une erreur
            //on veut décode de la donnée donc Type.self pour la partie decodable
            //et on veut appliquer ce décode sur la donnée en provenance du serveur, ici data
            let decodedRequest = try JSONDecoder().decode(ActivityRequest.self, from: data)
            print(decodedRequest) //<- résultat du décodage
            
            //comme on récup toute la requête on passe par une boucle forEach pour ajouter a notre array resultUser tous les utilisateurs trouvés lors du pull API
            decodedRequest.records.forEach { record in
                resultActivity.append(record.fields)
            }
            
            decodedRequest.records.forEach { record in
                resultActivityRecord.append(record)
            }
            
            //bonus pour trier par le nom des utilisateurs (pas obligatoire)
            //une closure -> fonction sans nom, qui s'applique sur des arrays ou d'autre types
            //on peut boucler avec et utiliser des let temporaire comme le .forEach a la 71
            //ou alors si on veut pas encore une fois déclarer un ou plusieurs let on peut utiliser le $0 ...
            //le $0 fonctionne comme le mot record a la ligne 71, il reprend chaque élément du tableau resultUser
            //le $1 permet de comparer
            //donc on compare 1 élément de tableau avec un autre et on voit lequel des deux vient se placer avant l'autre en fonction de l'ordre alphabétique (ici de A -> Z )
//            resultActivity.sort { $0.name < $1.name }
            
            return (resultActivity,resultActivityRecord)
        } catch let error {
            print("ERROR ACTIVITY API CALL : ",error)
        }
        
        return (resultActivity,resultActivityRecord)
    }
    
    /// fonction pour incrémenter le nbr de vote d'une activité
    func increaseVoteCount(activityId: String, currentVoteCOunt: Int) async {
        // Check de l'URL
        guard let url = URL(string: "https://api.airtable.com/v0/appg0b2X0FfkTwFJg/Activities") else {
            print("URL unavailable")
            return
        }
        
        // Définition de la requête
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
      
        
        
        // Préparation du corps de la requête avec l'ID de l'utilisateur et l'ID de l'activité à ajouter aux up votes
        let updateBody: [String: Any] = [
            "records": [
                [
                    "id": activityId.description,
                    "fields": [
                        "vote": currentVoteCOunt + 1
                    ]
                ]
            ]
        ]
        
        // Encodage du corps de la requête au format JSON
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: updateBody)
            request.httpBody = jsonData
            
            // Exécution de la requête
            let (_, response) = try await URLSession.shared.data(for: request)
            
            // Vérification de la réponse pour voir si la mise à jour a été réussie
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("API ACTIVITY add upvote request wasn't successful. Status code: \(httpResponse.statusCode)")
                    if let data = try? Data(contentsOf: request.url!), let str = String(data: data, encoding: .utf8) {
                        print("Response body: \(str)")
                    }
                } else {
                    print("Update was successful: activity with id \(activityId) has increased upvote")
                    // Si la mise à jour est OK, on lance une mise à jour des données utilisateur dans le stateObject pour mettre à jour l'affichage
                    DispatchQueue.main.async {
                        self.needsRefresh = true
                    }
                }
            }
        } catch let error {
            // Gestion des erreurs de mise à jour ici
            print("API ACTIVITY - ADD UP VOTE ERROR: ", error)
        }
    }
    
    /// fonction pour décrémenter le nbr de vote d'une activité
    func decreaseVoteCount(activityId: String, currentVoteCOunt: Int) async {
        // Check de l'URL
        guard let url = URL(string: "https://api.airtable.com/v0/appg0b2X0FfkTwFJg/Activities") else {
            print("URL unavailable")
            return
        }
        
        // Définition de la requête
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
      
        
        
        // Préparation du corps de la requête avec l'ID de l'utilisateur et l'ID de l'activité à ajouter aux up votes
        let updateBody: [String: Any] = [
            "records": [
                [
                    "id": activityId.description,
                    "fields": [
                        "vote": currentVoteCOunt - 1
                    ]
                ]
            ]
        ]
        
        // Encodage du corps de la requête au format JSON
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: updateBody)
            request.httpBody = jsonData
            
            // Exécution de la requête
            let (_, response) = try await URLSession.shared.data(for: request)
            
            // Vérification de la réponse pour voir si la mise à jour a été réussie
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("API ACTIVITY remove upvote request wasn't successful. Status code: \(httpResponse.statusCode)")
                    if let data = try? Data(contentsOf: request.url!), let str = String(data: data, encoding: .utf8) {
                        print("Response body: \(str)")
                    }
                } else {
                    print("Update was successful: activity with id \(activityId) has decreased upvote")
                    // Si la mise à jour est OK, on lance une mise à jour des données utilisateur dans le stateObject pour mettre à jour l'affichage
                    DispatchQueue.main.async {
                        self.needsRefresh = true
                    }
                }
            }
        } catch let error {
            // Gestion des erreurs de mise à jour ici
            print("API ACTIVITY - REMOVE UP VOTE ERROR: ", error)
        }
    }
    
    /// fonction pour créer une activité
    func createActivity(activity: Activity) async {
        print("ENTREE DANS CREATE ACTIVITY AVEC activité : \(activity)")
        // Check de l'URL
        guard let url = URL(string: "https://api.airtable.com/v0/appg0b2X0FfkTwFJg/Activities") else {
            print("URL unavailable")
            return
        }
        
        // Définition de la requête
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
      
        // Préparation du corps de la requête avec la nouvelle activité
        let activityToCreate: [String: Any] = [
            "records": [
                [
                    "fields":[
                        "id": activity.id,
                        "name": activity.name,
                        "photos" : [
                            /// photo en dur dans le code pour la démo. Intégration de photo choisi par l'utilisateur à faire
                            [
                            "url" : "https://images.unsplash.com/photo-1692118450510-3c1d8e7d1ae8?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                            ]
                        ] ,
                        "latitude" : activity.latitude,
                        "longitude" : activity.longitude,
                        "Description" : activity.description,
                        "Famille" : activity.famille,
                        "Accessibilite" : activity.accessibilite,
                        "Type activite" : activity.typeActivite,
                        "temporaire" : activity.temporaire,
                        "Date de debut" : activity.dateDeDebut,
                        "Date de fin" : activity.dateDeFin,
                        "vote" : activity.vote,
                        "creator" : activity.creator,
                        "favoriteByUserId" : activity.favoriteByUserID,
                        "upVote" : activity.upVote,
                        "downVote" : activity.downVote
                  ]
                ]
                
                
            ]
        ]
        print("activity to create from api call : \(activityToCreate)" )
        
        // Encodage du corps de la requête au format JSON
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: activityToCreate)
            request.httpBody = jsonData
            
            print("json data from create activite API : \(String(describing: request.httpBody))")
            // Exécution de la requête
            let (_, response) = try await URLSession.shared.data(for: request)
            
            // Vérification de la réponse pour voir si la mise à jour a été réussie
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("API ACTIVITY CREATE ACTIVITY ERROR. Status code: \(httpResponse.statusCode)")
                    if let data = try? Data(contentsOf: request.url!), let str = String(data: data, encoding: .utf8) {
                        print("Response body: \(str)")
                    }
                } else {
                    print("Update was successful: activity created")
                    // Si la mise à jour est OK, on lance une mise à jour des données utilisateur dans le stateObject pour mettre à jour l'affichage
                    DispatchQueue.main.async {
                        self.needsRefresh = true
                    }
                }
            }
        } catch let error {
            // Gestion des erreurs de mise à jour ici
            print("API ACTIVITY - CREATE ACTIVITY ERROR: ", error)
        }
         
         
    }
    
    
}
