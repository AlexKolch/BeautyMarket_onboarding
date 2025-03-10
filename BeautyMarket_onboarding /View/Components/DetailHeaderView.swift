//
//  DetailHeaderCell.swift
//  BeautyMarket_onboarding 
//
//  Created by Алексей Колыченков on 10.03.2025.
//

import SwiftUI
import SwiftfulUI

struct DetailHeaderView: View {
    
    var height: CGFloat = 300
    let title: String
    let subtitle: String
    let imageName: String
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                ImageLoader(urlSrting: imageName)
            )
            .overlay(
                VStack(alignment: .leading, spacing: 8) {
                    Text(subtitle)
                        .font(.headline)
                    Text(title)
                        .font(.largeTitle.bold())
                }
                    .foregroundStyle(.myWhite)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(colors: [.myBlack.opacity(0), .myBlack.opacity(0.8)],
                                       startPoint: .top, endPoint: .bottom)
                    )
                , alignment: .bottomLeading
            )
            .asStretchyHeader(startingHeight: height) //растягивание хиддера
    }
}

#Preview {
    ZStack {
        Color.myBlack.ignoresSafeArea()
        ScrollView {
            DetailHeaderView(title: "Huawei P30", subtitle: "Huawei", imageName: Constants.randomImage)
        }
        .ignoresSafeArea()
    }
}
