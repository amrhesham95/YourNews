
import Foundation

// MARK: - FetchedResultsControllerDelegateWrapper
//
class FetchedResultsControllerDelegateWrapper: NSObject {

    /// Relays FRC's Delegate: `controllerWillChangeContent`
    ///
    var onWillChangeContent: (() -> Void)?

    /// Relays FRC's Delegate: `controllerDidChangeContent`
    ///
    var onDidChangeContent: (() -> Void)?
}

// MARK: - MutableType: Storage.framework Type that will be retrieved (and converted into ReadOnly)
//
public typealias ResultsControllerMutableType = ReadOnlyConvertible

// MARK: - ResultsController
//
public class ResultsController<T: ResultsControllerMutableType> {

//  /// NotificationCenter ObserverBlock Token
//  ///
//  private var notificationCenterToken: Any?
//
  /// Closure to be executed before the results are changed.
  ///
  public var onWillChangeContent: (() -> Void)?

  /// Closure to be executed after the results are changed.
  ///
  public var onDidChangeContent: (() -> Void)?

  /// Closure to be executed whenever the (entire) content was reset. This happens whenever a `StorageManagerDidResetStorage` notification is
  /// caught
  ///
  public var onDidResetContent: (() -> Void)?
  
  /// Scroll 
  ///

  /// Content;
  ///
  /// - Note: Currently we support only one section.
  ///
  private(set) var sections: [Section] = [] {
    willSet {
      onWillChangeContent?()
    }
    didSet {
      onDidChangeContent?()
    }
  }
  
  /// Insert elements;
  /// - Note: Currently we support only one section
  ///
  public func insert(_ elements: [T]) {
    defer {
      onDidChangeContent?()
    }

    guard !sections.isEmpty else {
      sections = [Section(objects: elements)]
      return
    }
    
    sections.first?.updateObjects(elements)
  }
  
  /// Reset content
  ///
  public func reset() {
    sections = []
    onDidResetContent?()
  }
  
  /// Returns the fetched object at a given indexPath.
  ///
  /// Prefer to use `safeObject(at:)` instead.
  ///
  public func object(at indexPath: IndexPath) -> T.ReadOnlyType {
      return sections[indexPath.section].objects[indexPath.row].toReadOnly()
  }

  /// Returns the fetched object at the given `indexPath`. Returns `nil` if the `indexPath`
  /// does not exist.
  ///
  public func safeObject(at indexPath: IndexPath) -> T.ReadOnlyType? {
    return sections[indexPath.section].objects[indexPath.row].toReadOnly()
  }

  /// Returns the Plain ObjectIndex corresponding to a given IndexPath. You can use this index to map the
  /// `fetchedObject[index]` collection.
  ///
  /// This is *required* for calculations involving Page / Scrolling.
  ///
  public func objectIndex(from indexPath: IndexPath) -> Int {
    return indexPath.row
  }

  /// Indicates if there are any Objects matching the specified criteria.
  ///
  public var isEmpty: Bool {
    for section in sections where section.objects.isEmpty {
      return true
    }
    
    return sections.isEmpty
  }

  /// Returns the number of fetched objects.
  ///
  public var numberOfObjects: Int {
    return sections.reduce(Int.zero) { result, section in
      return result + section.objects.count
    }
  }

  /// Returns an array of all of the (ReadOnly) Fetched Objects.
  ///
  public var fetchedObjects: [T.ReadOnlyType] {
      return sections.reduce([T]()) { result, section in
          return result + section.objects
      }.map { object in
          object.toReadOnly()
      }
  }
  
  /// Sections count
  ///
  public var numberOfSections: Int {
      return sections.count
  }
  
  func numberOfObjects(in section: Int) -> Int {
      return sections[section].objects.count
  }
}

// MARK: - Nested Types
//
public extension ResultsController {

    // MARK: - Section

    /// Section.
    ///
    final class Section {
        
        /// Objects
        ///
        private(set) var objects: [T]

        /// Designated Initializer
        ///
        init(objects: [T]) {
            self.objects = objects
        }
      
        /// Update Objects
        ///
        func updateObjects(_ newObjects: [T]) {
          objects.append(contentsOf: newObjects)
        }
      
        var numberOfObjects: Int {
            return objects.count
        }
    }
}
