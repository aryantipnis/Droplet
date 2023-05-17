//
//  WaterManager.swift
//  UMass Droplet
//
//  Created by Ishaan Shetty on 12/05/23.
//

import Foundation
import SwiftyJSON

public class WaterManager {
    
    func fetchLiters() async throws -> Int {
            guard let username = AccountManager.shared.username else {
                throw NSError(domain: "AccountManagerError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Username is nil"])
            }
            
            if let url = URL(string: "https://flask-api-amber.vercel.app/user=\(username)/add=0") {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let json = try JSON(data: data)
                if let litres = json["liters"].int {
                    return litres
                } else {
                    throw NSError(domain: "ParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse 'litres' value"])
                }
            } else {
                throw NSError(domain: "URLError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            }
        }
    func fillBottle(liter:Int) async throws{
        guard let username = AccountManager.shared.username else {
            throw NSError(domain: "AccountManagerError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Username is nil"])
        }
        print(username)
        print(liter)

        if let url = URL(string: "https://flask-api-amber.vercel.app/user=\(username)/add=\(liter)") {
            let (data, _) = try await URLSession.shared.data(from: url)
            print("Successfully updated")
        } else {
            throw NSError(domain: "URLError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
    }
}
