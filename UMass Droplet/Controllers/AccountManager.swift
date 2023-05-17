//
//  AccountManager.swift
//  UMass Droplet
//
//  Created by Ishaan Shetty on 12/05/23.
//

import Foundation

public class AccountManager{
    static let shared = AccountManager()
    var username: String?
    var latitude: Double?
    var longitude: Double?
    var venueTitle: String?
    var venue: Venue?
}

