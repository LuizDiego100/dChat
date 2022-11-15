//
//  MessageRepository.swift
//  dChat
//
//  Created by Luiz Andrade on 14/11/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MessageRepository {
    
    func getContacts(completion: @escaping ([Contact]) -> Void) {
        var contacts: [Contact] = []
        let fromId = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("last-messages")
            .document(fromId)
            .collection("contacts")
            .addSnapshotListener { snapshot, error in
                if let changes = snapshot?.documentChanges {
                    for doc in changes {
                        if doc.type == .added {
                            let document = doc.document
                            
                            contacts.removeAll()
                            contacts.append(Contact(uuid: document.documentID,
                                                         name: document.data()["username"] as! String,
                                                         profileUrl: document.data()["photoUrl"] as! String,
                                                         lastMessage: document.data()["lastMessage"] as! String,
                                                         timestamp: document.data()["timestamp"] as! UInt))
                        }
                    }
                }
                completion(contacts)
            }
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
    
}