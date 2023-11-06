//
//  APIUserRequestModel.swift
//  FreeDiscover
//
//  Created by jerome julien on 01/11/2023.
//

import Foundation

//MARK: ON PRÉPARE A PART LA DONNÉE USER EN LIEN AVEC L'API

//on fait une classe parce que elle seule peuvent être appliquée sur toute l'application!
//avec le ObservableObject on indique qu'on va lire la même info partout
//
class APIUserRequestModel : ObservableObject {
    //on veut savoir les faits et gestes des @Published tel un stalker
    @Published var allUsers = [User]()
    @Published var allUsersRecord = [UserRecord]()
    @Published var needsRefresh: Bool = false // Cette propriété sera modifiée pour déclencher une actualisation

    
    /// User par défaut pour lancer l'app
    @Published var connectedUser : User = User.marion
    
    /// Fonction pour lancer une mise à jour des données
    func refreshData() async {
        print("enter into refreshdata")
        do {
            let (users, userRecords) = try await fetchedUser()
            DispatchQueue.main.async {
                self.allUsers = users
                self.allUsersRecord = userRecords
                self.connectedUser = self.allUsers[0]
                self.needsRefresh = false
            }
        } catch {
            print(error)
        }
        print("end of refreshdata")
    }
    
    //on prépare une fonction asynchrone pour ne pas surcharger le main thread
    //cette méthode va être utiliser sur un autre thread secondaire
    //et on veut pouvoir utiliser de la donnée de type User donc on attend un array de ça en retour
    /// fonction pour récupérer les données de tous les users
    func fetchedUser() async -> ([User],[UserRecord]){
        print(":::::: entrée dans fetchedUser")
        var resultUser = [User]()
        var resultUserRecord = [UserRecord]()
        
        //1er préparation -> est-ce-que mon url est le bon
        //si oui on continue notre fonction
        //sinon on s'arrête et on récup un erreur
        //dans le string de l'URL il faut: le url de votre table et son nom -> trouvez ça dans votre documentation API
        guard let url = URL(string : "https://api.airtable.com/v0/appg0b2X0FfkTwFJg/Users") else {
            print("URL unavailable")
            return (resultUser,resultUserRecord)
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
            //print(response) //<- si vous voulez voir à quoi ressemble une réponse serveur
            
            //ensuite on s'assure d'avoir une réponse positive sinon le reste du block s'arrête là
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("User request wasn't successful")
                return (resultUser,resultUserRecord)
            }
            
            //si notre HTTPResponse est a 200 on récup et décode la data
            //le TRY me permet d'essayer de décoder sinon il renvoie une erreur
            //on veut décode de la donnée donc Type.self pour la partie decodable
            //et on veut appliquer ce décode sur la donnée en provenance du serveur, ici data
            let decodedRequest = try JSONDecoder().decode(UserRequest.self, from: data)
            //print(decodedRequest) //<- résultat du décodage
            
            //comme on récup toute la requête on passe par une boucle forEach pour ajouter a notre array resultUser tous les utilisateurs trouvés lors du pull API
            decodedRequest.records.forEach { record in
                resultUser.append(record.fields)
            }
            
            decodedRequest.records.forEach { record in
                resultUserRecord.append(record)
            }
            
            //bonus pour trier par le nom des utilisateurs (pas obligatoire)
            //une closure -> fonction sans nom, qui s'applique sur des arrays ou d'autre types
            //on peut boucler avec et utiliser des let temporaire comme le .forEach a la 71
            //ou alors si on veut pas encore une fois déclarer un ou plusieurs let on peut utiliser le $0 ...
            //le $0 fonctionne comme le mot record a la ligne 71, il reprend chaque élément du tableau resultUser
            //le $1 permet de comparer
            //donc on compare 1 élément de tableau avec un autre et on voit lequel des deux vient se placer avant l'autre en fonction de l'ordre alphabétique (ici de A -> Z )
//            resultUser.sort { $0.name < $1.name }
            
            return (resultUser,resultUserRecord)
        } catch let error {
            print("ERROR USER API CALL : ",error)
        }
        
