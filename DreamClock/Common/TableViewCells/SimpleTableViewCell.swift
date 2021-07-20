//
//  SimpleTableViewCell.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

class SimpleTableViewCell: TableViewCell {

    lazy var leftImageView: ImageView = {
        let view = ImageView(frame: CGRect())
        view.contentMode = .scaleAspectFit
        view.snp.makeConstraints({ (make) in
            make.width.equalTo(Configs.BaseDimensions.tableRowHeight)
        })
        return view
    }()
    
    lazy var titleLabel: Label = {
        let view = Label(style: .style223)
        return view
    }()
    
    lazy var detailLabel: Label = {
        let view = Label(style: .style132)
        return view
    }()
    
    lazy var rightImageView: ImageView = {
        let view = ImageView(frame: CGRect())
        view.image = R.image.dc_ic_cell_disclosure()?.withRenderingMode(.alwaysTemplate)
        view.snp.makeConstraints({ (make) in
            make.width.equalTo(20)
        })
        return view
    }()
    
    lazy var textsStackView: StackView = {
        let views: [UIView] = [self.titleLabel, self.detailLabel]
        let view = StackView(arrangedSubviews: views)
        view.spacing = self.spacing
        return view
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        if isSelection {
//            rightImageView.image = selected ? R.image.dc_ic_cell_checked() : nil
        }
    }
    
    override func makeUI() {
        super.makeUI()
        
        titleLabel.theme.textColor = themeService.attribute { $0.text }
        detailLabel.theme.textColor = themeService.attribute { $0.textGray }
        rightImageView.theme.tintColor = themeService.attribute { $0.secondary }
        
        stackView.spacing = self.inset
        stackView.addArrangedSubview(leftImageView)
        stackView.addArrangedSubview(textsStackView)
        stackView.addArrangedSubview(rightImageView)
        stackView.snp.remakeConstraints({ (make) in
            let inset = self.inset
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: inset/2, left: inset, bottom: inset/2, right: inset))
            make.height.equalTo(Configs.BaseDimensions.tableRowHeight)
        })
    }
}
