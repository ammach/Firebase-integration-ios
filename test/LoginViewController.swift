//
//  LoginViewController.swift
//  test
//
//  Created by adhoc on 03/10/1437 AH.
//  Copyright © 1437 AH adhoc. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class LoginViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passLabel: UITextField!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var pgb: UIProgressView!
    
    
    
    override func viewDidAppear(animated: Bool) {
        print("appear")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        print("will apear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loaded")
        
        pgb.progress=0
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        img.image=image
    }
    
    @IBAction func pick(sender: AnyObject) {
        
        let image=UIImagePickerController()
        image.delegate=self
        image.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing=false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    @IBAction func signup(sender: AnyObject) {
        
        let rootStorage=FIRStorage.storage().referenceForURL("gs://api-project-641478098498.appspot.com")
        let task=rootStorage.child("\(nameLabel.text)/old.jpg").putData(UIImagePNGRepresentation(img.image!)!, metadata: nil) { (metadata, error) in
            print("good")
        }
        task.observeStatus(.Progress) { (snap:FIRStorageTaskSnapshot) in
            if let progress=snap.progress{
            let percentComplete=100*Double(progress.completedUnitCount)/Double(progress.totalUnitCount)
                self.pgb.progress=Float(percentComplete)
                self.percentLabel.text="\(percentComplete)"
            }
        }
        
    }
            //print(percentComplete)
               // let contentmsg:String=String(format:"%.1f",percentComplete)
             //   let alert=UIAlertController(title: "waiting for sign up", message:"wait for sign up", preferredStyle: .Alert)
               // self.presentViewController(alert, animated: true, completion: nil)
               // self.percentLabel.text="\(percentComplete)"
            
    
    
    @IBAction func signin(sender: AnyObject) {
    }
    
    @IBAction func logout(sender: AnyObject) {
        
        print(FIRAuth.auth()?.currentUser?.email)
        do{
        try FIRAuth.auth()?.signOut()
        }catch{}
        
        if FIRAuth.auth()?.currentUser?.uid==nil {
        
        print("you sign out")
        }
        
        
    }
}
