//
//  ConversationController.swift
//  GroupMessaging
//
//  Created by Austin Betzer on 11/26/19.
//  Copyright © 2019 Strides. All rights reserved.
//

import Foundation
import UIKit

class ConversationTableView: UITableViewController {
    // MARK: - Properties
    
    private var conversations = [Conversation]()
    private var selectedConversation: Conversation?
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Fetch Conversations
//        FirebaseManager.createConversation(members: [GMMockData.shared.currentSender, GMMockData.shared.testSender1, GMMockData.shared.testSender3])
        FirebaseManager.fetchConversations { [weak self] (response) in
            DispatchQueue.main.async {
                guard let strongSelf = self else {return}
                let conversations = response.compactMap({ Conversation(dict: $0)})
                strongSelf.conversations = conversations
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Tableivew Setup
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "conversationCell")!
        let conversation = conversations[indexPath.row]
        
        cell.textLabel?.text = conversation.groupMembers.last?.displayName
        cell.detailTextLabel?.text = conversation.messages.last?.text
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedConversation = conversations[indexPath.row]
        performSegue(withIdentifier: "toMessage", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    // MARK: - Actions
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMessage" {
            guard let vc = segue.destination as? ChatViewController else {return}
            vc.conversation = selectedConversation
        }
    }
    
    // MARK: - Functions
    
}
