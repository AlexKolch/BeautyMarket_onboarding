//
//  DetailView.swift
//  BeautyMarket_onboarding 
//
//  Created by Алексей Колыченков on 10.03.2025.
//

import SwiftUI

struct DetailView: View {
    var product: Product = .mock
    
    var body: some View {
        ZStack {
            Color.myBlack.ignoresSafeArea()
            ScrollView(.vertical) {
                DetailHeaderCell(height: 250, title: product.title, subtitle: product._brand, imageName: product.thumbnail)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    DetailView()
}
