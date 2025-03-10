//
//  User.swift
//  SoundStream_Onboarding
//
//  Created by Алексей Колыченков on 03.03.2025.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
    
    static var mock: User {
           User(
               id: 444,
               firstName: "Alex",
               lastName: "Kolch",
               age: 76,
               email: "hi@hi.com",
               phone: "",
               username: "",
               password: "",
               image: Constants.randomImage,
               height: 180,
               weight: 200
           )
       }
}
