//
//  ChatViewController.swift
//  GroupMessaging
//
//  Created by Austin Betzer on 11/26/19.
//  Copyright © 2019 Strides. All rights reserved.
//

import Foundation
import UIKit
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController, MessagesDataSource {
    
    fileprivate var messageList = [Message]()
    
    func currentSender() -> SenderType {
        return GMMockData.shared.currentSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    
    // MARK: - Properties
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    // MARK: - Navigation
    
    // MARK: - Functions
    func configureMessageCollectionView() {
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        
        scrollsToBottomOnKeyboardBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false
        
//        messagesCollectionView.addSubview(refreshControl)
//        refreshControl.addTarget(self, action: #selector(loadMoreMessages), for: .valueChanged)
    }
    
    func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.tintColor = .primaryColor
        messageInputBar.sendButton.setTitleColor(.primaryColor, for: .normal)
        messageInputBar.sendButton.setTitleColor(
            UIColor.primaryColor.withAlphaComponent(0.3),
            for: .highlighted
        )
    }
}

// MARK: - MessageLabelDelegate
extension ChatViewController: MessageCellDelegate {
    func didSelectAddress(_ addressComponents: [String: String]) {
           print("Address Selected: \(addressComponents)")
       }
       
       func didSelectDate(_ date: Date) {
           print("Date Selected: \(date)")
       }
       
       func didSelectPhoneNumber(_ phoneNumber: String) {
           print("Phone Number Selected: \(phoneNumber)")
       }
       
       func didSelectURL(_ url: URL) {
           print("URL Selected: \(url)")
       }
       
       func didSelectTransitInformation(_ transitInformation: [String: String]) {
           print("TransitInformation Selected: \(transitInformation)")
       }

       func didSelectHashtag(_ hashtag: String) {
           print("Hashtag selected: \(hashtag)")
       }

       func didSelectMention(_ mention: String) {
           print("Mention selected: \(mention)")
       }

       func didSelectCustom(_ pattern: String, match: String?) {
           print("Custom data detector patter selected: \(pattern)")
       }
}

// MARK: - InputBarAccessoryViewDelegate
extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {

        // Here we can parse for which substrings were autocompleted
        let attributedText = messageInputBar.inputTextView.attributedText!
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.enumerateAttribute(.autocompleted, in: range, options: []) { (_, range, _) in

            let substring = attributedText.attributedSubstring(from: range)
            let context = substring.attribute(.autocompletedContext, at: 0, effectiveRange: nil)
            print("Autocompleted: `", substring, "` with context: ", context ?? [])
        }

        let components = inputBar.inputTextView.components
        messageInputBar.inputTextView.text = String()
        messageInputBar.invalidatePlugins()

        // Send button activity animation
        messageInputBar.sendButton.startAnimating()
        messageInputBar.inputTextView.placeholder = "Sending..."
        DispatchQueue.global(qos: .default).async {
            // fake send request task
            sleep(1)
            DispatchQueue.main.async { [weak self] in
                self?.messageInputBar.sendButton.stopAnimating()
                self?.messageInputBar.inputTextView.placeholder = "Aa"
                self?.insertMessages(components)
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        }
    }
    
    func isLastSectionVisible() -> Bool {
        
        guard !messageList.isEmpty else { return false }
        
        let lastIndexPath = IndexPath(item: 0, section: messageList.count - 1)
        
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    func insertMessage(_ message: Message) {
        messageList.append(message)
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messageList.count - 1])
            if messageList.count >= 2 {
                messagesCollectionView.reloadSections([messageList.count - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        })
    }


    private func insertMessages(_ data: [Any]) {
//        for component in data {
//            let user = GMMockData.shared.currentSender
//            if let str = component as? String {
//                let message = Message(kind: .text("Foobar"), sender: GMMockData.shared.currentSender, conversationID: "foo")
//                insertMessage(message)
//            }
//        }
    }

}
