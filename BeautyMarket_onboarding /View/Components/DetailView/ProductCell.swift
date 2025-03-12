//
//  ProductCell.swift
//  BeautyMarket_onboarding 
//
//  Created by Алексей Колыченков on 10.03.2025.
//

import SwiftUI

struct ProductCell: View {
    
    let brand: String?
    let title: String
    let imageName: String
    let imageSize: CGFloat
    var onTapCell: (() -> Void)?
    var onTapMore: (() -> Void)?
    
    var body: some View {
        HStack {
            ImageLoader(urlSrting: imageName)
                .frame(width: imageSize, height: imageSize)
            VStack(alignment: .leading, spacing: 4.0) {
                Text(title)
                    .foregroundStyle(.myWhite)
                    .fontWeight(.medium)
                    .lineLimit(2) //ограничение для расширения по высоте
                Text(brand ?? "")
                    .foregroundStyle(.myLightGray)
                    .font(.callout)
            }
            .frame(maxWidth: .infinity, alignment: .leading) //занимает все доступное пространство

            Image(systemName: "ellipsis")
                .foregroundStyle(.myWhite)
                .padding(16)
                .background(.black.opacity(0.001))
                .onTapGesture {
                    onTapMore?()
                }
                .padding(.trailing, 4)
        }
        .background(.black.opacity(0.001))
        .onTapGesture {
            onTapCell?()
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            ProductCell(brand: Product.mock.brand!, title: Product.mock.title, imageName: Product.mock.thumbnail, imageSize: 50)
            ProductCell(brand: nil, title: Product.mock.title, imageName: Product.mock.thumbnail, imageSize: 50)
            ProductCell(brand: Product.mock.brand!, title: Product.mock.title + "поупрпоукт", imageName: Product.mock.thumbnail, imageSize: 50)
        }
    }
}
