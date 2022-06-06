//
//  UserTableViewController.swift
//  Dummy
//
//  Created by Chia on 2022/05/30.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    var users = [User]()

override func viewDidLoad() {
    super.viewDidLoad()
    Task.init {
        do {
            let users = try await DummyController.shared.fetchUsers()
            updateUI(with: users)
        } catch {
            displayError(error, title: "Failed to Fetch Users")
        }
    }
}
    
    func updateUI(with users: [User]) {
        self.users = users
        tableView.reloadData()
    }
    
    func displayError(_ error: Error, title: String) {
        guard let _ = viewIfLoaded?.window else { return }
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "User", for: indexPath)
        configureCell(cell, forItemAt: indexPath)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? UserTableViewCell else { return }
        let user = users[indexPath.row]
        cell.userNameLabel.text = "\(user.firstName) \(user.lastName)"
        cell.userGenderLabel.text = user.title == "mr" ? "Male" : "Female"
        cell.userImageView.image = UIImage(systemName: "person.circle")
        
        Task.init {
            do {
                guard let imgURL = user.imgURL else { return }
                let image = try await DummyController.shared.fetchImage(from: URL(string: imgURL)!)
                cell.userImageView.image = image
            } catch {
                displayError(error, title: "Failed to Fetch Image")
            }
        }
    }

}
