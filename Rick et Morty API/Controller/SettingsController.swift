//
//  SettingsController.swift
//  Rick et Morty API
//
//  Created by Kevin Trebossen on 22/10/2018.
//  Copyright © 2018 KTD. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var statusLBL: UILabel!
    
    @IBOutlet weak var statusSWITCH: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwitch()
        setupNameLBL()
    }
    
    func setupSwitch() {
        statusSWITCH.setOn(UserDefaultHelper().getStatus(), animated: true)
        statusLBL.text = "Satut : " + UserDefaultHelper().getStatusString()
        
    }
    
    func setupNameLBL() {
        let name = UserDefaultHelper().getName()
        if name == "" {
            nameTF.placeholder = "Entrez un prénom"
        } else {
            nameTF.text = name
        }
    }

    @IBAction func saveAction(_ sender: Any) {
        UserDefaultHelper().setName(string: nameTF.text)
        // dismiss
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SwitchChanged(_ sender: UISwitch) {
        UserDefaultHelper().setStatus(bool: sender.isOn)
        setupSwitch()
    }
    
}
