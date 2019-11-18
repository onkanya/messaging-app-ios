//
//  ViewController.swift
//  messegingapp
//
//  Created by Mac on 14/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!
    
    var ref:DatabaseReference?

    var databaseHandle:DatabaseHandle?
    
    var postData = [String]()
    
    var postKey = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableView.delegate = self
        TableView.dataSource = self
        
        TableView.allowsMultipleSelectionDuringEditing = true
        
        // Set the firebase reference
        ref = Database.database().reference()
        
        // Retrieve the posts and listen to changes
        databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            // Code to execute when a child is added under "Posts"
            // Take the value from the snapshot and added it to the post data array
            
            // Try to convert the value of the data to a string
            let post = snapshot.value as? String
            let key = snapshot.key
            
            if let actualPost = post {
                
                // Append the data to our postData array
                self.postData.append(actualPost)
                
                // Append the data key to postData array
                self.postKey.append(key)
                
                // Reload the tableview
                self.TableView.reloadData()
                
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            tableView.beginUpdates()
            
            // delete row from tableView
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            // get the key for the selected row
            let postID = postKey[indexPath.row]
            
            // remove the key and value from the array
            postData.remove(at: indexPath.row)
            postKey.remove(at: indexPath.row)
            
            // remove the value from Firebase
            ref?.child("Posts").child("\(postID)").removeValue()
            tableView.endUpdates()
        }
    }
    
}

