//
//  BrandRowCell.swift
//  SoundStream_Onboarding
//
//  Created by Алексей Колыченков on 05.03.2025.
//

import SwiftUI

struct BrandRowCell: View {
    
    private let imageSize: CGFloat = 100 //фиксируем размер для изображения, чтобы сетка прокрутки была одним размером, + улучшает перфоманс, не нужно высчитывать размер
    let imageName: String
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            ImageLoader(urlSrting: imageName)
                .frame(width: imageSize, height: imageSize)
            Text(title)
                .font(.callout)
                .foregroundStyle(.myLightGray)
                .lineLimit(3) //ограничиваем расширение текста вниз по ячейке
                .padding(4)
        }
        .frame(width: imageSize) //помещаем стэк в рамку ширинной как у изображения, ограничиваем расширение текста по ширине в ячейке
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        BrandRowCell(imageName: Constants.randomImage, title: "Some Item Text")
    }
}
