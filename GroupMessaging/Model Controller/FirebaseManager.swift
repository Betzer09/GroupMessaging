//
//  FirebaseManager.swift
//  GroupMessaging
//
//  Created by Austin Betzer on 11/26/19.
//  Copyright © 2019 Strides. All rights reserved.
//

import Foundation
import FirebaseDatabase


class FirebaseManager {
    
    // MARK: - Database References
    private static let ref = Database.database().reference()
    
    // MARK: - DBKeys
    struct DBKeys {
        static let firebaseID = "firebase_id"
        static let conversationID = "conversation_id"
        static let buddies = "buddies"
        static let conversations = "conversations"
        static let fullname = "full_name"
        static let message = "message"
        
        
        static let messages = "messages"
        static let members = "members"
        
    }
    
    static private var conversationsRef: DatabaseReference? {
        return ref.child(DBKeys.conversations)
    }
    
    // MARK: - Messaging Functions
    static func createConversation(members: [GMUser]) {
        let newConversation = Conversation(groupMembers: members)
        
        conversationsRef?.child(newConversation.conversationID).setValue(newConversation.jsonDict, withCompletionBlock: { (error, _) in
            if let error = error {
                print("Failed to  create conversation with error: \(error.localizedDescription)")
            } else {
                print("Succesfully created converstion")
            }
        })
    }
    
    static func sendMessage(converstaionID: String, message: Message, completion: @escaping() -> ()) {
        conversationsRef?.child(converstaionID).child("messages").child(message.messageId).setValue(message.jsonDict, withCompletionBlock: { (error, _) in
            
            if let error = error {
                print("Failed to send message with error: \(error.localizedDescription)")
            } else {
                print("Succesfully send message")
            }
            
             completion()
        })
    }
    
//    static func fetchConversationMessages(initalIndex: Int, limit: Int,
//                                          conversationID: String, completion: @escaping(_ response: [[String: Any]]) -> ()) {
//        conversationsRef?.child(conversationID).child("messages")
//            .queryOrdered(byChild: "sent_date")
//            .observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let data = snapshot.value as? [String: Any] else {
//                completion([[:]])
//                return
//            }
//
//            let messages = data.compactMap({ $0.value as? [String: Any]})
//
//            completion(messages)
//
//        })
//    }
    
    static func observeNewMessages(conversationID: String, completion: @escaping(_ response: [[String: Any]]) -> ()) {
        conversationsRef?.child(conversationID).child("messages")
            .observe(.value, with: { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else {
                completion([[:]])
                return
            }
            
            let messages = data.compactMap({ $0.value as? [String: Any]})
            
            completion(messages)
        })
    }
    
    static func fetchConversations(completion: @escaping(_ response: [[String: Any]]) -> ()) {
        conversationsRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let conversationsData = snapshot.value  as? [String: Any] else {
                print("Failed to fetch conversations")
                return
            }
            
            let values = conversationsData.values
            var conversations = [[String: Any]]()
            for value in values {
                guard let conversation = value as? [String: Any] else {continue}
                print("Succesfully added a conversation")
                conversations.append(conversation)
            }
            
            completion(conversations)
        })
    }
    
}
