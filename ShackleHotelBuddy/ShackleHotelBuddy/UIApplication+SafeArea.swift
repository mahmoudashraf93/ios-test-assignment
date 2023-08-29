//
//  UIApplication+SafeArea.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import UIKit

extension UIApplication {
    var safeAreaTop: CGFloat {
        (keyWindow?.safeAreaInsets.top) ?? 0
    }
}
