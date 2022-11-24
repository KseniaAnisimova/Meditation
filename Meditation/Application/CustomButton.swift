//
//  CustomButton.swift
//  Meditation
//
//  Created by user on 15.11.2022.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet { self.layer.cornerRadius = cornerRadius }
    }

}
