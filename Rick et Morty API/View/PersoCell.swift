//
//  PersoCell.swift
//  Rick et Morty API
//
//  Created by Kevin Trebossen on 21/10/2018.
//  Copyright © 2018 KTD. All rights reserved.
//

import UIKit

class PersoCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var persoIV: UIImageView!
    
    var perso: Personnage!
    
    func setupCell(_ perso: Personnage) {
        self.perso = perso
        self.nameLBL.text = self.perso.name
        self.persoIV.download(self.perso.image)
        holderView.layer.cornerRadius = 25
        holderView.clipsToBounds = true
    }
    
    
    
    
    
}
