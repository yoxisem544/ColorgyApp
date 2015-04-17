//
//  ViewController.swift
//  SWTJSQ
//
//  Created by David on 2015/3/6.
//  Copyright (c) 2015年 David. All rights reserved.
//

import UIKit

class ViewController: JSQMessagesViewController {
    
    var messages = [Message]()
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    var incomingAvatar: JSQMessagesAvatarImage!
    var outgoingAvatar: JSQMessagesAvatarImage!
    
    var messageRef: Firebase!
    
    var userNickName: String!
    var userAvatarUrl: String!
    var avatars = Dictionary<String, JSQMessagesAvatarImage>()
    
    // anonymous region
    var isAnony: String!
    var anonyAvatar: String!
    var userAnonymousName: String!
    
    // unknown message setting
    var batchMessages = true
    
    // login section
    var loginUserName: NSString!
    func performLogin(id: NSString) {
        println("perform for logining in FB")
        println("fuck")
        println(id)
        self.loginUserName = id
    }
    
    var fireBaseUrl: NSString!
    func setupFireBaseLinkUrl(url: NSString, userId: NSString) {
        println("hit setting up")
        self.fireBaseUrl = url
        self.loginUserName = userId
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
//        FBSession.activeSession().closeAndClearTokenInformation()
    }
    
    func setupFirebase() {
        //        messageRef = Firebase(url: "https://colorgy-chat.firebaseio.com/messages")
        messageRef = Firebase(url: "https://colorgy-chat.firebaseio.com/\(self.fireBaseUrl)")
        
        
        messageRef.queryLimitedToLast(100).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) in
            let text = snapshot.value["text"] as? String
            let senderId = snapshot.value["senderId"] as? String
            let senderDisplayName = snapshot.value["senderDisplayName"] as? String
            let avatarImageUrl = snapshot.value["avatarImageUrl"] as? String
            let isMediaMessage = snapshot.value["isMediaMessage"] as? String
            let mediaDataUrl = snapshot.value["mediaDataUrl"] as? String
            let isAnony = snapshot.value["isAnony"] as? String
            let anonyAvatar = snapshot.value["anonyAvatar"] as? String
            let senderAnonymousName = snapshot.value["senderAnonymousName"] as? String
            
            if isMediaMessage == "true" {
                
            } else if isMediaMessage == "false" {
                //                var message: Message = Message(isMediaMessage: isMediaMessage, text: text, senderId: senderId, senderDisplayName: senderDisplayName, avatarImageUrl: avatarImageUrl, mediaDataUrl: mediaDataUrl)
                var message: Message = Message(isMediaMessage: isMediaMessage, text: text, senderId: senderId, senderDisplayName: senderDisplayName, avatarImageUrl: avatarImageUrl, mediaDataUrl: mediaDataUrl, isAnony: isAnony, anonyAvatar: anonyAvatar, senderAnonymousName: senderAnonymousName)
                self.messages.append(message)
            } else {
                
            }
            
