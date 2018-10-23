//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.image` struct is generated, and contains static references to 6 images.
  struct image {
    /// Image `dc_ic_calendar_add_filled_24_24x24_`.
    static let dc_ic_calendar_add_filled_24_24x24_ = Rswift.ImageResource(bundle: R.hostingBundle, name: "dc_ic_calendar_add_filled_24_24x24_")
    /// Image `dc_ic_calendar_add_outline_24_24x24_`.
    static let dc_ic_calendar_add_outline_24_24x24_ = Rswift.ImageResource(bundle: R.hostingBundle, name: "dc_ic_calendar_add_outline_24_24x24_")
    /// Image `dc_ic_clock_filled_24_24x24_`.
    static let dc_ic_clock_filled_24_24x24_ = Rswift.ImageResource(bundle: R.hostingBundle, name: "dc_ic_clock_filled_24_24x24_")
    /// Image `dc_ic_clock_outline_24_24x24_`.
    static let dc_ic_clock_outline_24_24x24_ = Rswift.ImageResource(bundle: R.hostingBundle, name: "dc_ic_clock_outline_24_24x24_")
    /// Image `dc_ic_settings_internal_filled_24_24x24_`.
    static let dc_ic_settings_internal_filled_24_24x24_ = Rswift.ImageResource(bundle: R.hostingBundle, name: "dc_ic_settings_internal_filled_24_24x24_")
    /// Image `dc_ic_settings_outline_24_24x24_`.
    static let dc_ic_settings_outline_24_24x24_ = Rswift.ImageResource(bundle: R.hostingBundle, name: "dc_ic_settings_outline_24_24x24_")
    
    /// `UIImage(named: "dc_ic_calendar_add_filled_24_24x24_", bundle: ..., traitCollection: ...)`
    static func dc_ic_calendar_add_filled_24_24x24_(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.dc_ic_calendar_add_filled_24_24x24_, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "dc_ic_calendar_add_outline_24_24x24_", bundle: ..., traitCollection: ...)`
    static func dc_ic_calendar_add_outline_24_24x24_(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.dc_ic_calendar_add_outline_24_24x24_, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "dc_ic_clock_filled_24_24x24_", bundle: ..., traitCollection: ...)`
    static func dc_ic_clock_filled_24_24x24_(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.dc_ic_clock_filled_24_24x24_, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "dc_ic_clock_outline_24_24x24_", bundle: ..., traitCollection: ...)`
    static func dc_ic_clock_outline_24_24x24_(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.dc_ic_clock_outline_24_24x24_, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "dc_ic_settings_internal_filled_24_24x24_", bundle: ..., traitCollection: ...)`
    static func dc_ic_settings_internal_filled_24_24x24_(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.dc_ic_settings_internal_filled_24_24x24_, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "dc_ic_settings_outline_24_24x24_", bundle: ..., traitCollection: ...)`
    static func dc_ic_settings_outline_24_24x24_(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.dc_ic_settings_outline_24_24x24_, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `Launch Screen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "Launch Screen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 2 localization tables.
  struct string {
    /// This `R.string.launchScreen` struct is generated, and contains static references to 2 localization keys.
    struct launchScreen {
      /// en translation: Copyright © 2018 FlyWake Studio. All rights reserved.
      /// 
      /// Locales: en, zh-Hans
      static let obGY5KRdText = Rswift.StringResource(key: "obG-Y5-kRd.text", tableName: "Launch Screen", bundle: R.hostingBundle, locales: ["en", "zh-Hans"], comment: nil)
      /// en translation: DreamClock
      /// 
      /// Locales: en, zh-Hans
      static let gJdYhRWbText = Rswift.StringResource(key: "GJd-Yh-RWb.text", tableName: "Launch Screen", bundle: R.hostingBundle, locales: ["en", "zh-Hans"], comment: nil)
      
      /// en translation: Copyright © 2018 FlyWake Studio. All rights reserved.
      /// 
      /// Locales: en, zh-Hans
      static func obGY5KRdText(_: Void = ()) -> String {
        return NSLocalizedString("obG-Y5-kRd.text", tableName: "Launch Screen", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: DreamClock
      /// 
      /// Locales: en, zh-Hans
      static func gJdYhRWbText(_: Void = ()) -> String {
        return NSLocalizedString("GJd-Yh-RWb.text", tableName: "Launch Screen", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    /// This `R.string.main` struct is generated, and contains static references to 0 localization keys.
    struct main {
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "Launch Screen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceType, Rswift.Validatable {
      let alarmViewController = StoryboardViewControllerResource<AlarmViewController>(identifier: "AlarmViewController")
      let bundle = R.hostingBundle
      let eventsViewController = StoryboardViewControllerResource<EventsViewController>(identifier: "EventsViewController")
      let mainTabBarController = StoryboardViewControllerResource<MainTabBarController>(identifier: "MainTabBarController")
      let name = "Main"
      let settingsViewController = StoryboardViewControllerResource<SettingsViewController>(identifier: "SettingsViewController")
      
      func alarmViewController(_: Void = ()) -> AlarmViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: alarmViewController)
      }
      
      func eventsViewController(_: Void = ()) -> EventsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: eventsViewController)
      }
      
      func mainTabBarController(_: Void = ()) -> MainTabBarController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: mainTabBarController)
      }
      
      func settingsViewController(_: Void = ()) -> SettingsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: settingsViewController)
      }
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.main().settingsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'settingsViewController' could not be loaded from storyboard 'Main' as 'SettingsViewController'.") }
        if _R.storyboard.main().mainTabBarController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'mainTabBarController' could not be loaded from storyboard 'Main' as 'MainTabBarController'.") }
        if _R.storyboard.main().eventsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'eventsViewController' could not be loaded from storyboard 'Main' as 'EventsViewController'.") }
        if _R.storyboard.main().alarmViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'alarmViewController' could not be loaded from storyboard 'Main' as 'AlarmViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
