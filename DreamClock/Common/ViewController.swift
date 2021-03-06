//
//  ViewController.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import DZNEmptyDataSet
import NVActivityIndicatorView
import Hero
import SwiftMessages

class ViewController: UIViewController, Navigatable, NVActivityIndicatorViewable {
    
    var navigator: Navigator!
    
    let isLoading = BehaviorRelay(value: false)
    
    var automaticallyAdjustsLeftBarButtonItem = true
    
    var navigationTitle = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }
    
    let languageChanged = BehaviorRelay<Void>(value: ())
    
    var emptyDataSetTitle = R.string.localizable.applicationViewEmptyDataTitle.key.localized()
    var emptyDataSetImage = UIImage(named: "")
    var emptyDataSetImageTintColor = BehaviorRelay<UIColor?>(value: nil)
    
    let motionShakeEvent = PublishSubject<Void>()
    
    lazy var backBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem()
        view.title = ""
        return view
    }()
    
    lazy var closeBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem(image: UIImage(named: ""),
                                 style: .plain,
                                 target: self,
                                 action: nil)
        return view
    }()
    
    lazy var contentView: View = {
        let view = View()
        //        view.hero.id = "CententView"
        self.view.addSubview(view)
        view.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.left.right.equalToSuperview()
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            }
        }
        return view
    }()
    
    lazy var stackView: StackView = {
        let subviews: [UIView] = []
        let view = StackView(arrangedSubviews: subviews)
        self.contentView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        return view
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindViewModel()
        
        closeBarButton.rx.tap.asObservable().subscribe(onNext: { [weak self] () in
            self?.navigator.dismiss(sender: self)
        }).disposed(by: rx.disposeBag)
        
        // Observe device orientation change
        NotificationCenter.default
            .rx.notification(UIDevice.orientationDidChangeNotification)
            .subscribe { [weak self] (event) in
                self?.orientationChanged()
            }.disposed(by: rx.disposeBag)
        
        // Observe application did become active notification
        NotificationCenter.default
            .rx.notification(UIApplication.didBecomeActiveNotification)
            .subscribe { [weak self] (event) in
                self?.didBecomeActive()
            }.disposed(by: rx.disposeBag)
        
        NotificationCenter.default
            .rx.notification(UIAccessibility.reduceMotionStatusDidChangeNotification)
            .subscribe(onNext: { (event) in
                logDebug("Motion Status changed")
            }).disposed(by: rx.disposeBag)
        
        NotificationCenter.default.rx.notification(Notification.Name.LanguageChange).subscribe(onNext: { [weak self] (event) in
            self?.languageChanged.accept(())
        }).disposed(by: rx.disposeBag)
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if automaticallyAdjustsLeftBarButtonItem {
            adjustLeftBarButtonItem()
        }
        updateUI()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideAllMessage()
    }
    
    deinit {
        logDebug("\(type(of: self)): Deinited")
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        logDebug("\(type(of: self)): Received Memory Warning")
    }
    
    func makeUI() {
        
        languageChanged.subscribe(onNext: { [weak self] () in
            self?.emptyDataSetTitle = R.string.localizable.applicationViewEmptyDataTitle.key.localized()
        }).disposed(by: rx.disposeBag)
        
        hero.isEnabled = true

        view.theme.backgroundColor = themeService.attribute { $0.primary }
        backBarButton.theme.tintColor = themeService.attribute { $0.secondary }
        closeBarButton.theme.tintColor = themeService.attribute { $0.secondary }
        Observable.just(themeService.attribute { $0.text }.value).bind(to: self.rx.emptyDataSetImageTintColorBinder).disposed(by: rx.disposeBag)
        
        updateUI()
    }
    
    func bindViewModel() {}
    
    func updateUI() {}
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            motionShakeEvent.onNext(())
        }
    }
    
    func orientationChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.updateUI()
        }
    }
    
    func didBecomeActive() {
        self.updateUI()
    }
    
    // MARK: Adjusting Navigation Item
    
    func adjustLeftBarButtonItem() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 { // Pushed
            self.navigationItem.leftBarButtonItem = nil
        } else if self.presentingViewController != nil { // presented
            self.navigationItem.leftBarButtonItem = closeBarButton
        }
    }
    
}

extension ViewController {
    
    var inset: CGFloat {
        return Configs.BaseDimensions.inset
    }
    
