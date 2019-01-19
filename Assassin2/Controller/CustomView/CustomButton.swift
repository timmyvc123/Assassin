//
//  CustomButton.swift
//  Assassin2
//
//  Created by Gregory T. Stickle on 1/17/19.
//  Copyright © 2019 Cowabunga Games. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        backgroundColor = UIColor.darkGray
//        titleLabel?.font = UIFont(name: font.avenirNextCondensedDemiBold, size: 22)
        layer.cornerRadius = frame.size.height/2
        setTitleColor(UIColor.white, for: .normal)
    }
}
