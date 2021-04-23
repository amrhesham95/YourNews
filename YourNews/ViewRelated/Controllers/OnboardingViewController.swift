//
//  OnboardingViewController.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation
import Eureka

// MARK: - OnboardingViewController
//
class OnboardingViewController: FormViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createRows()
  }
  
}

// MARK: - Rows Creations
//
extension OnboardingViewController {
  func createRows() {
//    configureFooterView()
    form +++ Section()
      <<< PushRow<String>() { row in
        row.title = "Countries"
        row.options = ["Egypt", "KSA", "UAE"]
      }
  }
  
}

