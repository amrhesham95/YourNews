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
    configureHeaderView()
    createRows()
  }
}

// MARK: - Rows Creations
//
extension OnboardingViewController {
  
  /// Creating inputs rows of OnboardingViewController
  ///
  func createRows() {
    form +++ FilterSection(initialValue: nil)
  }
}

// MARK: - OnboardingViewController
//
extension OnboardingViewController {
  
  /// Configure footer view
  ///
  func configureFooterView() {
    footerView.addAction(ButtonAction(title: "Submit", style: .default) { _ in
      print("Submit button was tapped")
    })
  }
  
  /// Configure header view
  ///
  func configureHeaderView() {
    headerView.imageView.image = Asset.placeholderImageIcon.image
  }
}

