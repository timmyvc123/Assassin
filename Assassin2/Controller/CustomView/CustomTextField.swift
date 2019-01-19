//
//  CustomTextField.swift
//  Assassin2
//
//  Created by Gregory T. Stickle on 1/17/19.
//  Copyright © 2019 Cowabunga Games. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpField()
    }
    
    private func setUpField() {
        tintColor = .white
        textColor = .darkGray
        font = UIFont(name: "avenirNextCondesedDemiBold", size: 18)
        backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        autocorrectionType = .no
        layer.cornerRadius = 25.0
        clipsToBounds = true
        
//        let placeholder = self.placeholder != nil ? self.placeholder! : ""
//        let placeholerFont = UIFont(name: "avenirNextCondesedDemiBold", size: 18)
//        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
//            [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
//             NSAttributedString.Key.font: placeholerFont])
        
        let indentview = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftView = indentview
        leftViewMode = .always
    }
    
}
