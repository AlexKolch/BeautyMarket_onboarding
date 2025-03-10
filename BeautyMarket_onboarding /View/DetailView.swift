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
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    DetailView()
}
