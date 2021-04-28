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
    
    let local = Localize.isArabic ? NSLocale(localeIdentifier: "ar") : NSLocale(localeIdentifier: "en_UK")
    
    for code in NSLocale.isoCountryCodes  {
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        let name = local.displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        let country = Country(name: name, code: code)
        countries.append(country)
    }
    return countries
  }()
  
  lazy var categories: [Category] = {
    ["Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology"].map{ Category(title: $0.localized, value: $0) }
  }()
  
}
