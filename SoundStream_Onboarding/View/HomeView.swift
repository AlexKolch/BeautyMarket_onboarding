//
//  HomeView.swift
//  SoundStream_Onboarding
//
//  Created by Алексей Колыченков on 03.03.2025.
//

import SwiftUI
import SwiftfulUI

struct HomeView: View {
    @State private var currentUser: User?
    @State private var selectedCategory: Category?
    @State private var products: [Product] = []
    
    var body: some View {
        ZStack {
            Color.myBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack {
                            recentsSection
                            
                            if let product = products.first {
                                ConfigHeadlineCell(product)
                            }
                          
                        }
                        .padding(.horizontal, 16)
                        
                        ForEach(0..<20) { _ in
                            Rectangle().fill(.yellow)
                                .frame(width: 200, height: 200)
                        }
                    } header: {
                        header
                    }
                }.padding(.top, 8)
              
            }
            .scrollIndicators(.hidden)
            .clipped() //обрезаем чтобы ScrollView не выходил за зону header-а
        }
        .task {
            await fetchData()
        }
        .toolbar(.hidden, for: .navigationBar) //скрываем navigationBar
    }
    
    private func fetchData() async {
        do {
            currentUser = try await DataManager().loadUsers().last
            products = try await Array(DataManager().loadProducts().prefix(8)) //берем только первые 8 продукта
        } catch {
            
        }
    }
}

private extension HomeView {
    
    var header: some View {
        HStack(spacing: 0.0) {
            ZStack {
                if let currentUser {
                    ImageLoader(urlSrting: currentUser.image)
                        .background(.myWhite)
                        .clipShape(.circle)
                        .onTapGesture {
                            //To Do tap
                        }
                }
            }.frame(width: 35, height: 35) //кладем изображение в стэк чтобы установить сразу размер под него, иначе ScrollView заполняет собой все пространство пока нет изображения
          
            ScrollView(.horizontal) {
                HStack(spacing: 8.0) {
                    ForEach(Category.allCases, id: \.self) { category in
                        CategoryCell(title: category.rawValue.capitalized,
                                     isSelected: category == selectedCategory
                        )
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }.padding(.leading, 16) //отступ от аватарки
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading, 8) //отступ всего стека от края экрана
        .background(.myBlack)
    }
    
    var recentsSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                RecentsCell(imageName: product.firstImage, title: product.title)
            }
        }
    }
    
    @ViewBuilder func ConfigHeadlineCell(_ product: Product) -> some View {
        HeadlineCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category.rawValue.capitalized,
            title: product.title,
            subtitle: product.description) {
                print("infoBtn Tapped")
            } cellOrCardTapped: {
                print("cellOrCard Tapped")
            }
    }
}

#Preview {
    HomeView()
}
