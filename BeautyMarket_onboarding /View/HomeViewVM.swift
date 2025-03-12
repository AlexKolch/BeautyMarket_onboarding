//
//  HomeViewVM.swift
//  BeautyMarket_onboarding 
//
//  Created by Алексей Колыченков on 12.03.2025.
//

import Foundation
import SwiftfulRouting

final class HomeViewVM: ObservableObject {
    
    let router: AnyRouter
    @Published var currentUser: User?
    @Published var selectedCategory: Category?
    @Published var products: [Product] = []
    @Published var productsRows: [ProductRow] = []
    
    var product: Product = .mock
    var user: User = .mock
    
    init(router: AnyRouter) {
        self.router = router
    }
    
     func fetchData() async {
        guard products.isEmpty else { return } ///чтобы продукты каждый раз при открытии экрана не загружались
        do {
            let user = try await DataManager().loadUsers().last
            let eightProducts = try await Array(DataManager().loadProducts().prefix(8)) //берем только первые 8 продукта
            await MainActor.run {
                currentUser = user
                products = eightProducts
            }
            var rows: [ProductRow] = [] //массив под бренды и их товары
            let allBrands = Set(products.map { $0._brand }) //получили брэнды и отсеили повторяющиеся
            for brand in allBrands {
                let products = products.filter { $0.brand == brand } //Продукты каждого конкретного бренда
                rows.append(ProductRow(titleBrand: brand.capitalized, product: eightProducts))
            }
            await MainActor.run {
                productsRows = rows
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
