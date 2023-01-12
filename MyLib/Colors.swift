//
//  Colors.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//

import Foundation
import UIKit

//MARK: - 색 extension
extension UIColor {
    convenience init(red: Int, green: Int, blue:Int, a:Int = 0xFF){
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0, alpha: CGFloat(a) / 255.0)
    }
    
    convenience init(Hex: Int){
        self.init(red: (Hex >> 16) & 0xFF, green: (Hex >> 8) & 0xFF,
                  blue: Hex & 0xFF)
    }
    convenience init(AHex: Int){
        self.init(red: (AHex >> 16) & 0xFF, green: (AHex >> 8) & 0xFF,
                  blue: AHex & 0xFF, a: (AHex >> 24) & 0xFF)
    }
    
    static let textOrange = UIColor(Hex: 0xF99030)
    static let textGray = UIColor(Hex: 0x555555)
    static let textBoldGray = UIColor(Hex: 0x717171)
    static let textLightGray = UIColor(Hex: 0x979797)
    static let lightOrange = UIColor(Hex: 0xFFB35A)
    static let lightGray = UIColor(Hex: 0xEDEDED)
    static let lightLightOrange = UIColor(Hex: 0xFFDDA9)
}
