//
//  ServiceTabViewController.swift
//  
//
//  Created by David on 2015/4/15.
//
//

import UIKit

class ServiceTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = true
        
        var timetable = self.tabBar.items![0] as! UITabBarItem
        timetable.image = UIImage(named: "timetable")
        timetable.selectedImage = UIImage(named: "timetable")
        timetable.title = "Timetable"
        
        var chat = self.tabBar.items![1] as! UITabBarItem
        chat.image = UIImage(named: "chat")
        chat.selectedImage = UIImage(named: "chat")
        chat.title = "Chat"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
