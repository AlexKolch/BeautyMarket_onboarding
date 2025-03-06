//
//  HeadlineCell.swift
//  SoundStream_Onboarding
//
//  Created by Алексей Колыченков on 04.03.2025.
//Переиспользуемая ячейка с стандартными типами не завязанная на конкретный тип(Product или любой другой) или конкретную реализацию функций из ViewModel

import SwiftUI

struct HeadlineCell: View {
    
    let imageName: String
    let headline: String?
    let subheadline: String
    let title: String
    let subtitle: String
    var infoBtnTapped: (() -> Void)? ///передадим сюда любую логику, не завязываемся на конкретную реализацию из viewModel
    var cellOrCardTapped: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                ImageLoader(urlSrting: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
                
                VStack(alignment: .leading, spacing: 2) {
                    if let headline {
                        Text(headline)
                            .font(.callout)
                            .foregroundColor(.myLightGray)
                    }
                    
                    Text(subheadline)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.myWhite)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) //выравнивает стэк по левому краю
            
            HStack {
                ImageLoader(urlSrting: imageName)
                    .frame(width: 140, height: 140)
                
                VStack(alignment: .leading, spacing: 24.0) {
                    VStack(alignment: .leading) {
                        Text(title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.myWhite)
                        Text(subtitle)
                            .foregroundStyle(.myLightGray)
                            .lineLimit(3)
                    }
                    .font(.callout)
                    
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.myGreen)
                            .font(.title3)
                            .padding(4) //увеличили область нажатия
                            .onTapGesture { infoBtnTapped?() }
                            .offset(x: -4) //выровнили относительно текстов
                            .frame(maxWidth: .infinity, alignment: .leading) //отодвигает элементы друг от друга
                        
                        Image(systemName: "cart")
                            .foregroundStyle(.myGreen)
                            .font(.title2)
                    }
                    .padding(.leading, 8)
                }
                .padding(.trailing, 12) //отступ для корзины
                .padding(.vertical)
            }
            .themeColour(isSelected: false)
            .clipShape(.rect(cornerRadius: 8))
            .onTapGesture { cellOrCardTapped?() } //нажатие на ячейку или Image card
        }
    }
}

#Preview {
    ZStack {
        Color.myBlack.ignoresSafeArea()
        HeadlineCell(imageName: Constants.randomImage, headline: "New Product", subheadline: "Subheadline", title: "Iphone16", subtitle: "An Apple mobile phone")
            .padding() //будем устанавливать отступы за пределами ячейки
    }
 
}
