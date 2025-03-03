//
//  ImageLoaderView.swift
//  SoundStream_Onboarding
//
//  Created by Алексей Колыченков on 03.03.2025.
//

import SwiftUI
import SDWebImageSwiftUI
///Загрузчик изображений
struct ImageLoader: View {
    let urlSrting: String
    var contentMode: ContentMode = .fill
    
    var body: some View {
        //поместим изображение в прямоугольник чтобы сохранить заполнение картинкой fill и при этом задавать cornerRadius для вью
        Rectangle()
            .opacity(0.0)
            .overlay {
                SDWebImageLoader(urlSrting: urlSrting, contentMode: contentMode)
            }
            .clipped() //обрезаем изображение по прямоугольнику (если не будет cornerRadius у вью)
    }
}

//Настройка SDK
fileprivate struct SDWebImageLoader: View {
    
    let urlSrting: String
    var contentMode: ContentMode = .fill
    
    var body: some View {
        WebImage(url: URL(string: urlSrting)) { image in
            image.resizable()
            image.aspectRatio(contentMode: contentMode)
            image.allowsHitTesting(false)  //запрещаем нажатие на изображение
        } placeholder: {
            Color.gray.opacity(0.3)
        }
        .indicator(.activity)
    }
}

#Preview {
    ImageLoader(urlSrting: Constants.randomImage)
        .cornerRadius(30)
        .padding(40)
        .padding(.vertical, 60)
}
