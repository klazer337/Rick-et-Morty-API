//
//  APIHelper.swift
//  Rick et Morty API
//
//  Created by Kevin Trebossen on 21/10/2018.
//  Copyright © 2018 KTD. All rights reserved.
//

import Foundation

// Le résultat sera optionel et asynchrone
typealias ApiCompletion = (_ next: String?, _ personnages: [Personnage]?, _ errorString: String?) -> Void

class APIHelper {
    // URL de la base
    private let _baseUrl = "https://rickandmortyapi.com/api/"
    
    // URL pour récuprérer les personnages
    var urlPersonnages: String {
        return _baseUrl + "character/"
    }
    
    
    func getPersos(string: String, completion: ApiCompletion?) {
        // Véririfer si l'URL est bonne
        if let url = URL(string: string) {
            // Lancement une session URL
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion?(nil, nil, error!.localizedDescription)
                }
                
                if data != nil {
                    // Convertir le JSON
                    do {
                        let reponseJSON = try JSONDecoder().decode(APIResult.self, from: data!)         // Décoder le JSON
                        completion?(reponseJSON.info.next, reponseJSON.results, nil)
                    } catch {
                        // Problème lors du décodage
                        completion?(nil, nil,error.localizedDescription)
                    }
                } else {
                    // Pas de data dispo
                    completion?(nil, nil, "Aucune data dispo")
                }
            }.resume()                      // Arrêter la tâche (obligatoire)
        } else {
            // Pas d'URL
            completion?(nil, nil, "URL invalide")
        }
    }
}
