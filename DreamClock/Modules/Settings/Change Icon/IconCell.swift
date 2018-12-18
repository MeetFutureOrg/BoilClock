//
//  IconCell.swift
//  DreamClock
//
//  Created by Sun on 2018/12/18.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

class IconCell: SimpleTableViewCell {

    override func makeUI() {
        super.makeUI()
        rightImageView.isHidden = true
        leftImageView.cornerRadius = Configs.BaseDimensions.cornerRadius * 2
        leftImageView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
    }
    
    func bind(to viewModel: IconCellViewModel) {
        viewModel.imageName.drive(onNext: { [weak self] name in
            self?.leftImageView.image = UIImage(named: name)
        }).disposed(by: rx.disposeBag)
    }

}
