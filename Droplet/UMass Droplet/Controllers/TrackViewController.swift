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
    
    var Water_Manager = WaterManager()
    var waterDrank = 0 {
            didSet {
                waterConsumed.text = "\(waterDrank)L"
            }
        }
    
    
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
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        error.alpha = 0
        goalMessage.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            view.addGestureRecognizer(tapGesture)
        Task {
            do {
                waterDrank = try await Water_Manager.fetchLiters()
            } catch {
                print("Error fetching liters: \(error)")
            }
        }
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
        Task { @MainActor in
            validateFields()
            
            if error.alpha == 0 {
                if let text = Goal.text,
                   let goalValue = Double(text),
                   let capValue = Double(capacity) {
                    
                    bottleCount += 1
                    if goalValue == bottleCount {
                        goalMessage.alpha = 1
                    }
                    bottlesFilled.text = String(bottleCount)
                    waterConsumed.text = "\(waterDrank)L"
                    Completed.text = String((bottleCount * capValue * 100) / goalValue) + "%"
                    if let liters = Double(capacity) {
                        print("Works")
                        print(liters)
                        print(bottleCount)
                        do {
                            try await Water_Manager.fillBottle(liter: Int(liters))
                            // Update waterDrank value after filling the bottle
                            waterDrank += Int(liters)
                        } catch {
                            print("Error filling bottle: \(error)")
                        }
                        
                    }
                }
                else {
                    print("Error")
                    error.text = "Please enter a number"
                    error.alpha = 1
                }
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
