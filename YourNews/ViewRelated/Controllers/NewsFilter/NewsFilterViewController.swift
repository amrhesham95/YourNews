//
//  NewsFilterViewController.swift
//  YourNews
//
//  Created by Amr Hesham on 24/04/2021.
//

import Foundation
import Eureka

// MARK: - NewsFilterViewController
//
class NewsFilterViewController: FormViewController {
  // MARK: - Properties
  
  /// Delegate when finish filtering
  ///
  weak var delegate: NewsFilterDelegate?

  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureFooterView()
    configureHeaderView()
    createRows()
  }
}

// MARK: - Rows Creations
//
extension NewsFilterViewController {
  
  /// Creating inputs rows of OnboardingViewController
  ///
  func createRows() {
    form +++ FilterSection(initialValue: nil)
  }
}

// MARK: - OnboardingViewController
//
extension NewsFilterViewController {
  
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

