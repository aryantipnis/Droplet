//
//  SignUpViewController.swift
//  UMass Droplet
//
//  Created by Aryan Tipnis  on 3/30/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var errorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        errorMsg.alpha = 0
    }
    
//    @IBAction func RegisterTapped(_ sender: Any) {
//
//    }
    
}
