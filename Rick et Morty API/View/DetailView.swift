//
//  DetailView.swift
//  Rick et Morty API
//
//  Created by Kevin Trebossen on 22/10/2018.
//  Copyright © 2018 KTD. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var persoIV: UIImageView!
    @IBOutlet weak var statusLBL: UILabel!
    @IBOutlet weak var genderLBL: UILabel!
    @IBOutlet weak var specieLBL: UILabel!
    @IBOutlet weak var originLBL: UILabel!
    @IBOutlet weak var locationLBL: UILabel!
    
    
    var view: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
    
    func loadXib() {
        backgroundColor = .clear
        let bundle = Bundle(for: type(of: self))
        if let xib = type(of: self).description().components(separatedBy: ".").last {
            let nib = UINib(nibName: xib, bundle: bundle)
            if let v = nib.instantiate(withOwner: self, options: nil).first as? UIView {
                view = v
                view?.frame = bounds
                if view != nil {
                    addSubview(view!)
                    view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    view?.backgroundColor = .white
                    view?.layer.cornerRadius = 25
                }
                
            }
        }
        
    }
    
    // Boutton fermer
    @IBAction func closeAction(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("close"), object: nil)
    }
    
    func setup(_ personnage: Personnage) {
        persoIV.download(personnage.image)
        persoIV.layer.cornerRadius = persoIV.frame.height / 2
        persoIV.clipsToBounds = true
        nameLBL.text = personnage.name
        locationLBL.text = "Lieu : " + personnage.location.name
        originLBL.text = "Origine : " + personnage.origin.name
        specieLBL.text = "Espèce : " + personnage.species
        genderLBL.text = "Sexe : " + convertirDonneeEnEmoji(string: personnage.gender)
        statusLBL.text = "Status : " + convertirDonneeEnEmoji(string: personnage.status)
        
        
    }
    
    func convertirDonneeEnEmoji(string: String) -> String {
        switch string {
        case "Dead": return "☠️"
        case "Alive": return "😄"
        case "Male": return "🚹"
        case "Female": return "🚺"
        default: return  "🤷‍♂️"
        }
    }

}
