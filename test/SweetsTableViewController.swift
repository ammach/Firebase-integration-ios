//
//  SweetsTableViewController.swift
//  test
//
//  Created by adhoc on 28/09/1437 AH.
//  Copyright © 1437 AH adhoc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SweetsTableViewController: UITableViewController {
    
    var dbrefUsers:FIRDatabaseReference!
    var users=[User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        dbrefUsers=FIRDatabase.database().reference().child("users")
        startObservingDb()
    }

    
    
    /*  dbrefUsers.observeEventType(.Value) { (snapshot:FIRDataSnapshot) in
      self.users=[User]()
            
            for user in snapshot.children{
                
                let snap=user as! FIRDataSnapshot
                let name=snap.value!["name"] as! String
                let age=snap.value!["age"] as! String
            self.users.append(User(email: name, age:age))
                self.tableView.reloadData()
            }
            print( (snapshot.childrenCount))
        }*/
        func startObservingDb(){
      dbrefUsers.parent!.child("filieres").child("fifa").observeEventType(.Value) { (snapshot:FIRDataSnapshot) in
            self.users=[User]()
            for id in snapshot.children{
                self.users=[User]()
                let snap=id as! FIRDataSnapshot
                let userid=snap.key
             print(userid)
                self.dbrefUsers.child("\(userid)").observeEventType(.Value, withBlock: { (snapUser:FIRDataSnapshot) in
                    let name=snapUser.value!["name"] as! String
                    let age=snapUser.value!["age"] as! String
                    self.users.append(User(email: name, age:age))
                    self.tableView.reloadData()
                })
                
                }
        
        print( (snapshot.childrenCount))
        }
        }
               /* self.dbrefUsers.child(userid).observeEventType(.Value, withBlock: { (snapUserId:FIRDataSnapshot) in
                    let name=snapUserId.value!["name"] as! String
                    let age=snapUserId.value!["age"] as! String
                    self.users.append(User(email: name, age:age))
                   
                })*/
            
         //self.tableView.reloadData()
        
    
    
    
    
    @IBAction func login(sender: AnyObject) {
        
        
    }
    
    @IBAction func add(sender: AnyObject) {
        
        let alert=UIAlertController(title: "add tweet", message: "please add your tweet", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textfield:UITextField) in
            textfield.placeholder="name"
        }
        alert.addTextFieldWithConfigurationHandler { (agetext:UITextField) in
            agetext.placeholder="age"
        }
        alert.addAction(UIAlertAction(title: "save", style: .Default, handler: { (action:UIAlertAction) in
            print(alert.textFields?.last?.text)
            
            let user=User(uid: (alert.textFields?.first?.text)!, email: (alert.textFields?.first?.text)!,age:(alert.textFields?.last?.text)!)
            let userRef=self.dbrefUsers.childByAutoId()
            userRef.setValue(user.toAnyObject())
            userRef.child("filieres").setValue(["fifa":true])
            let userid=userRef.key
            self.dbrefUsers.parent?.child("filieres").child("fifa").updateChildValues([userid:true])
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        let user=users[indexPath.row]
        cell.textLabel?.text=user.email
        cell.detailTextLabel?.text=user.age as! String
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
