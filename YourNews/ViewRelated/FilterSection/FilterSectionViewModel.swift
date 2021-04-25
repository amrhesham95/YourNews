//
//  FilterSectionViewModel.swift
//  YourNews
//
//  Created by Amr Hesham on 26/04/2021.
//

import Foundation

// MARK: - FilterSectionViewModel
//
class FilterSectionViewModel: ViewModel {
  
  // MARK: - Properties
  
  lazy var allCountries: [Country] = {
    var countries: [Country] = []

    for code in NSLocale.isoCountryCodes  {
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        let country = Country(name: name, code: code)
        countries.append(country)
    }
    return countries
  }()
  
  lazy var categories: [String] = {
    ["business", "entertainment", "general", "health", "science", "sports", "technology"]
  }()

  
  
}