    func emptyView(withHeight height: CGFloat) -> View {
        let view = View()
        view.snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
        return view
    }
    
//    @objc func handleTwoFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
//        if swipeRecognizer.state == .recognized {
//            LibsManager.shared.showFlex()
//        }
//    }
//
//    @objc func handleThreeFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
//        if swipeRecognizer.state == .recognized {
//            LibsManager.shared.showFlex()
//            HeroDebugPlugin.isEnabled = !HeroDebugPlugin.isEnabled
//        }
//    }
}

extension Reactive where Base: ViewController {
    
    /// Bindable sink for `backgroundColor` property
    var emptyDataSetImageTintColorBinder: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.emptyDataSetImageTintColor.accept(attr)
        }
    }
}

extension ViewController: DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetTitle)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return emptyDataSetImage
    }
    
    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return emptyDataSetImageTintColor.value
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -60
    }
}

extension ViewController: DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return !isLoading.value
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}


extension UIViewController {
    
    enum MessageType {
        case info
        case success
        case warning
        case error
    }
    
    func hideCurrent() {
        SwiftMessages.hide()
    }
    
    func hideAllMessage() {
        SwiftMessages.hideAll()
    }
    
    func showInfo(title: String?, body: String?, layout: MessageView.Layout = .tabView, position: SwiftMessages.PresentationStyle = .top, duration: SwiftMessages.Duration = .seconds(seconds: Configs.BaseDuration.hudDuration), icon: UIImage? = nil, buttonTitle: String? = nil, buttonTapHandler: ((_ button: UIButton) -> Void)? = nil) {
        show(title: title ?? "", body: body ?? "", type: .info, layout: layout, position: position, duration: duration, icon: icon, buttonTitle: buttonTitle, buttonTapHandler: buttonTapHandler)
    }
    
    func showSuccess(title: String?, body: String?, layout: MessageView.Layout = .tabView, position: SwiftMessages.PresentationStyle = .top, duration: SwiftMessages.Duration = .seconds(seconds: Configs.BaseDuration.hudDuration), icon: UIImage? = nil, buttonTitle: String? = nil, buttonTapHandler: ((_ button: UIButton) -> Void)? = nil) {
        show(title: title ?? "", body: body ?? "", type: .success, layout: layout, position: position, duration: duration, icon: icon, buttonTitle: buttonTitle, buttonTapHandler: buttonTapHandler)
    }
    
    func showWarning(title: String?, body: String?, layout: MessageView.Layout = .tabView, position: SwiftMessages.PresentationStyle = .top, duration: SwiftMessages.Duration = .seconds(seconds: Configs.BaseDuration.hudDuration), icon: UIImage? = nil, buttonTitle: String? = nil, buttonTapHandler: ((_ button: UIButton) -> Void)? = nil) {
        show(title: title ?? "", body: body ?? "", type: .warning, layout: layout, position: position,duration: duration, icon: icon, buttonTitle: buttonTitle, buttonTapHandler: buttonTapHandler)
    }
    
    func showError(title: String?, body: String?, layout: MessageView.Layout = .tabView, position: SwiftMessages.PresentationStyle = .top, duration: SwiftMessages.Duration = .seconds(seconds: Configs.BaseDuration.hudDuration), icon: UIImage? = nil, buttonTitle: String? = nil, buttonTapHandler: ((_ button: UIButton) -> Void)? = nil) {
        show(title: title ?? "", body: body ?? "", type: .error, layout: layout, position: position, duration: duration, icon: icon, buttonTitle: buttonTitle, buttonTapHandler: buttonTapHandler)
    }
    
    
    private func show(title: String, body: String, type: MessageType, layout: MessageView.Layout, position: SwiftMessages.PresentationStyle, duration: SwiftMessages.Duration, icon: UIImage?, buttonTitle: String?, buttonTapHandler: ((_ button: UIButton) -> Void)?) {
        let message = MessageView.viewFromNib(layout: layout)
        switch type {
        case .info:
            message.configureTheme(.info)
        case .success:
            message.configureTheme(.success)
        case .warning:
            message.configureTheme(.warning)
        case .error:
            message.configureTheme(.error)
        }
    
        message.configureContent(title: title, body: body)
        message.iconImageView?.isHidden = icon == nil
        message.iconImageView?.image = icon
        message.button?.isHidden = (buttonTitle?.isEmpty ?? true) || buttonTitle == nil
        if let buttonTitle = buttonTitle {
            message.button?.setTitle(buttonTitle, for: .normal)
            message.buttonTapHandler = buttonTapHandler
        }
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = position
        config.duration = duration
        SwiftMessages.show(config: config, view: message)
    }
}


