//
//  SignUpViewController.swift
//  UMass Droplet
//
//  Created by Aryan Tipnis  on 3/30/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var errorMsg: UILabel!
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            view.addGestureRecognizer(tapGesture)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var secondController = segue.destination as! AccountViewController
//        secondController.name = username.text
//    }
    
    func setUpElements() {
        errorMsg.alpha = 0
    }
    
    func isPasswordValid(pass : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: pass)
    }
    
    func validateFields() -> String? {
        //Check all fields are filled in
        if username.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
            
            //performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        }
        
        //Check if pass is secure
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(pass: cleanedPassword) == false {
            return "Password must contain atleast 8 characters, a special character and a number "
        }

        if(confirmPass.text != password.text){
            return "Password doesn't match"
        }
        
        return nil
    }
    
    func showError(message : String){
        errorMsg.text = message
        errorMsg.alpha = 1
    }
    
    var showPassClick = true
    @IBAction func showPass(_ sender: Any) {
        if showPassClick {
                password.isSecureTextEntry = false
                confirmPass.isSecureTextEntry = false
            } else {
                password.isSecureTextEntry = true
                confirmPass.isSecureTextEntry = true
            }
        showPassClick = !showPassClick
    }
    
    
    @IBAction func RegisterTapped(_ sender: Any) {
        let error = validateFields()
        
        if(error != nil){
            showError(message: error!)
        }
        else{
            //Create cleaned versions of the data
            let email = username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pass = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: pass ){ (result , err) in
                //Check for errors
                if err != nil {
                    //There was an error
                    self.showError(message: "Error creating user")
                }
               else{
                    //User created successfully, now store
                    let db = Firestore.firestore()

                    db.collection("users").addDocument(data: ["username" : email, "password" : pass, "uid" : result!.user.uid]) { (error) in

                        if error != nil {
                            self.showError(message: "User data couldn't be saved")
                        }
                    }

                    let story = UIStoryboard(name: "Main", bundle: nil)
                    let controller = story.instantiateViewController(withIdentifier: "UITabBarController") as! UITabBarController
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true)
                }
            }
        }
    }
}
