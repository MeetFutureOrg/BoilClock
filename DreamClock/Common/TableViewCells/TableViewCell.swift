//
//  TableViewCell.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var isSelection = false
    
    lazy var containerView: View = {
        let view = View()
        view.backgroundColor = .clear
        self.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        return view
    }()
    
    lazy var stackView: StackView = {
        let subviews: [UIView] = []
        let view = StackView(arrangedSubviews: subviews)
        view.axis = .horizontal
        view.alignment = .center
        self.containerView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview().inset(inset)
        })
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func makeUI() {
        self.layer.masksToBounds = true
        self.selectionStyle = .none
        backgroundColor = .clear
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }

}
