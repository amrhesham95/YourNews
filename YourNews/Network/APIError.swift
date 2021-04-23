//
//  APIError.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation

// MARK: - APIError
enum APIError : String, Error {
    case noInternet = "Please check internet connection"
    case notFound = "No data found or page removed"
}
