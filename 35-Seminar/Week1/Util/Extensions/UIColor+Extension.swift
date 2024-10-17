//
//  UIColor+Extension.swift
//  35-Seminar
//
//  Created by 최지석 on 10/6/24.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


extension UIColor {
    public enum Week1ColorSet {
        public static let backgroundColor = UIColor(hex: 0x101111)
        public static let errorMessageColor = UIColor(hex: 0xFF8C85)
    }
    
    public enum Week2ColorSet {
        public static let logoImageBorderColor = UIColor(hex: 0xE8E8E8)
        public static let primaryBlue = UIColor.systemBlue
    }
}
