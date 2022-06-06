//
//  UserTableViewCell.swift
//  Dummy
//
//  Created by Chia on 2022/05/30.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = userImageView.frame.width / 2
        }
    }
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
