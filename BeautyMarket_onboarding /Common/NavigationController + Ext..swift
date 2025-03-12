//
//  NavigationController + Ext..swift
//  BeautyMarket_onboarding 
//
//  Created by Алексей Колыченков on 11.03.2025.
//

import SwiftUI

//Чтобы работало смахивание экрана назад
extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
