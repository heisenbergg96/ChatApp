//
//  UIColorExtension.swift
//  ChatOfChats
//
//  Created by Vikhyath on 03/01/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit

struct ChatColorGuide {
    
    static var COCBlue: UIColor {
        return makeSolidColor(red: 9, green: 46, blue: 35)
    }
    
    static var COCButtonBlue: UIColor  {
        return makeSolidColor(red: 109, green: 132, blue: 180)
    }
    
    static func makeSolidColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
