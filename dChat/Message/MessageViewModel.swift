//
//  MessagesViewModel.swift
//  dChat
//
//  Created by Luiz Andrade on 08/09/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MessageViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var contacts: [Contact] = []
    
    private let repo: MessageRepository
    
    private var handleEnabled = true
    
    init(repo: MessageRepository) {
        self.repo = repo
    }
    
    func getContacts() {
        repo.getContacts { contacts in
            if self.handleEnabled {
                self.contacts = contacts
            }
        }
    }
    
    func handleEnabled(enabled: Bool) {
        self.handleEnabled = enabled
    }
    
    func logout() {
        repo.logout()
    }
}
