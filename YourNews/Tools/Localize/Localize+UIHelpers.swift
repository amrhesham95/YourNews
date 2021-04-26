//
//  Localize+UIHelpers.swift
//  electricitycomplaint
//
//  Created by Ahmed M. Hassan on 8/11/20.
//  Copyright © 2020 Unicom Soft. All rights reserved.
//

import UIKit

public extension Localize {
  
  static var isArabic: Bool {
    return Localize.currentLanguage() == "ar"
  }
}

// MARK: - UI Helpers
//
extension UIView {
  
  /// Returns true if the current language supports right to left
  ///
  static var isRightToLeft: Bool {
    return Localize.currentLanguage() == "ar"
  }

  /// Returns the semantic attributes for the current language.
  ///
  class var currentSemanticAttributes: UISemanticContentAttribute {
    return isRightToLeft ? .forceRightToLeft : .forceLeftToRight
  }
  
  /// Returns the semantic attributes for the current language.
  ///
  class var currentTextAlignment: NSTextAlignment {
    return isRightToLeft ? .right : .left
  }
}
