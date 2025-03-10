//
//  DetailView.swift
//  BeautyMarket_onboarding 
//
//  Created by Алексей Колыченков on 10.03.2025.
//

import SwiftUI

struct DetailView: View {
    
    var product: Product = .mock
    var user: User = .mock
    @Binding var products: [Product]
    
    var body: some View {
        ZStack {
            Color.myBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    DetailHeaderView(
                        height: 250,
                        title: product.title,
                        subtitle: product._brand,
                        imageName: product.thumbnail
                    )
                    DetailDescriptionView(
                        desriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.category.rawValue,
                        onAddToCartPressed: nil,
                        onShuffledPressed: nil,
                        onMorePressed: nil,
                        onSharePressed: nil
                    )
                    .padding(.horizontal, 16)
                    
                    ForEach(products) { product in
                            ProductCell(
                                brand: product._brand,
                                title: product.title,
                                imageName: product.firstImage,
                                imageSize: 50,
                                onTapCell: {},
                                onTapMore: {}
                            )
                            .padding(.leading, 16)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    DetailView(products: .constant([Product.mock, Product(id: 11, title: "ef", description: "ef", category: .beauty, price: 12.0, discountPercentage: 23.0, rating: 32.0, stock: 1, brand: "efddd", images: [Constants.randomImage, Constants.randomImage, Constants.randomImage], thumbnail: Constants.randomImage)]))
}
