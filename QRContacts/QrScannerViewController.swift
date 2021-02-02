//
//  QrScqnnerViewController.swift
//  lab_3
//
//  Created by Владислав Якубец on 01.12.2020.
//

import UIKit
import AVFoundation

class QrScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                session.addInput(input)
            } catch {
                print("Ошибка")
            }
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        session.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if let data = object.stringValue?.data(using: .utf8) {
                    let contact = try? JSONDecoder().decode(Contact.self, from: data)
                    
                    let contactInfoViewController = storyboard?.instantiateViewController(identifier: "contactInfoViewController") as? ContactInfoViewController
                    contactInfoViewController?.contact = contact
                    present(contactInfoViewController!, animated: true, completion: nil)
                    
                }
            }
        }
    }
}


