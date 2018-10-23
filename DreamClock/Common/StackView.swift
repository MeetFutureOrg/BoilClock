//
//  StackView.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

class StackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        spacing = inset
        axis = .vertical
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }

}
