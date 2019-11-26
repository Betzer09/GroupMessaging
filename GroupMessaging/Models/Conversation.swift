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
    @objc let conversationID: String
    /// Buddies that are currently in the conversation
    private(set) var groupMembers: [GMUser]
    /// Messages that have been sent in the conversation
    var messages: [Message] = []
    
    var jsonDict: [String: Any] {
        let messageDict = messages.compactMap({ $0.jsonDict })
        let groupMembersDict: [[String: Any]] = groupMembers.compactMap({ $0.jsonDict })
        
        return [
            FirebaseManager.DBKeys.messages: messageDict,
            FirebaseManager.DBKeys.members: groupMembersDict,
            FirebaseManager.DBKeys.conversationID: conversationID
        ]
    }
    
    // MARK: - Init
    init(groupMembers: [GMUser]) {
        self.conversationID = UUID().uuidString
        self.groupMembers = groupMembers
    }

    // MARK: - Init?
    init?(dict: [String: Any]) {
        guard let conversationID = dict[FirebaseManager.DBKeys.conversationID] as? String,
            let groupMembers = dict[FirebaseManager.DBKeys.members] as? [[String: Any]] else {
                print("Failed to parse conversation")
                return nil
        }

        self.conversationID = conversationID
        self.groupMembers = groupMembers.compactMap({ GMUser(dict: $0)})
        
        
        if let messages = dict[FirebaseManager.DBKeys.message] as? [[String: Any]] {
            self.messages = messages.compactMap({ Message(dict: $0)})
        } else {
            self.messages = []
        }
        
    }
}

