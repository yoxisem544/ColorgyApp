//
//  CourseChatRoomSelect.swift
//  SWTJSQ
//
//  Created by David on 2015/3/12.
//  Copyright (c) 2015年 David. All rights reserved.
//

import UIKit

class CourseChatRoomSelect: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableview: UITableView!
    
    var chatRoomList: NSMutableArray!
    var userId: String!
    var chatRoom: NSString!
    
    func setupChatRoom() {
        self.chatRoomList = NSMutableArray()
        
        // list here
        self.chatRoomList.addObject("Physics")
        self.chatRoomList.addObject("Calculas")
        self.chatRoomList.addObject("Linear Algerba")
        self.chatRoomList.addObject("Digital Design")
        self.chatRoomList.addObject("Economics")
        self.chatRoomList.addObject("System and Control")
        self.chatRoomList.addObject("C: How to Program")
        self.chatRoomList.addObject("Chemistry")
    }
    
    func setupUserInfo(name: String) {
        println("user id \(name)")
        self.userId = name
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.title = "hihi"
        self.navigationItem.hidesBackButton = true
        
        // right bar item
        var rightB: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "rightBarItemClicked")
        self.navigationItem.rightBarButtonItem = rightB
        
        var doubletap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleDoubleTap:")
        doubletap.delaysTouchesBegan = true
        doubletap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubletap)
        self.tableview.addGestureRecognizer(doubletap)
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        self.setupChatRoom()
    }
    
    func rightBarItemClicked() {
        println("hi right")
    }
    
    func handleDoubleTap(gesture: UIGestureRecognizer) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.text = chatRoomList[indexPath.item] as? String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("select on \(indexPath.item)")
        self.chatRoom = chatRoomList[indexPath.item] as? NSString
        performSegueWithIdentifier("goChatRoom", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goChatRoom" {
            var vc: ViewController = segue.destinationViewController as ViewController
            vc.setupFireBaseLinkUrl(self.chatRoom, userId: self.userId)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatRoomList.count
    }
}
