//
//  FBLoginViewController.swift
//  Colorgy
//
//  Created by David on 2015/4/7.
//  Copyright (c) 2015年 David. All rights reserved.
//

import UIKit

class FBLoginViewController: UIViewController, FBLoginViewDelegate {
    
    var userId: NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("fb log view did load")
        
        var loginview = FBLoginView()
        loginview.center = CGPointMake(self.view.center.x, self.view.center.y)
        self.view.addSubview(loginview)
        
        if FBSession.activeSession().isOpen {
            FBRequest.requestForMe().startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
                
                var resultDic = result as NSDictionary
                println("OK get! \(resultDic)")
                println(resultDic["id"]!)
                self.userId = resultDic["id"]! as NSString
                self.performSegueWithIdentifier("toChatSelect", sender: self)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toChatSelect" {
            var desView = segue.destinationViewController as ChatRoomViewController
            desView.setupUserInfo(self.userId)
            println("push, setup login info")
        }
    }
}
