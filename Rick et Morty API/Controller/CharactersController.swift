//
//  ViewController.swift
//  Rick et Morty API
//
//  Created by Kevin Trebossen on 21/10/2018.
//  Copyright © 2018 KTD. All rights reserved.
//

import UIKit

class CharactersController: UIViewController {
    
    var pageSuivante = ""
    var personnages: [Personnage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getPerso()
    }
    
    func getPerso() {
        APIHelper().getPersos(string: APIHelper().urlPersonnages) { (pageSuivante, listePersos, erreurString) in
            if pageSuivante != nil {
                print(pageSuivante!)
                self.pageSuivante = pageSuivante!
            }
            if erreurString != nil {
                print(erreurString!)
            }
            if listePersos != nil {
                self.personnages.append(contentsOf: listePersos!)
                print(self.personnages.count)
            }
        }
    }


}

