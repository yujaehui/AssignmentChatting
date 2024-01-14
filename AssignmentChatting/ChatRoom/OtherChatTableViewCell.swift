//
//  OtherChatTableViewCell.swift
//  AssignmentChatting
//
//  Created by Jaehui Yu on 1/14/24.
//

import UIKit

class OtherChatTableViewCell: UITableViewCell {
    
    @IBOutlet var otherProfileImageView: UIImageView!
    @IBOutlet var otherNameLabel: UILabel!
    @IBOutlet var otherDateLabel: UILabel!
    @IBOutlet var otherTextLabel: UILabel!
    @IBOutlet var otherBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        otherProfileImageView.configureProfileImageView()
        
        otherDateLabel.textColor = .gray
        otherDateLabel.font = .systemFont(ofSize: 12)
        
        otherNameLabel.font = .boldSystemFont(ofSize: 15)
        
        otherBackground.layer.cornerRadius = 10
        otherBackground.layer.borderWidth = 1
    }
    
    func configureOtherCell(data: Chat) {
        otherProfileImageView.image = UIImage(named: data.user.rawValue)
        otherNameLabel.text = data.user.rawValue
        otherTextLabel.text = data.message
        
        let dateStr = data.date
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = format.date(from: dateStr) {
            format.dateFormat = "hh:mm a"
            format.locale = Locale(identifier:"ko_KR")
            let result = format.string(from: date)
            otherDateLabel.text = result
        }
        
    }
}