        return (resultUser,resultUserRecord)
    }
    
    /// fonction pour ajouter un favori au user connecté
    func addFavoriteToUser(userId : String, currentFavorites: [String], favoriteToAdd: String) async {
        // check de l'url
        guard let url = URL(string : "https://api.airtable.com/v0/appg0b2X0FfkTwFJg/Users") else {
            print("URL unavailable")
            return
        }
        
        print("userId : ", userId," / currentFav : ",currentFavorites, " / favoriteToAdd : ",favoriteToAdd)
        
        // définition de la requête
        var request = URLRequest(url: url) //-> on pause la question a cette URL
        request.httpMethod = "PATCH" // -> le type de la demande
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization") // -> info d'auth pour airtable
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Ajout de la nouvelle activité aux autres favoris
        var updatedFavorites = currentFavorites
        updatedFavorites.append(favoriteToAdd)
        
        print("updateFavorite from add fav function :",updatedFavorites)
        
        // Préparez le corps de la demande avec l'ID de l'utilisateur et l'ID de l'activité à ajouter aux favoris
        let updateBody: [String: Any] = [
            "records": [
                [
                    "id": userId.description,
                    "fields": [
                        "favorite": updatedFavorites
                    ]
                ]
            ]
        ]
        
        
        // Encodez le corps de la mise à jour au format JSON
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: updateBody)
            
            request.httpBody = jsonData

            
            // Effectuez la requête
            let (_, response) = try await URLSession.shared.data(for: request)
            
            // Vérifiez la réponse pour voir si la mise à jour a été réussie
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("API add favorite request wasn't successful. Status code: \(httpResponse.statusCode)")
                    if let data = try? Data(contentsOf: request.url!), let str = String(data: data, encoding: .utf8) {
                        print("Response body: \(str)")
                    }
                } else {
                    print("Update was successful : activity with id \(favoriteToAdd) was added to user with id \(userId)")
                    // si mise à jour OK, on lance une mise à jour des données utilisateur dans le stateObject pour mettre à jour l'affichage
                    DispatchQueue.main.async {
                        self.needsRefresh = true
                    }


                }
            }
        
        } catch let error {
            // Gérez les erreurs de mise à jour ici
            print("API ADD FAVORITE ERROR : ",error)
        }
    }
    
    /// fonction pour enlever un favori au user connecté
    func removeFavoriteToUser(userId: String, currentFavorites: [String], favoriteToRemove: String) async {
        // Check de l'URL
        guard let url = URL(string: "https://api.airtable.com/v0/appg0b2X0FfkTwFJg/Users") else {
            print("URL unavailable")
            return
        }
        
        // Définition de la requête
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Retrait de l'activité des favoris
        var updatedFavorites = currentFavorites
        updatedFavorites.removeAll(where: { $0 == favoriteToRemove })
        print("update fav from remove function : ",updatedFavorites)
        
        
        // Préparation du corps de la requête avec l'ID de l'utilisateur et l'ID de l'activité à retirer des favoris
        let updateBody: [String: Any] = [
            "records": [
                [
                    "id": userId.description,
                    "fields": [
                        "favorite": updatedFavorites
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
                    print("API remove favorite request wasn't successful. Status code: \(httpResponse.statusCode)")
                    if let data = try? Data(contentsOf: request.url!), let str = String(data: data, encoding: .utf8) {
                        print("Response body: \(str)")
                    }
                } else {
                    print("Update was successful: activity with id \(favoriteToRemove) was removed from user with id \(userId)")
                    // Si la mise à jour est OK, on lance une mise à jour des données utilisateur dans le stateObject pour mettre à jour l'affichage
                    DispatchQueue.main.async {
                        self.needsRefresh = true
                    }
                }
            }
        } catch let error {
            // Gestion des erreurs de mise à jour ici
            print("API REMOVE FAVORITE ERROR: ", error)
        }
    }
    
    /// fonction pour ajouter un upVote sur une activité à un utilisateur
    func addUpVoteToUser(userId: String, activityId: String, currentUpVote: [String]) async {
        // Check de l'URL
        guard let url = URL(string: "https://api.airtable.com/v0/appg0b2X0FfkTwFJg/Users") else {
            print("URL unavailable")
            return
        }
        
        // Définition de la requête
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // ajout du up vote dans la fiche user
        var updatedUpVote = currentUpVote
        updatedUpVote.append(activityId)
        print("update upvote from add function : ",updatedUpVote)
        
        
        // Préparation du corps de la requête avec l'ID de l'utilisateur et l'ID de l'activité à ajouter aux up votes
        let updateBody: [String: Any] = [
            "records": [
                [
                    "id": userId.description,
                    "fields": [
                        "userUpVote": updatedUpVote
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
                    print("API USER add upvote request wasn't successful. Status code: \(httpResponse.statusCode)")
                    if let data = try? Data(contentsOf: request.url!), let str = String(data: data, encoding: .utf8) {
                        print("Response body: \(str)")
                    }
                } else {
                    print("Update was successful: activity with id \(activityId) was added to up vote of user id \(userId)")
                    // Si la mise à jour est OK, on lance une mise à jour des données utilisateur dans le stateObject pour mettre à jour l'affichage
                    DispatchQueue.main.async {
                        self.needsRefresh = true
                    }
                }
            }
        } catch let error {
            // Gestion des erreurs de mise à jour ici
            print("API USER - ADD UP VOTE ERROR: ", error)
        }
    }
    
    /// fonction pour supprimer un upVote sur une activité à un utilisateur
    func removeUpVoteToUser(userId: String, activityId: String, currentUpVote: [String]) async {
        // Check de l'URL
        guard let url = URL(string: "https://api.airtable.com/v0/appg0b2X0FfkTwFJg/Users") else {
            print("URL unavailable")
            return
        }
        
        // Définition de la requête
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // ajout du up vote dans la fiche user
//        var updatedUpVote = currentUpVote
//        updatedUpVote.append(activityId)
//        print("update fav from remove function : ",updatedUpVote)
        
        // Retrait de l'activité des favoris
        var updatedUpVote = currentUpVote
        updatedUpVote.removeAll(where: { $0 == activityId })
        print("update upvote from remove function : ",updatedUpVote)
        
        
        // Préparation du corps de la requête avec l'ID de l'utilisateur et l'ID de l'activité à ajouter aux up votes
        let updateBody: [String: Any] = [
            "records": [
                [
                    "id": userId.description,
                    "fields": [
                        "userUpVote": updatedUpVote
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
                    print("API USER remove upvote request wasn't successful. Status code: \(httpResponse.statusCode)")
                    if let data = try? Data(contentsOf: request.url!), let str = String(data: data, encoding: .utf8) {
                        print("Response body: \(str)")
                    }
                } else {
                    print("Update was successful: activity with id \(activityId) was removed to up vote of user id \(userId)")
                    // Si la mise à jour est OK, on lance une mise à jour des données utilisateur dans le stateObject pour mettre à jour l'affichage
                    DispatchQueue.main.async {
                        self.needsRefresh = true
                    }
                }
            }
        } catch let error {
            // Gestion des erreurs de mise à jour ici
            print("API USER - REMOVE UP VOTE ERROR: ", error)
        }
    }
    
    
    /// fonction pour ajouter un upVote sur une activité à un utilisateur
    func addDownVoteToUser(userId: String, activityId: String, currentDownVote: [String]) async {
        // Check de l'URL
        guard let url = URL(string: "https://api.airtable.com/v0/appg0b2X0FfkTwFJg/Users") else {
            print("URL unavailable")
            return
        }
        
        // Définition de la requête
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // ajout du up vote dans la fiche user
        var updatedDownVote = currentDownVote
        updatedDownVote.append(activityId)
        print("update downvote from add function : ",updatedDownVote)
        
        
        // Préparation du corps de la requête avec l'ID de l'utilisateur et l'ID de l'activité à ajouter aux up votes
        let updateBody: [String: Any] = [
            "records": [
                [
                    "id": userId.description,
                    "fields": [
                        "userDownVote": updatedDownVote
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
                    print("API USER add downvote request wasn't successful. Status code: \(httpResponse.statusCode)")
                    if let data = try? Data(contentsOf: request.url!), let str = String(data: data, encoding: .utf8) {
                        print("Response body: \(str)")
                    }
                } else {
                    print("Update was successful: activity with id \(activityId) was added to down vote of user id \(userId)")
                    // Si la mise à jour est OK, on lance une mise à jour des données utilisateur dans le stateObject pour mettre à jour l'affichage
                    DispatchQueue.main.async {
                        self.needsRefresh = true
                    }
                }
            }
        } catch let error {
            // Gestion des erreurs de mise à jour ici
            print("API USER - ADD DOWN VOTE ERROR: ", error)
        }
    }
    
    /// fonction pour supprimer un upVote sur une activité à un utilisateur
    func removeDownVoteToUser(userId: String, activityId: String, currentDownVote: [String]) async {
        // Check de l'URL
        guard let url = URL(string: "https://api.airtable.com/v0/appg0b2X0FfkTwFJg/Users") else {
            print("URL unavailable")
            return
        }
        
        // Définition de la requête
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // ajout du up vote dans la fiche user
//        var updatedUpVote = currentUpVote
//        updatedUpVote.append(activityId)
//        print("update fav from remove function : ",updatedUpVote)
        
        // Retrait de l'activité des favoris
        var updatedDownVote = currentDownVote
        updatedDownVote.removeAll(where: { $0 == activityId })
        print("update upvote from remove function : ",updatedDownVote)
        
        
        // Préparation du corps de la requête avec l'ID de l'utilisateur et l'ID de l'activité à ajouter aux up votes
        let updateBody: [String: Any] = [
            "records": [
                [
                    "id": userId.description,
                    "fields": [
                        "userDownVote": updatedDownVote
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
                    print("API USER remove downvote request wasn't successful. Status code: \(httpResponse.statusCode)")
                    if let data = try? Data(contentsOf: request.url!), let str = String(data: data, encoding: .utf8) {
                        print("Response body: \(str)")
                    }
                } else {
                    print("Update was successful: activity with id \(activityId) was removed to down vote of user id \(userId)")
                    // Si la mise à jour est OK, on lance une mise à jour des données utilisateur dans le stateObject pour mettre à jour l'affichage
                    DispatchQueue.main.async {
                        self.needsRefresh = true
                    }
                }
            }
        } catch let error {
            // Gestion des erreurs de mise à jour ici
            print("API USER - REMOVE DOWN VOTE ERROR: ", error)
        }
    }


    
    
    
}
