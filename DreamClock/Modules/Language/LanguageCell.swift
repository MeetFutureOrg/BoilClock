//
//  LanguageCell.swift
//  DreamClock
//
//  Created by Sun on 2018/10/24.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

class LanguageCell: TableViewCell {

    lazy var titleLabel: Label = {
        let view = Label(style: .style141)
        view.textAlignment = .center
        return view
    }()
    
    override func makeUI() {
        super.makeUI()
        stackView.addArrangedSubview(titleLabel)
        themeService.rx
            .bind({ $0.text }, to: titleLabel.rx.textColor)
            .disposed(by: rx.disposeBag)
    }
    
    func bind(to viewModel: LanguageCellViewModel) {
        viewModel.title.drive(titleLabel.rx.text).disposed(by: rx.disposeBag)
    }

}
