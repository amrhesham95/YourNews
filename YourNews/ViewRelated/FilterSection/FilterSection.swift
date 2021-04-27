//
//  FilterSection.swift
//  YourNews
//
//  Created by Amr Hesham on 24/04/2021.
//

import Eureka
import Foundation

// MARK: - Filter Section
//
class FilterSection: Section {
  
  // MARK: - Typealias
  typealias Element = NewsFilter
  typealias CountriesPushRow = PushRow<Country>
  typealias CategoriesPushRow = MultipleSelectorRow<Category>
  
  // MARK: - Properties
  
  let viewModel = FilterSectionViewModel()
  
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
    self.valueSubject = BehaviorSubject(initialValue ?? NewsFilter(country: Country(name: "", code: ""), categories: []))
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
  
  /// Countries row
  ///
  lazy var countriesRow: CountriesPushRow = {
    return CountriesPushRow { row in
      row.title = Strings.country
      row.value = value.country
      row.options = viewModel.allCountries
    }.onChange { [weak self] in
      guard let value = $0.value else { return }
      self?.value.country = value
    }
  }()
  
  /// Categories row
  ///
  lazy var categoriesRow: CategoriesPushRow = {
    return CategoriesPushRow { row in
      row.title = Strings.category
      row.value = value.categories
      row.options = viewModel.categories
    }.onChange { [weak self] in
      guard let value = $0.value else { return }
      self?.value.categories = value
    }
  }()
}

// MARK: - Constants
private extension FilterSection {
  
  enum Strings {
    static var country: String { "Country".localized }
    static var category: String { "Category".localized }
  }
}
