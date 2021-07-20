//
//  Label.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
/*
 Fonts
 Regular System Font - 1, Semibold System Font - 2
 
 Sizes
 17 - 1, 14 - 2, 12 - 3, 36 - 4,
 
 Colors
 Black - 1, Gray - 2, White - 3, Secondary - 4
 */
enum LabelStyle {
    case style111  // PingFang-regular, 17, Black
    case style112  // PingFang-regular, 17, Gray
    case style113  // PingFang-regular, 17, White
    case style114  // PingFang-regular, 17, Secondary
    
    case style211  // PingFang-semibold, 17, Black
    case style212  // PingFang-semibold, 17, Gray
    case style213  // PingFang-semibold, 17, White
    case style214  // PingFang-semibold, 17, Secondary
    
    case style121  // PingFang-regular, 14, Black
    case style122  // PingFang-regular, 14, Gray
    case style123  // PingFang-regular, 14, White
    case style124  // PingFang-regular, 14, Secondary
    
    case style221  // PingFang-semibold, 14, Black
    case style222  // PingFang-semibold, 14, Gray
    case style223  // PingFang-semibold, 14, White
    case style224  // PingFang-semibold, 14, Secondary
    
    case style131  // PingFang-regular, 12, Black
    case style132  // PingFang-regular, 12, Gray
    case style133  // PingFang-regular, 12, White
    case style134  // PingFang-regular, 12, Secondary
    
    case style231  // PingFang-semibold, 12, Black
    case style232  // PingFang-semibold, 12, Gray
    case style233  // PingFang-semibold, 12, White
    case style234  // PingFang-semibold, 12, Secondary
    
    case style141  // PingFang-regular, 20, Black
    case style142  // PingFang-regular, 20, Gray
    case style143  // PingFang-regular, 20, White
    case style144  // PingFang-regular, 20, Secondary
    
    case style241  // PingFang-semibold, 20, Black
    case style242  // PingFang-semibold, 20, Gray
    case style243  // PingFang-semibold, 20, White
    case style244  // PingFang-semibold, 20, Secondary
    
    var font: UIFont {
        switch self {
        case .style111, .style112, .style113, .style114: return UIFont.systemFont(ofSize: 17.0, weight: .regular)
        case .style211, .style212, .style213, .style214: return UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        case .style121, .style122, .style123, .style124: return UIFont.systemFont(ofSize: 14.0, weight: .regular)
        case .style221, .style222, .style223, .style224: return UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        case .style131, .style132, .style133, .style134: return UIFont.systemFont(ofSize: 12.0, weight: .regular)
        case .style231, .style232, .style233, .style234: return UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        case .style141, .style142, .style143, .style144: return UIFont.systemFont(ofSize: 20.0, weight: .regular)
        case .style241, .style242, .style243, .style244: return UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        }
    }
    
    var color: UIColor {
        switch self {
        case .style111, .style211, .style121, .style221, .style131, .style231, .style141, .style241: return .textBlack()
        case .style112, .style212, .style122, .style222, .style132, .style232, .style142, .style242: return .textGray()
        case .style113, .style213, .style123, .style223, .style133, .style233, .style143, .style243: return .white
        case .style114, .style214, .style124, .style224, .style134, .style234, .style144, .style244: return .secondary()
        }
    }
}

class Label: UILabel {
    
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    var style = LabelStyle.style111 {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    init(style: LabelStyle) {
        super.init(frame: CGRect())
        self.style = style
        makeUI()
    }
    
    func makeUI() {
        layer.masksToBounds = true
        numberOfLines = 1
        //        cornerRadius = Configs.BaseDimensions.cornerRadius
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
        
        font = style.font
        textColor = style.color
    }
}

extension Label {
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {

        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    var leftTextInset: CGFloat {
        set { textInsets.left = newValue }
        get { return textInsets.left }
    }
    
    var rightTextInset: CGFloat {
        set { textInsets.right = newValue }
        get { return textInsets.right }
    }
    
    var topTextInset: CGFloat {
        set { textInsets.top = newValue }
        get { return textInsets.top }
    }
    
    var bottomTextInset: CGFloat {
        set { textInsets.bottom = newValue }
        get { return textInsets.bottom }
    }
}
