//
//  DetailView.swift
//  BeautyMarket_onboarding 
//
//  Created by Алексей Колыченков on 10.03.2025.
//

import SwiftUI
import SwiftfulRouting

struct DetailView: View {
    
    @Environment(\.router) var router
    var product: Product = .mock
    var user: User = .mock
    @State private var showNavBar: Bool = false
   // @State private var offset: CGFloat = 0 //нужен был для определения положения geometryReader
    var products: [Product]
    
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
                    .readingFrame { frame in
//                        offset = frame.maxY
                        showNavBar = frame.maxY < 140
                    }
                    //  Text("\(offset)").background(.red) // для geometryReader информация
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
                                onTapCell: {
                                    goToProductDetails(product)
                                },
                                onTapMore: {}
                            )
                            .padding(.leading, 16)
                    }
                }
                
            }
            .scrollIndicators(.hidden)
            
            navBar
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

private extension DetailView {
    var navBar: some View {
        ZStack {
            Text(product.title)
                .font(.headline)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.myBlack)
                .offset(y: showNavBar ? 0 : -40)
                .opacity(showNavBar ? 1 : 0)
            Image(systemName: "chevron.left")
                .font(.title3)
                .padding(10)
                .background(showNavBar ? Color.clear : .myGray.opacity(0.7))
                .clipShape(.circle)
                .onTapGesture {
                    router.dismissScreen() //закрытие экрана
                }
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(.myWhite)
        .animation(.smooth(duration: 0.2), value: showNavBar) //анимация смены NavBar
    }
    
    func goToProductDetails(_ product: Product) {
        router.showScreen(.push) { _ in
            DetailView(product: product, user: user, products: products)
        }
    }
}

#Preview {
    RouterView { _ in
        DetailView(products: [Product.mock, Product(id: 11, title: "ef", description: "ef", category: .beauty, price: 12.0, discountPercentage: 23.0, rating: 32.0, stock: 1, brand: "efddd", images: [Constants.randomImage, Constants.randomImage, Constants.randomImage], thumbnail: Constants.randomImage)])
    }
   
}
