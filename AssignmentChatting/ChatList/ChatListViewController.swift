//
//  ChatListViewController.swift
//  AssignmentChatting
//
//  Created by Jaehui Yu on 1/14/24.
//

import UIKit

class ChatListViewController: UIViewController {
    
    var filteredChatList: [ChatRoom] = mockChatList

    @IBOutlet var userSearchBar: UISearchBar!
    @IBOutlet var chatListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSearchBar()
        configureTableView()
    }
}

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if filteredChatList[indexPath.row].chatroomImage.count == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GroupChatListTableViewCell.identifier, for: indexPath) as! GroupChatListTableViewCell
            let row = filteredChatList[indexPath.row]
            
            cell.configureCell(data: row)
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.identifier, for: indexPath) as! ChatListTableViewCell
            let row = filteredChatList[indexPath.row]
            
            cell.configureCell(data: row)
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ChatRoomViewController") as! ChatRoomViewController
        vc.contents = filteredChatList[indexPath.row]
        vc.list = filteredChatList[indexPath.row].chatList
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}

extension ChatListViewController {
    func configureTableView() {
        let xib = UINib(nibName: ChatListTableViewCell.identifier, bundle: nil)
        chatListTableView.register(xib, forCellReuseIdentifier: ChatListTableViewCell.identifier)
        
        let groupxib = UINib(nibName: GroupChatListTableViewCell.identifier, bundle: nil)
        chatListTableView.register(groupxib, forCellReuseIdentifier: GroupChatListTableViewCell.identifier)
        
        chatListTableView.dataSource = self
        chatListTableView.delegate = self
        
        chatListTableView.rowHeight = UITableView.automaticDimension
    }
}

extension ChatListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredChatList = mockChatList
        } else if searchText == " " {
            filteredChatList = []
        } else {
            filteredChatList = mockChatList.filter { $0.chatroomName.lowercased().contains(searchText.lowercased()) }
        }
        chatListTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

extension ChatListViewController {
    func configureSearchBar() {
        userSearchBar.placeholder = "친구 이름을 검색해보세요"
        userSearchBar.delegate = self
    }
}




