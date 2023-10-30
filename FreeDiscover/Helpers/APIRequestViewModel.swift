//
//  APIRequestViewModel.swift
//  FreeDiscover
//
//  Created by jerome julien on 25/10/2023.
//

import Foundation

// MARK: 'UserPAIRequest' -> Class qui va lister tous les call API. On la définie comme observable
class UserAPIRequest : ObservableObject{
    // On indique quelle donnée doit être observé
    @Published var allUser = [User]()
    
    func fetchedUser() async -> [User] {
        var resultUser = [User]()
        
        // Prepa 1 --> esgt ce que l'URL est le bon
        guard let url = URL(string:"https://api.airtable.com/v0/appg0b2X0FfkTwFJg/Users") else {
            print("URL unavailable")
            return resultUser
        }
        // Si oui, on prépare la requête (qui suis je ? Quelle donnée je cherche ?)
        var request = URLRequest(url: url)
        request.httpMethod="GET"
//        request.setValue("Bearer \(AIRTABLE_API_KEY)",forHTTPHeaderField: "Authorization")
        
        do { // equivalent de 'try'
            // On ouvre une session
            let (data, response) = try await URLSession.shared.data(for: request)
            // on vérifié 1- que la réponse est bien du type HTTPURL response et 2- si le code réponse est bien 200
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 
                // sinon on sort
                else {
                    print("Request wasn't successfull")
                    return resultUser
                }
            // on décode la data reçue en utilisant le type de UserRequest
            let decodedUsers = try JSONDecoder().decode(UserRequest.self,from:data)
            
            // on écrit dans "resultUser" les données présentes dans la data reçue
            decodedUsers.records.forEach { record in
                resultUser.append(record.fields)
            }
            
            //bonus pour trier par ordre alphabetique
            resultUser.sort {
                $0.name < $1.name
            }
            
            // on renvoie le résultat final
            return resultUser
            
        } catch let error {
            print("ERROR: ",error)
        }
        
        return resultUser
    }
}
