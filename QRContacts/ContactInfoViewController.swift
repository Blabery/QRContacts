//
//  ContactInfoViewController.swift
//  lab_3
//
//  Created by Владислав Якубец on 01.12.2020.
//

import UIKit

class ContactInfoViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!
    
    var contact: Contact?
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if contact == nil {
            nameLabel.text = ""
            lastNameLabel.text = ""
            phoneLabel.text = ""
            emailLabel.text = ""
            qrImageView.image = UIImage()
            return
        }
        
        nameLabel.text = contact?.firstName
        lastNameLabel.text = contact?.lastName
        phoneLabel.text = contact?.phoneNumber
        emailLabel.text = contact?.email
        qrImageView.image = UIImage()
        qrImageView.layer.shouldRasterize = true
        
        if let encodeData = try? JSONEncoder().encode(contact) {
            if let stringData = String(data: encodeData, encoding: .utf8) {
                
                qrImageView.image = generateQRImage(from: stringData)
            }
        }
    }
    
    func generateQRImage(from string: String) -> UIImage {
        let data = string.data(using: .utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let qrCodeImage = filter.outputImage?.transformed(by: CGAffineTransform(scaleX: 3.0, y: 3.0)) {
            if let qrCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCGImage)
            }
        }
        return UIImage()
    }
}
