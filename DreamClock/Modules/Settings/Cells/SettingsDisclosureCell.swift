//
//  SettingsDisclosureCell.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

class SettingsDisclosureCell: SimpleTableViewCell {

    override func makeUI() {
        super.makeUI()
        themeService.rx
            .bind({ $0.secondary }, to: leftImageView.rx.tintColor)
            .disposed(by: rx.disposeBag)
    }
    
    func bind(to viewModel: SettingsDisclosureCellViewModel) {
        viewModel.title.drive(titleLabel.rx.text).disposed(by: rx.disposeBag)
        
        viewModel.showDisclosure.drive(onNext: { [weak self] (isHidden) in
            self?.rightImageView.isHidden = !isHidden
        }).disposed(by: rx.disposeBag)
        
        viewModel.imageName.drive(onNext: { [weak self] (imageName) in
            self?.leftImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        }).disposed(by: rx.disposeBag)
    }

}
