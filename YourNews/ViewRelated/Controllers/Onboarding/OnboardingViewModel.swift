//
//  OnboardingViewModel.swift
//  YourNews
//
//  Created by Amr Hesham on 25/04/2021.
//

import Foundation

// MARK: - OnboardingViewModel
//
class OnboardingViewModel: ViewModel {
  
  // MARK: - Properties
  
  private var _filterSubject: PublishSubject<NewsFilter> = PublishSubject<NewsFilter>()
  
  var filterObservable: Observable<NewsFilter> {
    return _filterSubject
  }
  
  func setFilter(filter: NewsFilter) {
    ServiceLocator.defaults.setCodable(filter, forKey: .filter)
    _filterSubject.send(filter)
  }
}
