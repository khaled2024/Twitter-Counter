//
//  Extension+UiFont.swift
//  Twitter Counter
//
//  Created by KhaleD HuSsien on 22/09/2025.
//

import UIKit

extension UIFont {
    enum DINNextArabic {
        static func regular(size: CGFloat) -> UIFont {
            return UIFont(name: "DINNextLTArabic-Regular", size: size)
                   ?? UIFont.systemFont(ofSize: size)
        }
        
        static func bold(size: CGFloat) -> UIFont {
            return UIFont(name: "DINNextLTArabic-Bold", size: size)
                   ?? UIFont.boldSystemFont(ofSize: size)
        }
    }
}
