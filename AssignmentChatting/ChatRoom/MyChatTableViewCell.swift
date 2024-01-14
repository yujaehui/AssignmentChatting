//
//  MyChatTableViewCell.swift
//  AssignmentChatting
//
//  Created by Jaehui Yu on 1/14/24.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {

    @IBOutlet var myDateLabel: UILabel!
    @IBOutlet var myTextLabel: UILabel!
    @IBOutlet var myBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myDateLabel.configureDateLabel()
        
        myTextLabel.textAlignment = .right
        
        myBackground.backgroundColor = .lightGray.withAlphaComponent(0.3)
        myBackground.layer.cornerRadius = 10
    }
    
    func configureMyCell(data: Chat) {
        myTextLabel.text = data.message
        
        let dateStr = data.date
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = format.date(from: dateStr) {
            format.dateFormat = "hh:mm a"
            format.locale = Locale(identifier:"ko_KR")
            let result = format.string(from: date)
            myDateLabel.text = result
        }
    }
}
