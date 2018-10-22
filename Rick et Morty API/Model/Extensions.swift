//
//  Extensions.swift
//  Rick et Morty API
//
//  Created by Kevin Trebossen on 21/10/2018.
//  Copyright © 2018 KTD. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func download(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Si on récupère une image
            guard let imageData = data, let image = UIImage(data: imageData) else { return }
            // il est nécessaire d'être dans la queue principale pourr ajouter une image
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    
}
