//
//  SignInViewModel.swift
//  dChat
//
//  Created by Luiz Andrade on 02/09/2022.
//

import Foundation
import FirebaseAuth


class SignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var formInvalid = false
    var alertText = ""
    
    @Published var isLoading = false
    
    private let repo: SignInRepository
    
    init(repo: SignInRepository) {
        self.repo = repo
    }
    
    func signIn() {
        print("email: \(email), senha: \(password)")
        
        isLoading = true
        
        repo.signIn(withEmail: email, password: password) { err in
            if let err = err {
                self.formInvalid = true
                self.alertText = err
            }
            self.isLoading = false
        }
    }
}
