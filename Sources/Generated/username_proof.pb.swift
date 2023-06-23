// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: username_proof.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

enum UserNameType: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case none // = 0
  case fname // = 1
  case UNRECOGNIZED(Int)

  init() {
    self = .none
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .none
    case 1: self = .fname
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .none: return 0
    case .fname: return 1
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension UserNameType: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [UserNameType] = [
    .none,
    .fname,
  ]
}

#endif  // swift(>=4.2)

struct UserNameProof {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var timestamp: UInt64 = 0

  var name: Data = Data()

  var owner: Data = Data()

  var signature: Data = Data()

  var fid: UInt64 = 0

  var type: UserNameType = .none

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension UserNameType: @unchecked Sendable {}
extension UserNameProof: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension UserNameType: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "USERNAME_TYPE_NONE"),
    1: .same(proto: "USERNAME_TYPE_FNAME"),
  ]
}

extension UserNameProof: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "UserNameProof"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "timestamp"),
    2: .same(proto: "name"),
    3: .same(proto: "owner"),
    4: .same(proto: "signature"),
    5: .same(proto: "fid"),
    6: .same(proto: "type"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt64Field(value: &self.timestamp) }()
      case 2: try { try decoder.decodeSingularBytesField(value: &self.name) }()
      case 3: try { try decoder.decodeSingularBytesField(value: &self.owner) }()
      case 4: try { try decoder.decodeSingularBytesField(value: &self.signature) }()
      case 5: try { try decoder.decodeSingularUInt64Field(value: &self.fid) }()
      case 6: try { try decoder.decodeSingularEnumField(value: &self.type) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.timestamp != 0 {
      try visitor.visitSingularUInt64Field(value: self.timestamp, fieldNumber: 1)
    }
    if !self.name.isEmpty {
      try visitor.visitSingularBytesField(value: self.name, fieldNumber: 2)
    }
    if !self.owner.isEmpty {
      try visitor.visitSingularBytesField(value: self.owner, fieldNumber: 3)
    }
    if !self.signature.isEmpty {
      try visitor.visitSingularBytesField(value: self.signature, fieldNumber: 4)
    }
    if self.fid != 0 {
      try visitor.visitSingularUInt64Field(value: self.fid, fieldNumber: 5)
    }
    if self.type != .none {
      try visitor.visitSingularEnumField(value: self.type, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: UserNameProof, rhs: UserNameProof) -> Bool {
    if lhs.timestamp != rhs.timestamp {return false}
    if lhs.name != rhs.name {return false}
    if lhs.owner != rhs.owner {return false}
    if lhs.signature != rhs.signature {return false}
    if lhs.fid != rhs.fid {return false}
    if lhs.type != rhs.type {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
