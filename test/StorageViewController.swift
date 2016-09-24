//
//  StorageViewController.swift
//  test
//
//  Created by adhoc on 28/09/1437 AH.
//  Copyright © 1437 AH adhoc. All rights reserved.
//


import UIKit
import FirebaseStorage
import FirebaseAuth

class StorageViewController: UIViewController {

    @IBOutlet weak var imgUpload: UIImageView!
   
    @IBOutlet weak var imgDownload: UIImageView!
    
    var url=String()
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder:  aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func upload(sender: AnyObject) {
        
        let root=FIRStorage.storage().referenceForURL("gs://api-project-641478098498.appspot.com")
        let storageId=root.child((FIRAuth.auth()?.currentUser?.uid)!+"/real2.png")
      
        storageId.putData(UIImagePNGRepresentation(imgUpload.image!)!, metadata: nil) { (metadata:FIRStorageMetadata?, error:NSError?) in
            if error==nil {
             print(metadata?.downloadURL()?.absoluteString)
                self.url=(metadata?.downloadURL()?.absoluteString)!
            }
            else{
            print(error?.description)
            }
        }
    }
    
    @IBAction func download(sender: AnyObject) {
       let url=NSURL(string: self.url)
        let task=NSURLSession.sharedSession().dataTaskWithURL(url!) { (data:NSData?, response:NSURLResponse?, error:NSError?) in
            
            if let contentimg=data {
            
            self.imgDownload.image=UIImage(data: contentimg)
            }
        }
        task.resume()
    }

}
