//
//  ThemeCell.swift
//  DreamClock
//
//  Created by Sun on 2018/10/24.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

class ThemeCell: SimpleTableViewCell {

    override func makeUI() {
        super.makeUI()
        rightImageView.isHidden = true
        leftImageView.cornerRadius = Configs.BaseDimensions.cornerRadius * 2
        leftImageView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
    }
    
    func bind(to viewModel: ThemeCellViewModel) {
        viewModel.title.drive(titleLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.imageColor.drive(leftImageView.rx.backgroundColor).disposed(by: rx.disposeBag)
    }
}
