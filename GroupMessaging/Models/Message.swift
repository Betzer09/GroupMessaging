//
//  Message.swift
//  GroupMessaging
//
//  Created by Austin Betzer on 11/26/19.
//  Copyright © 2019 Strides. All rights reserved.
//

import Foundation
import MessageKit
import CoreLocation

/**
 A message that is being sent to a user
 */
struct Message: MessageType {
    struct DBKeys {
        static let textKey = "text"
        static let senderNameKey = "sender_name"
        static let senderIDKey = "sender_id"
        static let conversationIDKey = "conversation_id"
        static let sendByKey = "seen_by"
    }
    
    /// The ID of the conversation that the message belongs too.
    let conversationID: String
    
    // MARK: - Message Type Protocal
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    private init(kind: MessageKind, user: GMUser) {
        self.kind = kind
        self.sender = user
        self.messageId = UUID().uuidString
        self.sentDate = Date()
        self.conversationID = UUID().uuidString
    }
    
    // MARK: - Custom Inits
    init(location: CLLocation, user: GMUser) {
        let locationItem = CoordinateItem(location: location)
        self.init(kind: .location(locationItem), user: user)
    }
    
    init(text: String, user: GMUser) {
        self.init(kind: .text(text), user: user)
    }
    
    init?(dict: [String: Any]) {
        return nil
    }
}

// MARK: - Custom Messaging Types
private struct CoordinateItem: LocationItem {

    var location: CLLocation
    var size: CGSize

    init(location: CLLocation) {
        self.location = location
        self.size = CGSize(width: 240, height: 240)
    }

}