            self.finishReceivingMessage()
        })
    }
    
    func sendMessage(text: String!, senderId: String!) {
        messageRef.childByAutoId().setValue([
            "text": text,
            "senderId": senderId,
            "senderDisplayName": self.userNickName,
            "avatarImageUrl": self.userAvatarUrl,
            "isMediaMessage": "false",
            "mediaDataUrl": "",
            "isAnony": self.isAnony,
            "anonyAvatar": self.isAnony == "true" ? "ano.png" : "",
            "senderAnonymousName": self.userAnonymousName
            ])
    }
    
    func setupAvatarImage(name: String, avatarImageUrl: String?, incoming: Bool, isAnony: String?, anonyAvatar: String?) {
        if isAnony == "false" {
            if let stringUrl = avatarImageUrl {
                if let url = NSURL(string: stringUrl) {
                    if let data = NSData(contentsOfURL: url) {
                        let avatarImage = UIImage(data: data)
                        let diameter = incoming ? UInt(collectionView.collectionViewLayout.incomingAvatarViewSize.width) : UInt(collectionView.collectionViewLayout.outgoingAvatarViewSize.width)
                        // got question here
                        let avatarImageKey = JSQMessagesAvatarImageFactory.avatarImageWithImage(avatarImage, diameter: 64)
                        avatars[name] = avatarImageKey
                        return
                    }
                }
            }
            
            setupAvatarColor(name, incoming: incoming)
            
        } else {
            setupAnonymousAvatar(name, anonyAvatar: anonyAvatar!, incoming: incoming)
        }
    }
    
    func setupAnonymousAvatar(name: String, anonyAvatar: String, incoming: Bool) {
        let diameter = incoming ? UInt(collectionView.collectionViewLayout.incomingAvatarViewSize.width) : UInt(collectionView.collectionViewLayout.outgoingAvatarViewSize.width)
        let avatarImageKey = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: anonyAvatar), diameter: 64)
        avatars[name] = avatarImageKey
    }
    
    func setupAvatarColor(name: String, incoming: Bool) {
        let diameter = incoming ? UInt(collectionView.collectionViewLayout.incomingAvatarViewSize.width) : UInt(collectionView.collectionViewLayout.outgoingAvatarViewSize.width)
        
        let rgbValue = name.hash
        let r = CGFloat(Float((rgbValue & 0xFF0000) >> 16)/255.0)
        let g = CGFloat(Float((rgbValue & 0xFF00) >> 8)/255.0)
        let b = CGFloat(Float(rgbValue & 0xFF)/255.0)
        let color = UIColor(red: r, green: g, blue: b, alpha: 0.5)
        
        let nameLength = count(name)
        let initials: String? = name.substringFromIndex(advance(senderId.startIndex, min(3, nameLength)))
        let userImage = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials(initials, backgroundColor: color, textColor: UIColor.blackColor(), font: UIFont.systemFontOfSize(13), diameter: diameter)
        
        avatars[name] = userImage
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // change user name, now displaying senderid only
        //unknown setups
        automaticallyScrollsToMostRecentMessage = true
        
        // user infos
        //        self.senderId = "DavidLIN"
        println(self.loginUserName)
        self.senderId = self.loginUserName as String
        self.senderDisplayName = "David Lin"
        
        // setup messages
        // already setup
        
        // firebase testing region
        // yoxisem544 profile picture
        self.userAvatarUrl = "https://graph.facebook.com/\(self.senderId)/picture?width=64&height=64"
        // chuan
        //        self.userAvatarUrl = "https://graph.facebook.com/100000329912167/picture?width=64&height=64"
        self.userNickName = "HEYYO!"
        
        //        var bubble = JSQMessagesBubbleImageFactory()
        //        self.incomingBubble = bubble.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        //        self.outgoingBubble = bubble.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
        
        //        var avatar: JSQMessagesAvatarImageFactory!
        //        self.incomingAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "1.png"), diameter: 64)
        //        var img = UIImage(data: NSData(contentsOfURL: NSURL(string: self.userAvatarUrl)!)!)
        //        self.outgoingAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(img, diameter: 64)
        
        // firebase testing region
        senderId = (senderId != nil) ? senderId : "Anonymous"
        //        setupAvatarImage(self.userNickName, avatarImageUrl: self.userAvatarUrl, incoming: false)
        self.anonyAvatar = "ano.png"
        self.isAnony = "true"
        self.userAnonymousName = "Nick Tiger"
        setupAvatarImage(self.userNickName, avatarImageUrl: self.userAvatarUrl, incoming: false, isAnony: self.isAnony, anonyAvatar: self.anonyAvatar)
        
        self.setupFirebase()
        self.navigationItem.title = self.fireBaseUrl as String
        
        //setup contextsheet
        //        self.autoRecieveMessage()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.collectionViewLayout.springinessEnabled = true
    }
    
    
    override func didPressAccessoryButton(sender: UIButton!) {
        println("Hi acc!")
        println(avatars)
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        // set send sound
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        //         這樣好像可以SETUP media item!!
        // setup text message
        //        var message: JSQMessage = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        //        var media: JSQMessageMediaData = JSQPhotoMediaItem(image: UIImage(named: "1.png"))
        //        var message: JSQMessage = JSQMessage(senderId: senderId, displayName: senderDisplayName, media: media)
        self.sendMessage(text, senderId: senderId)
        //        self.messages.addObject(message)
        self.finishSendingMessage()
    }
    
    // set outgoing message
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        if messages[indexPath.item].isMediaMessage() == "true" {
            var media = JSQPhotoMediaItem(image: UIImage(named: "1.png"))
            var message = JSQMessage(senderId: messages[indexPath.item].senderId(), displayName: messages[indexPath.item].senderDisplayName(), media: media)
            return message as JSQMessageData
        } else {
            if messages[indexPath.item].isAnony() == "true" {
                var message = JSQMessage(senderId: messages[indexPath.item].senderId(), displayName: messages[indexPath.item].senderAnonymousName(), text: messages[indexPath.item].text())
                return message as JSQMessageData
            } else {
                var message = JSQMessage(senderId: messages[indexPath.item].senderId(), displayName: messages[indexPath.item].senderDisplayName(), text: messages[indexPath.item].text())
                return message as JSQMessageData
            }
        }
    }
    
    // set bubble image
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        //        var message: JSQMessage = self.messages[indexPath.item] as JSQMessage
        var bubble = JSQMessagesBubbleImageFactory()
        if messages[indexPath.item].senderId() == self.senderId {
            return bubble.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        }
        return bubble.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    }
    
    // set avatar image
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message: Message = messages[indexPath.item]
        if let avatar = avatars[message.senderId()] {
            if message.isAnony() == "true" {
                setupAvatarImage(message.senderAnonymousName(), avatarImageUrl: message.avatarImageUrl(), incoming: false, isAnony: "true", anonyAvatar: "ano.png")
                return avatars[message.senderAnonymousName()]
            }
            return avatar
        } else {
            if message.isAnony() == "true" {
                setupAvatarImage(message.senderAnonymousName(), avatarImageUrl: message.avatarImageUrl(), incoming: true, isAnony: "true", anonyAvatar: "ano.png")
                return avatars[message.senderAnonymousName()]
            }
            //            setupAvatarImage(message.senderId(), avatarImageUrl: message.avatarImageUrl(), incoming: true)
            setupAvatarImage(message.senderId(), avatarImageUrl: message.avatarImageUrl(), incoming: true, isAnony: "false", anonyAvatar: "ano.png")
            return avatars[message.senderId()]
        }
        //        return self.incomingAvatar
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        if message.senderId() == senderId {
            cell.textView.textColor = UIColor.blackColor()
        } else {
            cell.textView.textColor = UIColor.whiteColor()
        }
        
        let attributes: [NSObject:AnyObject] = [NSForegroundColorAttributeName:cell.textView.textColor, NSUnderlineStyleAttributeName: 1]
        cell.textView.linkTextAttributes = attributes
        
        return cell
    }
    
    // name above bubble
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.item]
        println("hi")
        // sent by self, skip
        if message.senderId() == self.senderId {
            return nil
        }
        
        // same as previous sender, skip
        if indexPath.item > 0 {
            let previousMessage = messages[indexPath.item - 1]
            if previousMessage.senderId() == message.senderId() {
                // check if anonied, if not its still same, no need to change
                if previousMessage.isAnony() == message.isAnony() {
                    return nil
                }
            }
        }
        
        println("sender is \(message.senderId())")
        return NSAttributedString(string: message.senderId())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        let message = messages[indexPath.item]
        
        if message.senderId() == self.senderId {
            return CGFloat(0.0)
        }
        
        if indexPath.item > 0 {
            let previousMessage = messages[indexPath.item - 1]
            if previousMessage.senderId() == message.senderId() {
                // check if anonied, if not its still same, no need to change
                if previousMessage.isAnony() == message.isAnony() {
                    //                    return kJSQMessagesCollectionViewCellLabelHeightDefault
                    return CGFloat(0.0)
                }
            }
        }
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
    // determine counts of message
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    //    func autoRecieveMessage() {
    //        NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: "sendSomeMessage", userInfo: nil, repeats: true)
    //    }
    //
    //    func sendSomeMessage() {
    //        var message: JSQMessage = JSQMessage(senderId: "user2", displayName: "I am user 2", text: "auto sent!")
    //        self.messages.addObject(message)
    //        self.finishReceivingMessage()
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAtIndexPath indexPath: NSIndexPath!) {
        println("on \(indexPath.item)")
    }
    
}

