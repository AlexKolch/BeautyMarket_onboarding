//
//  RecentsCell.swift
//  SoundStream_Onboarding
//
//  Created by Алексей Колыченков on 04.03.2025.
//

import SwiftUI

struct RecentsCell: View {
    
    let imageName: String
    let title: String
    
    var body: some View {
        HStack {
            ImageLoader(urlSrting: imageName)
                .frame(width: 55, height: 55)
            Text(title)
                .font(.callout.weight(.semibold))
                .lineLimit(2) //чтобы не расширялся текст в ячейке
        }
        .padding(.trailing, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .themeColour(isSelected: false)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            HStack {
                RecentsCell(imageName: Constants.randomImage, title: "Some Randon Title")
                RecentsCell(imageName: Constants.randomImage, title: "Some Randon Title")
            }
            HStack {
                RecentsCell(imageName: Constants.randomImage, title: "Ihone 14")
                RecentsCell(imageName: Constants.randomImage, title: "Ihone 14")
            }
        }
    }
}
