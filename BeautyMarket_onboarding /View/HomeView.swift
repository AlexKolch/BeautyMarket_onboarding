//
//  HomeView.swift
//  SoundStream_Onboarding
//
//  Created by Алексей Колыченков on 03.03.2025.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct HomeView: View {
   
    @StateObject var vm: HomeViewVM
    
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
                            
                            if let product = vm.products.first {
                                ConfigHeadlineCell(product)
                                    .padding(.horizontal, 16)
                            }

                            listRows
                        }
                    } header: {
                        headerCategory
                    }
                }.padding(.top, 8)
                
            }
            .scrollIndicators(.hidden)
            .clipped() //обрезаем чтобы ScrollView не выходил за зону header-а
        }
        .task {
            await vm.fetchData()
        }
        .toolbar(.hidden, for: .navigationBar) //скрываем navigationBar
    }
}

private extension HomeView {
    
    var headerCategory: some View {
        HStack(spacing: 0.0) {
            ZStack {
                if let currentUser = vm.currentUser {
                    ImageLoader(urlSrting: currentUser.image)
                        .background(.myWhite)
                        .clipShape(.circle)
                        .onTapGesture { //Tap on avatar
                        }
                }
            }.frame(width: 35, height: 35) //кладем изображение в стэк чтобы установить сразу размер под него, иначе ScrollView заполняет собой все пространство пока нет изображения
            
            ScrollView(.horizontal) {
                HStack(spacing: 8.0) {
                    ForEach(Category.allCases, id: \.self) { category in
                        CategoryCell(title: category.rawValue.capitalized,
                                     isSelected: category == vm.selectedCategory
                        )
                        .onTapGesture {
                            vm.selectedCategory = category
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
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: vm.products) { product in
            if let product {
                RecentsCell(imageName: product.firstImage, title: product.title)
                    .asButton(.press) {
                        goToProductDetails(product) //переход на детальный экран
                    }
            }
        }
    }
    
    func goToProductDetails(_ product: Product) {
        guard let currentUser = vm.currentUser else {return}
        vm.router.showScreen(.push) { _ in
            DetailView(product: product, user: currentUser, products: vm.products)
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
                goToProductDetails(product)
            }
    }
    
    var listRows: some View {
        ForEach(vm.productsRows) { row in
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
                                    goToProductDetails(product)
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
    RouterView { router in
        HomeView(vm: HomeViewVM(router: router))
    }
}
