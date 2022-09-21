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
    
    func signIn() {
        print("email: \(email), senha: \(password)")
        
        isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            guard let user = result?.user, err == nil else {
                self.formInvalid = true
                self.alertText = err!.localizedDescription
                print(err)
                self.isLoading = false
                return
            }
            self.isLoading = false
            print("usuario logado \(user.uid)")
        }
    }
}
