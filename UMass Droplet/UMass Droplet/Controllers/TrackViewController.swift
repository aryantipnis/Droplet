//
//  TrackViewController.swift
//  UMass Droplet
//
//  Created by Aryan Tipnis  on 4/29/23.
//

import Foundation
import UIKit
import SwiftUI

class TrackViewController : UIViewController {
    
    @IBOutlet weak var bottleCap: UITextField!
    var capacity = String()
    @IBOutlet weak var Goal: UILabel!
    @IBOutlet weak var Completed: UILabel!
    @IBOutlet weak var bottlesFilled: UILabel!
    @IBOutlet weak var waterConsumed: UILabel!
    @IBOutlet weak var goalInput: UITextField!
    var goal = String()
    @IBOutlet weak var goalMessage: UILabel!
    @IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        error.alpha = 0
        goalMessage.alpha = 0
    }
    
    @IBAction func capEnterTapped(_ sender: Any) {
        validateFields()
        capacity = bottleCap.text ?? ""
    }
    
    @IBAction func goalEnterTapped(_ sender: Any) {
        validateFields()
        goal = goalInput.text ?? ""
        Goal.text = goal
    }
    
    var bottleCount = 0.0
    @IBAction func fillUpTapped(_ sender: Any) {
        validateFields()
        
        if(error.alpha == 0){
            if var text = Goal.text, var goalValue = Double(text), var capValue = Double(capacity) {
                bottleCount += 1
                if goalValue == bottleCount {
                    goalMessage.alpha = 1
                }
                bottlesFilled.text = String(bottleCount)
                waterConsumed.text = String(bottleCount*capValue) + "L"
                Completed.text = String((bottleCount*capValue*100)/goalValue ) + "%"
            }
            else {
                error.text = "Please enter a number"
                error.alpha = 1
            }
        }
    }
    
    func validateFields() {
        //Check all fields are filled in
        if bottleCap.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || goalInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            error.alpha = 1
        }
        else {
            error.alpha = 0
        }
    }
}
