//
//  Message.swift
//  dChat
//
//  Created by Luiz Andrade on 11/09/2022.
//

import Foundation

struct Message: Hashable {
    
    let uuid: String
    let text: String
    let isMe: Bool
    let timestamp: UInt
}
