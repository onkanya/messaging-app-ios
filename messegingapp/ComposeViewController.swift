//
//  ComposeViewController.swift
//  messegingapp
//
//  Created by Mac on 14/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var TextView: UITextView!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func AddUser(_ sender: Any) {
        
        // Post the data to firebase
        ref.child("Posts").childByAutoId().setValue(TextView.text)
        
        // Dismiss the popover
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func Cancel(_ sender: Any) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
