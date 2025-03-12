//
//  Product.swift
//  SoundStream_Onboarding
//
//  Created by Алексей Колыченков on 03.03.2025.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let category: Category
    let price, discountPercentage, rating: Double
    let stock: Int
    let brand: String?
    let images: [String]
    let thumbnail: String
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
    
    var _brand: String {
           brand ?? "Unknown"
       }
    
    static var mock: Product {
            Product(
                id: 123,
                title: "Iphone 9",
                description: "This is some mock product description that goes here.",
                category: .beauty,
                price: 999,
                discountPercentage: 15,
                rating: 4.5,
                stock: 50,
                brand: "Apple",
                images: [Constants.randomImage, Constants.randomImage, Constants.randomImage],
                thumbnail: Constants.randomImage
            )
        }
}

enum Category: String, Codable, CaseIterable {
    case beauty = "beauty"
    case fragrances = "fragrances"
    case furniture = "furniture"
    case groceries = "groceries"
}

///структура данных для строки товаров
struct ProductRow: Identifiable {
    let id = UUID()
    let titleBrand: String
    let product: [Product]
}
