
import Foundation

// MARK: - Represents a Mutable Entity that can be converted into a ReadOnly Type.
//
public protocol ReadOnlyConvertible: TypeErasedReadOnlyConvertible {

    /// Represents the ReadOnly Type (mirroring the receiver).
    ///
    associatedtype ReadOnlyType

    /// Returns a ReadOnly version of the receiver.
    ///
    func toReadOnly() -> ReadOnlyType
}

// MARK: - ReadOnlyConvertible TypeErasure Workaround.
//         This allows us to cast an entity that conforms to ReadOnlyConvertible, without hitting any `associatedtype` issues.
//
public protocol TypeErasedReadOnlyConvertible {

    /// Returns a ReadOnly version of the receiver, but with no Type associated.
    ///
    func toTypeErasedReadOnly() -> Any
}
