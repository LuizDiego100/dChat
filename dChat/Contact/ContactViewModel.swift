//
//  ContactsViewModel.swift
//  dChat
//
//  Created by Luiz Andrade on 09/09/2022.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class ContactViewModel: ObservableObject {
    
    @Published var contacts: [Contact] = []
    @Published var isLoading = false
    
    var isLoaded = false
    
    private let repo: ContactRepositpry
    
    init(repo: ContactRepositpry) {
        self.repo = repo
    }
    
    func getContacts() {
        if isLoaded { return }
        isLoading = true
        isLoaded = true
        
        repo.getContacts { contacts in
            self.contacts.append(contentsOf: contacts)
            self.isLoading = false
        }
    }
}
