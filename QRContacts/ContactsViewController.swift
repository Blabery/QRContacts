//
//  GenerateQRVC.swift
//  lab_3
//
//  Created by Владислав Якубец on 01.12.2020.
//

import UIKit
import ContactsUI

class ContactsViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var label: UILabel!
    
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if contacts.count == 0 {
            table.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contactsInfo" {
            let cell = sender as? ContactViewCell
            let indexPath = table.indexPath(for: cell!)
            
            let contactInfoViewController = segue.destination as? ContactInfoViewController
            contactInfoViewController?.contact = contacts[indexPath!.row]
            
        }
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.predicateForEnablingContact = NSPredicate(format: "emailAddresses.@count > 0")
        present(contactPicker, animated: true, completion: nil)
    }
    
}

//MARK: - Contact Picker Delegate Methods
extension ContactsViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        let newContacts = contacts.compactMap { Contact(contact: $0) }
        for newContact in newContacts {
            if !self.contacts.contains(newContact) {
                self.contacts.append(newContact)
                
            }
        }
        table.reloadData()
        table.isHidden = false
    }
}

//MARK: - Table Delegate Methods
extension ContactsViewController: UITableViewDelegate {
    
}

//MARK: - Table Data Source Methods
extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "contactCell")
        
        if let cell = cell as? ContactViewCell {
            cell.contact = contacts[indexPath.row]
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93.0
    }
}
