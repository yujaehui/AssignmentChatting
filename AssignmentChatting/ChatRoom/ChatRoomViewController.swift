//
//  ChatRoomViewController.swift
//  AssignmentChatting
//
//  Created by Jaehui Yu on 1/14/24.
//

import UIKit

class ChatRoomViewController: UIViewController {
    
    @IBOutlet var chatRoomTableView: UITableView!
    @IBOutlet var chatRoomTextField: UITextField!
    @IBOutlet var chatRoomButton: UIButton!
    
    var contents: ChatRoom = ChatRoom(chatroomId: 0, chatroomImage: [], chatroomName: "")
    var list: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configrueTableView()
        configureTextField()
        ConfigureNotificationCenter()
        ConfigureNavigation()

    }
    
    @objc func leftBarButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
}

extension ChatRoomViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if list[indexPath.row].user == .user {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as! MyChatTableViewCell
            let row = list[indexPath.row]
            myCell.configureMyCell(data: row)
            myCell.selectionStyle = .none
            return myCell
        } else {
            let otherCell = tableView.dequeueReusableCell(withIdentifier: "OtherChatTableViewCell", for: indexPath) as! OtherChatTableViewCell
            let row = list[indexPath.row]
            otherCell.configureOtherCell(data: row)
            otherCell.selectionStyle = .none
            return otherCell
        }
    }
}

extension ChatRoomViewController {
    func configrueTableView() {
        let myxib = UINib(nibName: "MyChatTableViewCell", bundle: nil)
        chatRoomTableView.register(myxib, forCellReuseIdentifier: "MyChatTableViewCell")
        
        let otherxib = UINib(nibName: "OtherChatTableViewCell", bundle: nil)
        chatRoomTableView.register(otherxib, forCellReuseIdentifier: "OtherChatTableViewCell")
        
        chatRoomTableView.dataSource = self
        chatRoomTableView.delegate = self
        
        chatRoomTableView.rowHeight = UITableView.automaticDimension
        chatRoomTableView.separatorStyle = .none
    }
}

extension ChatRoomViewController {
    func configureTextField() {
        chatRoomTextField.placeholder = "메시지를 입력하세요"
        chatRoomButton.setTitle("", for: .normal)
        chatRoomButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        chatRoomButton.tintColor = .gray
    }
}

extension ChatRoomViewController {
    func ConfigureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension ChatRoomViewController {
    func ConfigureNavigation() {
        navigationItem.title = contents.chatroomName
        let leftImage = UIImage(systemName: "chevron.backward")
        let leftButton = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(leftBarButtonClicked))
        leftButton.tintColor = .black
        navigationItem.leftBarButtonItem = leftButton
    }
}
