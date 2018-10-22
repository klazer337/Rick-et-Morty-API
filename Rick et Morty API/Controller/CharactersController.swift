//
//  ViewController.swift
//  Rick et Morty API
//
//  Created by Kevin Trebossen on 21/10/2018.
//  Copyright © 2018 KTD. All rights reserved.
//

import UIKit

enum TypeQuery {
    case all
    case query
}

class CharactersController: UIViewController {
    
    var pageSuivante = ""
    var personnages: [Personnage] = []
    
    var pageSuivanteQuery = ""
    var personnagesQuery: [Personnage] = []
    
    
    var cellImageFrame = CGRect()
    var detailFrame = CGRect()
    var imageDeTransistion = UIImageView()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailView: DetailView!
    @IBOutlet weak var segmented: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getPerso(string: APIHelper().urlPersonnages, type: .all)
        detailView.alpha = 0            // pourt cacher la vue
        NotificationCenter.default.addObserver(self, selector: #selector(animateOut), name: Notification.Name("close"), object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageSuivante = ""
        personnagesQuery = []
        getPerso(string: APIHelper().urlAvecParam(), type: .query)
    }
    
    func animateIn(personnage: Personnage) {
        // animation
        detailFrame = detailView.persoIV.convert(detailView.persoIV.bounds, to: view)
        
        detailView.setup(personnage)
        
        //animation
        imageDeTransistion = UIImageView(frame: cellImageFrame)
        imageDeTransistion.download(personnage.image)
        imageDeTransistion.layer.cornerRadius = 25
        imageDeTransistion.clipsToBounds = true
        view.addSubview(imageDeTransistion)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.imageDeTransistion.frame = self.detailFrame
            self.imageDeTransistion.layer.cornerRadius = self.detailFrame.height / 2
            self.collectionView.alpha = 0
        }) { (success) in
            self.detailView.alpha = 1
        }
        
        detailView.alpha = 1
        collectionView.alpha = 0
    }
    
    @objc func animateOut() {
        UIView.animate(withDuration: 0.5, animations: {
            self.imageDeTransistion.frame = self.cellImageFrame
            self.imageDeTransistion.layer.cornerRadius = 25
            self.collectionView.alpha = 1
            self.detailView.alpha = 0
        }) { (success) in
            self.imageDeTransistion.removeFromSuperview()
        }
        collectionView.alpha = 1
    }
    
  
    
    func getPerso(string: String, type: TypeQuery) {
        APIHelper().getPersos(string: string) { (pageSuivante, listePersos, erreurString) in
            if pageSuivante != nil {
                switch type {
                case .all: self.pageSuivante = pageSuivante!
                case .query: self.pageSuivanteQuery = pageSuivante!
                }
            }
            if erreurString != nil {
                print(erreurString!)
            }
            if listePersos != nil {
                switch type {
                case .all: self.personnages.append(contentsOf: listePersos!)
                case .query:self.personnagesQuery.append(contentsOf: listePersos!)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
    
    
    
    
    
}

extension CharactersController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmented.selectedSegmentIndex == 0 {
            return personnages.count
        }
        return personnagesQuery.count
    }
    
    // Optionnel surtout si une seule section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let personnage = segmented.selectedSegmentIndex == 0 ? personnages[indexPath.item] : personnagesQuery[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersoCell", for: indexPath) as? PersoCell {
        cell.setupCell(personnage)
            return cell
        }
        return UICollectionViewCell()
    }
    
    // Taille 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let taille = collectionView.frame.width / 2 - 20
        return CGSize(width: taille, height: taille)
    }
    
    // appelle la page suivante si on arrive à la fin
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = segmented.selectedSegmentIndex == 0 ? personnages.count : personnagesQuery.count
        if indexPath.item == count - 1 {
            if segmented.selectedSegmentIndex == 0 && pageSuivante != "" {
                getPerso(string: pageSuivante, type: .all)
            }
            if segmented.selectedSegmentIndex == 1 && pageSuivanteQuery != "" {
                getPerso(string: pageSuivanteQuery, type: .query)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // animation
        guard let layout = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        let frame = collectionView.convert(layout.frame, to: collectionView.superview)
        cellImageFrame = CGRect(x: frame.minX, y: frame.minY + 50 , width: frame.width, height: frame.height - 50)
        
        switch segmented.selectedSegmentIndex {
        case 0: animateIn(personnage: personnages[indexPath.item])
        case 1:animateIn(personnage: personnagesQuery[indexPath.item])
        default: break
        }
    }
    
}

