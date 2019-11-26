//
//  Conversation.swift
//  GroupMessaging
//
//  Created by Austin Betzer on 11/26/19.
//  Copyright © 2019 Strides. All rights reserved.
//

import Foundation

@objc class Conversation: NSObject {
    
    // MARK: - Propeties
    
    /// The unique converstaion ID
    @objc let id: String
    /// Buddies that are currently in the conversation
    private var buddies: [Buddy]
    /// Messages that have been sent in the conversation
    var messages: [Message]
    
    // MARK: - Init
    init(id: String, buddies: [Buddy], messages: [Message]) {
        self.id = id
        self.buddies = buddies
        self.messages = messages
    }

    // MARK: - Init?
    init?(dict: [String: Any]) {
        guard let conversationID = dict[FirebaseManager.DBKeys.conversationID] as? String,
            let buddies = dict[FirebaseManager.DBKeys.conversationID] as? [[String: Any]],
            let messages = dict[FirebaseManager.DBKeys.message] as? [[String: Any]] else {return nil}

        self.id = conversationID
        self.buddies = buddies.compactMap({ Buddy(dict: $0) })
        self.messages = messages.compactMap({ Message(dict: $0)})
    }
}

