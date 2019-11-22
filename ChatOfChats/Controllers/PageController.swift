////
////  PageController.swift
////  ChatOfChats
////
////  Created by Vikhyath on 11/01/19.
////  Copyright © 2019 Vikhyath. All rights reserved.
////
//
//
//import UIKit
//
//@IBDesignable
//
//class PasscodeView: UIControl, UIKeyInput {
//    
//    @IBInspectable public var maximumDigit: Int = 6
//    @IBInspectable public var dashSpacing: CGFloat = 8.0
//    @IBInspectable public var lineWidth: CGFloat  = 1.0
//    @IBInspectable public var textColor: UIColor = .black
//    @IBInspectable public var highlightLineColor: UIColor = .black
//    @IBInspectable public var lineColor: UIColor = .black
//    
//    fileprivate let fontSize: CGFloat = 36
//    fileprivate let dashSize: CGSize = CGSize(width: 43, height: 50)
//    fileprivate let font = UIFont(name: UIFont.systemFont(ofSize: 30))
//    fileprivate let style = NSMutableParagraphStyle()
//    fileprivate let spaceMarginTextLine: CGFloat = -10
//    fileprivate var mutablePasscode = NSMutableString()
//    
//    //Can't set keyboardtype if it is fileprivate
//    var keyboardType: UIKeyboardType = .numberPad
//    var isSecureType: Bool =  false
//    
//    var pinHandler: ((_ isValid: Bool) -> Void)?
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        initializeSource()
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        initializeSource()
//    }
//    
//    func getPasscode() -> String {
//        return mutablePasscode as String
//    }
//    
//    fileprivate func initializeSource() {
//        becomeFirstResponder()
//    }
//    
//    fileprivate func contentSize() -> CGSize {
//        return CGSize(width: CGFloat(self.maximumDigit) * dashSize.width + CGFloat(self.maximumDigit - 1) * dashSpacing, height: dashSize.height)
//    }
//    
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        return self.contentSize()
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        becomeFirstResponder()
//    }
//    
//    override func draw(_ rect: CGRect) {
//        
//        let contSize = self.contentSize()
//        
//        var origin = CGPoint(x: (frame.size.width - contSize.width) * 0.5, y: (frame.size.height - self.frame.height) * 0.5)
//        
//        guard let context = UIGraphicsGetCurrentContext() else {
//            return
//        }
//        
//        context.setFillColor(UIColor.gray.cgColor)
//        
//        var rect = CGRect(x: origin.x, y: origin.y + (dashSize.height - 1), width: dashSize.width, height: dashSize.height)
//        
//        for index in 0...maximumDigit-1 {
//            
//            rect.size.width = dashSize.width
//            rect.origin.x   =  (origin.x)
//            
//            origin.x = rect.origin.x + dashSpacing + rect.size.width
//            
//            context.setLineWidth(lineWidth)
//            
//            if index < mutablePasscode.length {
//                context.setFillColor(FRBColorGuide.DarkGreen.cgColor)
//                //context.setStrokeColor(highlightLineColor.cgColor)
//            } else {
//                context.setFillColor(UIColor.gray.cgColor)
//                //context.setStrokeColor(lineColor.cgColor)
//            }
//            if index == 0 {
//                context.setFillColor(FRBColorGuide.DarkGreen.cgColor)
//            }
//            //context.addRect(rect)
//            let clipPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: 4).cgPath
//            context.addPath(clipPath)
//            context.fillPath()
//            context.strokePath()
//            context.setFillColor(UIColor.gray.cgColor)
//            
//            if index < mutablePasscode.length {
//                
//                style.alignment = .center
//                
//                //let frame = CGRect(x: rect.minX, y: rect.minY, width: dashSize.width, height: dashSize.height)
//                
//                let strAttribute = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.paragraphStyle: style]
//                
//                var str: NSString = "●" //◉
//                if !isSecureType {
//                    str =  mutablePasscode.substring(with: NSRange(location: index, length: 1)) as NSString
//                }
//                
//                str.draw(in: rect, withAttributes: strAttribute as [NSAttributedString.Key: Any])
//            }
//        }
//        
//    }
//    
//}
//
//extension PasscodeView {
//    
//    var hasText: Bool { return mutablePasscode.length > 0 ? true : false }
//    
//    func insertText(_ text: String) {
//        
//        if self.mutablePasscode.length != maximumDigit {
//            self.mutablePasscode.append(text)
//            self.setNeedsDisplay()
//        }
//        
//        updateStatus()
//        
//    }
//    
//    func deleteBackward() {
//        
//        guard mutablePasscode.length != 0 else {
//            return
//        }
//        
//        mutablePasscode.deleteCharacters(in: NSRange(location: mutablePasscode.length - 1, length: 1))
//        updateStatus()
//        setNeedsDisplay()
//    }
//    
//    func clearText() {
//        mutablePasscode.deleteCharacters(in: NSRange(location: 0, length: mutablePasscode.length))
//        updateStatus()
//        setNeedsDisplay()
//    }
//    
//    func keyboardAppearance() -> UIKeyboardAppearance {
//        return UIKeyboardAppearance.light
//    }
//    
//    func updateStatus() {
//        if let handler = pinHandler {
//            handler(self.mutablePasscode.length == maximumDigit ? true : false)
//        }
//    }
//    
//    override var canBecomeFirstResponder: Bool { return true }
//    
//}
