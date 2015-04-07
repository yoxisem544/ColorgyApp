//
//  FacebookLoginViewController.swift
//  SWTJSQ
//
//  Created by David on 2015/3/7.
//  Copyright (c) 2015年 David. All rights reserved.
//

import UIKit

class FacebookLoginViewController: UIViewController, FBLoginViewDelegate {
    
    var hi: FBProfilePictureView!
    var userId: NSString!
    var profilePhoto: NSString!
//    @IBOutlet var profilePhoto: FBProfilePictureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("view did load")
        
        FBSession.activeSession().closeAndClearTokenInformation()
        
        var loginView = FBLoginView()
        loginView.center = CGPointMake(self.view.center.x, self.view.center.y * 1.5)
        println(self.view.center.y * 1.5)
        loginView.delegate = self
        self.view.addSubview(loginView)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        self.profilePhoto = user.objectID

//        println("/\(self.profilePhoto.profileID)/?fields=feed.limit=(1)")
        
        if user.objectID != "" {
            println("push~")
            self.performSegueWithIdentifier("totableview", sender: self)
        }
        
        FBRequestConnection.startWithGraphPath("//?fields=feed.limit=(1)", completionHandler: { (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            if (result? != nil) {
//                println(connection)
                println("yeah")
                
            } else {
                println("nono")
            }
        })
    }
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        println("HIHI")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "totableview" {
            println("OK pus login")
//            var vc: ViewController = segue.destinationViewController as ViewController
            var cvc: CourseChatRoomSelect = segue.destinationViewController as CourseChatRoomSelect
            cvc.setupUserInfo(self.profilePhoto)
//            vc.performLogin(self.profilePhoto)
//            println(self.profilePhoto)
        }
    }
    
}
