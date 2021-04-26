//
//  IBDesignable+Localize1.swift
//  Localize-Swift
//
//  Created by BinaryBoy on 7/23/19.
//

import UIKit

// MARK: - UILabel localize Key extention for language in story board

@IBDesignable public extension UILabel {
    @IBInspectable var localizeKey: String? {
        get {
            return self.text
        }
        
        set {
            // set new value from dictionary
            DispatchQueue.main.async {
                self.text = newValue?.localized
            }
        }
    }
}

// MARK: - UIButton localize Key extention for language in story board

@IBDesignable public extension UIButton {
    
    @IBInspectable var localizeKey: String? {
        
        get {
            return self.titleLabel?.text
        }
        
        set {
            // set new value from dictionary
            DispatchQueue.main.async {
                self.setTitle(newValue?.localized, for: .normal)
            }
        }
    }
}

// MARK: - UITextView localize Key extention for language in story board

@IBDesignable public extension UITextView {
    
    @IBInspectable var localizeKey: String? {
        
        get {
            return self.text
        }
        
        set {
            // set new value from dictionary
            DispatchQueue.main.async {
                self.text = newValue?.localized
            }
        }
    }
}

// MARK: - UITextField localize Key extention for language in story board

@IBDesignable public extension UITextField {
    @IBInspectable var localizeKey: String? {
        
        get {
            return self.placeholder
        }
        
        set {
            // set new value from dictionary
            DispatchQueue.main.async {
                self.placeholder = newValue?.localized
            }
        }
    }
}

// MARK: - UINavigationItem localize Key extention for language in story board

@IBDesignable public extension UINavigationItem {
    
    @IBInspectable var localizeKey: String? {
        
        get {
            return self.title
        }
        
        set {
            // set new value from dictionary
            DispatchQueue.main.async {
                self.title = newValue?.localized
            }
        }
    }
}
