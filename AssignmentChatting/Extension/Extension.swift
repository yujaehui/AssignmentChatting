//
//  Extension.swift
//  AssignmentChatting
//
//  Created by Jaehui Yu on 1/14/24.
//

import UIKit

extension UIImageView {
    func configureProfileImageView() {
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}

extension UILabel {
    func configureNameLabel() {
        self.font = .boldSystemFont(ofSize:  16)
    }
    
    func configureChatLabel() {
        self.font = .systemFont(ofSize: 14)
        self.textColor = .gray
    }
    
    func configureDateLabel() {
        self.font = .systemFont(ofSize: 12)
        self.textColor = .gray
        self.textAlignment = .right
    }
}
