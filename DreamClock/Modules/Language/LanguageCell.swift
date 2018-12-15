//
//  LanguageCell.swift
//  DreamClock
//
//  Created by Sun on 2018/10/24.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

class LanguageCell: SimpleTableViewCell {
    
    override func makeUI() {
        super.makeUI()
        leftImageView.isHidden = true
        titleLabel.style = .style111
        detailLabel.style = .style122
        themeService.rx
            .bind({ $0.text }, to: titleLabel.rx.textColor)
            .disposed(by: rx.disposeBag)
    }
    
    func bind(to viewModel: LanguageCellViewModel) {
        viewModel.name.drive(titleLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.localeName.drive(detailLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.isCurrent.drive(onNext: { [weak self] (isCurrent) in
//            self?.isSelection = isCurrent
            self?.rightImageView.image = isCurrent ? R.image.dc_ic_cell_checked()?.withRenderingMode(.alwaysTemplate) : nil
        }).disposed(by: rx.disposeBag)
    }

}
