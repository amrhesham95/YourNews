//
//  FilterSection.swift
//  YourNews
//
//  Created by Amr Hesham on 24/04/2021.
//

import Eureka

// MARK: - Filter Section
//
class FilterSection: Section {
  
  typealias Element = NewsFilter
  typealias CountriesPushRow = PushRow<String>
  typealias CategoriesPushRow = MultipleSelectorRow<String>
  
  /// Value
  ///
  private(set) var value: Element {
    get { valueSubject.value }
    set { valueSubject.send(newValue) }
  }
  
  /// Value Subject
  ///
  private let valueSubject: BehaviorSubject<Element>
  
  /// Observable Value
  ///
  var valueObservable: Observable<Element> {
    return valueSubject
  }
  
  // MARK: - Init
  
  init(initialValue: NewsFilter?) {
    // Set to default filter which was selected from Onboarding screen
    self.valueSubject = BehaviorSubject(initialValue ?? NewsFilter(country: "", categories: []))
    super.init()
    self <<< countriesRow
      <<< categoriesRow
  }
  
  required init<S>(_ elements: S) where S: Sequence, S.Element == BaseRow {
    fatalError("init(_:) has not been implemented")
  }
  
  required init() {
    fatalError("init() has not been implemented")
  }
  
  // MARK: - Rows
  
  /// Row CreateDateFrom
  ///
  lazy var countriesRow: CountriesPushRow = {
    return CountriesPushRow { row in
      row.title = Strings.countries
      row.value = value.country
      row.options = ["ae", "ar", "at"]
    }.onChange { [weak self] in
      guard let value = $0.value else { return }
      self?.value.country = value
    }
  }()
  
  /// Row CreateDateTo
  ///
  lazy var categoriesRow: CategoriesPushRow = {
    return CategoriesPushRow { row in
      row.title = Strings.countries
      row.value = value.categories
      row.options = ["business", "entertainment", "general"] 
    }.onChange { [weak self] in
      guard let value = $0.value else { return }
      self?.value.categories = value
    }
  }()
}

// MARK: - Constants
private extension FilterSection {
  
  enum Strings {
    static var countries: String { "Countries" }
    static var categories: String { "Categories" }
  }
}
