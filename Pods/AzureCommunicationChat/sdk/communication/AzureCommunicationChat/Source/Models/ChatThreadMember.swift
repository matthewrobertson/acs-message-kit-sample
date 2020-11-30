// --------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for
// license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.
// --------------------------------------------------------------------------

import AzureCore
import Foundation
// swiftlint:disable superfluous_disable_command
// swiftlint:disable identifier_name
// swiftlint:disable line_length
// swiftlint:disable cyclomatic_complexity

/// A member of the chat thread.
public struct ChatThreadMember: Codable {
    // MARK: Properties

    /// The id of the chat thread member in the format `8:acs:ResourceId_AcsUserId`.
    public let id: String
    /// Display name for the chat thread member.
    public let displayName: String?
    /// Time from which the chat history is shared with the member. The timestamp is in ISO8601 format: `yyyy-MM-ddTHH:mm:ssZ`.
    public let shareHistoryTime: Date?

    // MARK: Initializers

    /// Initialize a `ChatThreadMember` structure.
    /// - Parameters:
    ///   - id: The id of the chat thread member in the format `8:acs:ResourceId_AcsUserId`.
    ///   - displayName: Display name for the chat thread member.
    ///   - shareHistoryTime: Time from which the chat history is shared with the member. The timestamp is in ISO8601 format: `yyyy-MM-ddTHH:mm:ssZ`.
    public init(
        id: String, displayName: String? = nil, shareHistoryTime: Date? = nil
    ) {
        self.id = id
        self.displayName = displayName
        self.shareHistoryTime = shareHistoryTime
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case id
        case displayName
        case shareHistoryTime
    }

    /// Initialize a `ChatThreadMember` structure from decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.displayName = try? container.decode(String.self, forKey: .displayName)
        if let dateString = try? container.decode(String.self, forKey: .shareHistoryTime) {
            self.shareHistoryTime = Date(dateString, format: Date.Format.iso8601)
        } else {
            self.shareHistoryTime = nil
        }
    }

    /// Encode a `ChatThreadMember` structure
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        if displayName != nil { try? container.encode(displayName, forKey: .displayName) }
        if shareHistoryTime != nil {
            let dateFormatter = DateFormatter()
            let dateString = dateFormatter.string(from: shareHistoryTime!)
            try? container.encode(dateString, forKey: .shareHistoryTime)
        }
    }
}
