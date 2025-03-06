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
    @State private var productsRows: [ProductRow] = []
    
    var body: some View {
        ZStack {
            Color.myBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                ///сделаем ленивый стэк, потому что лист с товарами(listRows)  может быть огромен
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(spacing: 16.0) {
                            recentsSection
                                .padding(.horizontal, 16)
                            
                            if let product = products.first {
                                ConfigHeadlineCell(product)
                                    .padding(.horizontal, 16)
                            }

                            listRows
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
        guard products.isEmpty else { return }
        do {
            currentUser = try await DataManager().loadUsers().last
            products = try await Array(DataManager().loadProducts().prefix(8)) //берем только первые 8 продукта
            
            var rows: [ProductRow] = [] //массив под бренды и их товары
            let allBrands = Set(products.map { $0._brand }) //получили брэнды и отсеили повторяющиеся
            for brand in allBrands {
                let products = products.filter { $0.brand == brand } //Продукты каждого конкретного бренда
                rows.append(ProductRow(titleBrand: brand.capitalized, product: products))
            }
            productsRows = rows
        } catch {
            print(error.localizedDescription)
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
                    .asButton(.press) {
                        
                    }
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
    
    var listRows: some View {
        ForEach(productsRows) { row in
            VStack {
                Text(row.titleBrand)
                    .font(.title.weight(.semibold))
                    .foregroundStyle(.myWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16.0) {
                        ForEach(row.product) { product in
                            BrandRowCell(imageName: product.firstImage, title: product.title)
                                .asButton(.press) {
                                    
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.never)
            }
        }
    }
}

#Preview {
    HomeView()
}
