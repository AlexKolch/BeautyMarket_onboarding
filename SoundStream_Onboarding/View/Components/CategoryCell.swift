//
//  CategoryCell.swift
//  SoundStream_Onboarding
//
//  Created by Алексей Колыченков on 03.03.2025.
//

import SwiftUI

struct CategoryCell: View {
    let title: String
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .themeColour(isSelected: isSelected)
            .clipShape(.capsule)
    }
}

extension View {
    func themeColour(isSelected: Bool) -> some View {
        self
            .foregroundStyle(isSelected ? .myBlack : .myWhite)
            .background(isSelected ? .myGreen : .myDarkGray)
    }
}

#Preview {
    ZStack {
        Color.myBlack.ignoresSafeArea()
        VStack(spacing: 40.0) {
            CategoryCell(title: "Music")
            CategoryCell(title: "Music", isSelected: true)
        }
    }
}
