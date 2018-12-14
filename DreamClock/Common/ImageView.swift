//
//  ImageView.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

class ImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        makeUI()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        makeUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        tintColor = .primary()
        layer.masksToBounds = true
        contentMode = .center
        
        hero.modifiers = [.arc]
        
        // Kingfisher
        var kf = self.kf
        kf.indicatorType = .activity
        
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
}
