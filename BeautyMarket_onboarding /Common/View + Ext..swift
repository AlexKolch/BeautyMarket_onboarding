//
//  View + Ext..swift
//  SoundStream_Onboarding
//
//  Created by Алексей Колыченков on 05.03.2025.
//

import SwiftUI

extension View {
    func themeColour(isSelected: Bool) -> some View {
        self
            .foregroundStyle(isSelected ? .myBlack : .myWhite)
            .background(isSelected ? .myGreen : .myDarkGray)
    }
}
