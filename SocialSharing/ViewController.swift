//
//  ViewController.swift
//  SocialSharing
//
//  Created by Henry Aguinaga on 2017-01-27.
//  Copyright © 2017 Henry Aguinaga. All rights reserved.
//

import UIKit
import Social
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    @IBAction func postToFacebook(_ sender: Any) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
        
            let facebookSheet: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            facebookSheet.setInitialText(label.text)
            facebookSheet.add(imageView.image)
            
            self.present(facebookSheet, animated: true, completion: nil)
            
            
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please log in to your facebook account in the device settings", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func postToTwitter(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            
            let twitterSheet: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText(label.text)
            twitterSheet.add(imageView.image)
            
            self.present(twitterSheet, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please log in to your facebook account in the device settings", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }

    }
    
    @IBAction func email(_ sender: Any) {
        
        if MFMailComposeViewController.canSendMail() {
        
            let mailSheet: MFMailComposeViewController = MFMailComposeViewController()
            
            mailSheet.mailComposeDelegate = self
            mailSheet.setToRecipients(["abc@123.com"])
            mailSheet.setSubject("App Name")
            mailSheet.setMessageBody(label.text!, isHTML: false)
            
            let image = imageView.image
            let imageData = UIImageJPEGRepresentation(image!, 1.0)
            
            mailSheet.addAttachmentData(imageData!, mimeType: "image/jpg", fileName: "image.jpg")
            
            self.present(mailSheet, animated: true, completion: nil)
            
            
        }
        else {
            
            let alert = UIAlertController(title: "Account", message: "Please log in to your email account", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func sms(_ sender: Any) {
        
        if MFMessageComposeViewController.canSendText() {
            let messageSheet: MFMessageComposeViewController = MFMessageComposeViewController()
            messageSheet.messageComposeDelegate = self
            messageSheet.recipients = ["1234567"]
            messageSheet.body = label.text
            
            let image = imageView.image
            let imageData = UIImageJPEGRepresentation(image!, 1.0)
            
            messageSheet.addAttachmentData(imageData!, typeIdentifier: "image/jpg", filename: "image.jpg")
            
            self.present(messageSheet, animated: true, completion: nil)
            
        } else {
        
            let alert = UIAlertController(title: "Warning", message: "Device can't send SMS", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            present(alert, animated: true, completion: nil)
            
            
        }
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
    
        


