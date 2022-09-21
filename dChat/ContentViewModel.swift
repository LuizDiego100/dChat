//
//  ContentViewModel.swift
//  dChat
//
//  Created by Luiz Andrade on 08/09/2022.
//

import Foundation
import FirebaseAuth

class ContentViewModel: ObservableObject {
    
    @Published var isLogged = Auth.auth().currentUser != nil
    
    func onAppear() {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.isLogged = user != nil
        }
    }
}
