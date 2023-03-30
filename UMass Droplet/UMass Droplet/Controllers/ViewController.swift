//
//  ViewController.swift
//  UMass Droplet
//
//  Created by Aryan Tipnis  on 3/23/23.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        errorMsg.alpha = 0
    }
    
    @IBAction func ButtonTapped(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    
}

    
    


 


