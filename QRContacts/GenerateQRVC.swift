//
//  GenerateQRVC.swift
//  lab_3
//
//  Created by Владислав Якубец on 01.12.2020.
//

import UIKit
import ContactsUI

class ContactsVC: UIViewController {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var label: UILabel!
    
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if contacts.count == 0 {
            table.isHidden = true
        }
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        present(contactPicker, animated: true, completion: nil)
    }
    
}

//MARK: - Contact Picker Delegate Methods
extension ContactsVC: CNContactPickerDelegate {
    
}

//MARK: - Table Delegate Methods
extension ContactsVC: UITableViewDelegate {
    
}

//MARK: - Table Data Source Methods
extension ContactsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        if let cell = cell as? ContactVCell {
            cell.contact = contacts[indexPath.row]
        }
        return cell
    }
    
    
}
