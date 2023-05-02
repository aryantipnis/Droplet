//
//  ViewController.swift
//  UMass Droplet
//
//  Created by Aryan Tipnis  on 3/23/23.
//

import UIKit
import AVKit
import AVFoundation
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    var usernameLabel = String()
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
    
    func validateFields() -> String? {
        //Check all fields are filled in
        if username.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        return nil
        //return username.text
    }
    
    var showPassClick = true
    @IBAction func showPass(_ sender: Any) {
        if showPassClick {
                password.isSecureTextEntry = false
            } else {
                password.isSecureTextEntry = true
            }
        showPassClick = !showPassClick
    }
    
    func showError(message : String){
        errorMsg.text = message
        errorMsg.alpha = 1
    }
    
    @IBAction func ButtonTapped(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    @IBAction func SignInTapped(_ sender: Any) {
        
        //Validate Text fields
//        if username.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
//            self.showError(message: "Please fill in all fields")
//        }
//
        let error = validateFields()
        
        if(error != nil){
            showError(message: error!)
        } else {
            let email = username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pass = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: pass){ [self]
                (result, err) in
                
                
                if err != nil {
                    //There was an error
                    self.showError(message: "Incorrect username/password")
                }
                else{
                    usernameLabel = self.username.text ?? ""
                    //print(usernameLabel)
                    let story = UIStoryboard(name: "Main", bundle: nil)
                    let controller = story.instantiateViewController(withIdentifier: "UITabBarController") as! UITabBarController
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true)
                }
            }
        }
        
    }
}

    
    


 


