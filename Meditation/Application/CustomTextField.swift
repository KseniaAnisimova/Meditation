//
//  CustomTextField.swift
//  Meditation
//
//  Created by user on 17.11.2022.
//

import UIKit

@IBDesignable

class CustomTextField: UITextField {
    @IBInspectable var colorPlaceholder: UIColor = .clear {
        didSet {
           
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: colorPlaceholder])
        }
    }
    @IBInspectable var bottomLineColor: UIColor = .clear {
        didSet {
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0.0, y: self.frame.height + 10, width: self.frame.size.width, height: 1.0)
            bottomLine.backgroundColor = bottomLineColor.cgColor
            self.layer.addSublayer(bottomLine)
        }
    }
}



