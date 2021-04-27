// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let stretchyHeader = ImageAsset(name: "stretchyHeader")
  internal static let appAccent = ColorAsset(name: "AppAccent")
  internal static let appBackground = ColorAsset(name: "AppBackground")
  internal static let appPrimary = ColorAsset(name: "AppPrimary")
  internal static let addImageIcon = ImageAsset(name: "add-image-icon")
  internal static let checkedIcon = ImageAsset(name: "checked-icon")
  internal static let closeGreyIcon = ImageAsset(name: "close-grey-icon")
  internal static let closeIcon = ImageAsset(name: "close-icon")
  internal static let editIcon = ImageAsset(name: "edit-icon")
  internal static let favoriteStar = ImageAsset(name: "favorite-star")
  internal static let favoriteTabIcon = ImageAsset(name: "favorite-tab-icon")
  internal static let filterIcon = ImageAsset(name: "filter-icon")
  internal static let homeTabIcon = ImageAsset(name: "home-tab-icon")
  internal static let imageIcon = ImageAsset(name: "image-icon")
  internal static let locationPinIcon = ImageAsset(name: "location-pin-icon")
  internal static let networkErrorIcon = ImageAsset(name: "network-error-icon")
  internal static let nextArrowIcon = ImageAsset(name: "next-arrow-icon")
  internal static let noMessagesIcon = ImageAsset(name: "no-messages-icon")
  internal static let noResultSignboardIcon = ImageAsset(name: "no-result-signboard-icon")
  internal static let noResultsIcon = ImageAsset(name: "no-results-icon")
  internal static let placeholderImageIcon = ImageAsset(name: "placeholder-image-icon")
  internal static let unfavoriteStar = ImageAsset(name: "unfavorite-star")
  internal static let dateIcon = ImageAsset(name: "date-icon")
  internal static let gravatar = ImageAsset(name: "gravatar")
  internal static let textfieldDownIcon = ImageAsset(name: "textfield-down-icon")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
