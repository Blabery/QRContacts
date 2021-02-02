//
//  Contact.swift
//  lab_3
//
//  Created by Владислав Якубец on 01.12.2020.
//

import Foundation
import UIKit
import Contacts
import CoreImage.CIFilterBuiltins

class Contact: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var profilePicture: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case email
        case phoneNumber
      }
    
    init(firstName: String, lastName: String, email: String, phoneNumber: String,  profilePicture: UIImage?) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.profilePicture = profilePicture
    }
    
    convenience init?(contact: CNContact) {
        guard let email = contact.emailAddresses.first else { return nil }
        let firstName = contact.givenName
        let lastName = contact.familyName
        let phoneNumber = contact.phoneNumbers.first?.value.stringValue
        var profilePicture: UIImage?
        if let imageData = contact.imageData {
            profilePicture = UIImage(data: imageData)
        }
        
        self.init(firstName: firstName, lastName: lastName, email: email.value as String, phoneNumber: phoneNumber!, profilePicture: profilePicture)
        
    }
}

//MARK: - Equatable
extension Contact: Equatable {
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName &&
            lhs.email == rhs.email &&
            lhs.phoneNumber == rhs.phoneNumber
    }
}
