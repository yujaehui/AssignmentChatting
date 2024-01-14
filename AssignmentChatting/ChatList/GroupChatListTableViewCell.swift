//
//  GroupChatListTableViewCell.swift
//  AssignmentChatting
//
//  Created by Jaehui Yu on 1/14/24.
//

import UIKit

class GroupChatListTableViewCell: UITableViewCell {
    
    static let identifier = "GroupChatListTableViewCell"
    
    @IBOutlet var profileImageView: [UIImageView]!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for i in 0..<profileImageView.count {
            profileImageView[i].configureProfileImageView()
        }
        nameLabel.configureNameLabel()
        chatLabel.configureChatLabel()
        dateLabel.configureDateLabel()
    }
    
    func configureCell(data: ChatRoom) {
        for i in 0..<profileImageView.count {
            profileImageView[i].image = UIImage(named: data.chatroomImage[i])
        }
        nameLabel.text = data.chatroomName
        chatLabel.text = data.chatList.last?.message
        
        let format = DateFormatter()
        if let dateString = data.chatList.last?.date {
            format.dateFormat = "yyyy-MM-dd HH:mm"
            if let date = format.date(from: dateString) {
                format.dateFormat = "yy.MM.dd"
                let result = format.string(from: date)
                dateLabel.text = result
            }
        }
    }
}
