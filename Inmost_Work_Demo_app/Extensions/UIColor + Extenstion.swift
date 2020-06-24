//
//  UIColor + Extenstion.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 24.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var defaultTextColor : UIColor {
         return UIColor(hex: 0x7E7E7E)
    }
    
    convenience init(hex: Int, alpha: Int = 255) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: CGFloat(alpha) / 255.0)
    }
}
