//
//  DataManager.swift
//  SoundStream_Onboarding
//
//  Created by Алексей Колыченков on 03.03.2025.
//

import Foundation

final class DataManager {
    let productURL: String = "https://dummyjson.com/products"
    let userURL: String = "https://dummyjson.com/users"
    
    func loadProducts() async throws -> [Product] {
        guard let url = URL(string: productURL) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode(ProductArray.self, from: data)
        return products.products
    }
    
    
    func loadUsers() async throws -> [User] {
        guard let url = URL(string: userURL) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let users = try JSONDecoder().decode(UserArray.self, from: data)
        return users.users
    }
    
    
}
