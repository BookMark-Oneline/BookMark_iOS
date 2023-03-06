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
    convenience init(red: Int, green: Int, blue:Int, a:Int = 1){
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0, alpha: CGFloat(a))
    }
    
    convenience init(Hex: Int){
        self.init(red: (Hex >> 16) & 0xFF, green: (Hex >> 8) & 0xFF,
                  blue: Hex & 0xFF)
    }
    convenience init(AHex: Int){
        self.init(red: (AHex >> 16) & 0xFF, green: (AHex >> 8) & 0xFF,
                  blue: AHex & 0xFF, a: (AHex >> 24) & 0xFF)
    }
    
    // MARK: 텍스트 색상
    static let textOrange = UIColor(Hex: 0xF99030)
    
    static let textLightGray = UIColor(Hex: 0x979797)
    static let textGray = UIColor(Hex: 0x717171)
    static let textBoldGray = UIColor(Hex: 0x434343)
    
    // MARK: 그 외 색상
    static let lightOrange = UIColor(Hex: 0xFFB35A)
    static let lightLightOrange = UIColor(Hex: 0xFFDDA9)
    
    static let lightGray = UIColor(Hex: 0xEDEDED)
    static let lightLightGray = UIColor(Hex: 0xE3E3E3)
    static let semiLightGray = UIColor(Hex: 0xDFDFDF)
    
}
