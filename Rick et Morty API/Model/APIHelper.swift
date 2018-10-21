//
//  APIHelper.swift
//  Rick et Morty API
//
//  Created by Kevin Trebossen on 21/10/2018.
//  Copyright © 2018 KTD. All rights reserved.
//

import Foundation

class APIHelper {
    // URL de la base
    private let _baseUrl = "https://rickandmortyapi.com/api/"
    
    // URL pour récuprérer les personnages
    var urlPersonnages: String {
        return _baseUrl + "character/"
    }
    
    
    func getPersos(string: String) {
        // Véririfer si l'URL est bonne
        if let url = URL(string: string) {
            // Lancement une session URL
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                if data != nil {
                    // Convertir le JSON
                }
            }.resume()                      // Arrêter la tâche (obligatoire)
        } else {                            // si URL -> NOK
            print("URL invalide")
        }
    }
}
