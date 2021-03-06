//
//  SettingsSwitchCell.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

class SettingsSwitchCell: SimpleTableViewCell {
    
    lazy var trigger: Switch = {
        let view = Switch()
        return view
    }()
    
    override func makeUI() {
        super.makeUI()
        stackView.insertArrangedSubview(trigger, at: 2)
        leftImageView.theme.tintColor = themeService.attribute { $0.secondary }
    }
    
    func bind(to viewModel: SettingsSwitchCellViewModel) {
        viewModel.title.drive(titleLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.detail.drive(detailLabel.rx.text).disposed(by: rx.disposeBag)
        
        viewModel.isEnabled.drive(trigger.rx.isOn).disposed(by: rx.disposeBag)
        trigger.rx.isOn.bind(to: viewModel.featureTrigger).disposed(by: rx.disposeBag)
        
        
        viewModel.showDisclosure.drive(onNext: { [weak self] (isHidden) in
            self?.rightImageView.isHidden = !isHidden
        }).disposed(by: rx.disposeBag)
        
        viewModel.imageName.drive(onNext: { [weak self] (imageName) in
            self?.leftImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        }).disposed(by: rx.disposeBag)
        
        
    }
}

