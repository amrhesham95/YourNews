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
    
    configureFooterView()
    createRows()
  }
  
}

// MARK: - Rows Creations
//
extension OnboardingViewController {
  
  /// Creating inputs rows of OnboardingViewController
  ///
  func createRows() {
    form +++ Section()
      <<< PushRow<String>() { row in
        row.title = "Countries"
        row.options = ["Egypt", "KSA", "UAE"]
      }
    
      <<< MultipleSelectorRow<String>() { row in
        row.title = "Categories"
        row.options = ["Category1", "Category2", "Category3"]
      }
  }
  
  /// Configure footer view
  ///
  func configureFooterView() {
    footerView.addAction(ButtonAction(title: "Submit", style: .default) { [weak self] _ in
      print("Submit button was tapped")
    })
  }
}

