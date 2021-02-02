//
//  ContactVCell.swift
//  lab_3
//
//  Created by Владислав Якубец on 01.12.2020.
//

import UIKit

class ContactViewCell: UITableViewCell {
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contactImageView: UIImageView! {
        didSet {
          contactImageView.layer.masksToBounds = true
          contactImageView.layer.cornerRadius = 22.0
        }
    }
    
    var contact: Contact? {
        didSet {
            configureCell()
        }
    }
    
    func configureCell() {
        guard let contact = contact else { return }
        contactNameLabel.text = contact.firstName
        emailLabel.text = contact.email
        contactImageView.image = contact.profilePicture
    }
}
