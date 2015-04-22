//
//  WeekTimeTableViewController.swift
//  WeekTable
//
//  Created by David on 2015/4/18.
//  Copyright (c) 2015年 David. All rights reserved.
//

import UIKit

class WeekTimeTableViewController: UIViewController {
    
    // header bar region
    var headerBarHeight: CGFloat!
    var headerBarWidth: CGFloat!
    var headerBarCellWidth: CGFloat!
    var headerBarCellHeight: CGFloat!
    
    // content container
    var contentContainerViewWidth: CGFloat!
    var contentContainerViewHeight: CGFloat!
    var contentContainerContentWidth: CGFloat!
    var contentContainerContentHeight: CGFloat!
    
    // side bar region
    var sideBarHeight: CGFloat!
    var sideBarWidth: CGFloat!
    var sideBarCellHeight: CGFloat!
    var sideBarCellWidth: CGFloat!
    
    // grid view region
    var gridTimeTableHeight: CGFloat!
    var gridTimeTableWidth: CGFloat!
    var gridLineWidth: CGFloat!
    
    // screen region
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    // course counts?
    var courseCount: Int! = 9
    var courseViewWidth: CGFloat!
    var courseViewHeight: CGFloat!
    var courseViewBound: CGRect!
    var courses: NSMutableArray!
    
    // color region
    var headerBarColor: UIColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.7)
    var headerBarCellColor: UIColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.7)
    var sideBarColor: UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
    var sideBarCellColor: UIColor = UIColor(red: 1.0, green: 1.0, blue: 0.3, alpha: 0.7)
    var girdLineViewColor: UIColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.4)
    var gridLineColor: UIColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.7)
    var courseViewColor: UIColor = UIColor(red: 0.0, green: 0.5, blue: 0.9, alpha: 0.7)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.screenHeight = self.view.frame.height
        self.screenWidth = self.view.frame.width

        // header bar setup
        self.headerBarHeight = 64.0
        self.headerBarWidth = self.screenWidth
        
        // content container setup
        self.contentContainerViewHeight = self.screenHeight - self.headerBarHeight - 49
        self.contentContainerViewWidth = self.headerBarWidth
        
        // side bar setup
        self.sideBarWidth = 40.0
        
        // setup header cell item
        self.headerBarCellHeight = 30.0
        self.headerBarCellWidth = (self.screenWidth - self.sideBarWidth)/5
        
        // setup side bar cell item
        self.sideBarCellHeight = 100
        self.sideBarCellWidth = self.sideBarWidth
        
        // content container content size
        self.contentContainerContentHeight = self.sideBarCellHeight * CGFloat(self.courseCount)
        self.contentContainerContentWidth = self.screenWidth
        
        // after setting up content container size, set sidebar height
        self.sideBarHeight = self.contentContainerContentHeight
        
        // grid view height and width
        self.gridTimeTableWidth = self.screenWidth - self.sideBarWidth
        self.gridTimeTableHeight = self.sideBarHeight
        self.gridLineWidth = 0.5
        
        // course region
        self.courseViewBound = CGRect(x: 0.0, y: 0.0, width: self.headerBarCellWidth, height: self.sideBarCellHeight)
        self.courseViewWidth = self.headerBarCellWidth - 5
        self.courseViewHeight = self.sideBarCellHeight - 5
        
        //back image hee
        var backimg = UIImageView(frame: CGRectMake(0.0, 0.0, self.screenWidth, self.screenHeight))
        backimg.image = UIImage(named: "back2.png")
        self.view.addSubview(backimg)
        
        // init courses to save course and pointer
        courses = NSMutableArray()
        
        // adding views to user
        self.view.addSubview(self.HeaderBarView())
//        self.view.addSubview(self.SideBarView())
//        self.view.addSubview(self.GridLineView())
        self.view.addSubview(self.contentContainerView())
    }
    
    
    func HeaderBarView() -> UIView {
        
        var view = UIView(frame: CGRectMake(0.0, 0.0, self.screenWidth, self.headerBarHeight))
        view.backgroundColor = self.headerBarColor
        
        for day in 0...4 {
            var dayView = UILabel(frame: CGRectMake(0.0, 0.0, self.headerBarCellWidth*0.7, self.headerBarCellHeight))
            dayView.text = "\(day+1)"
            dayView.textColor = UIColor.whiteColor()
            dayView.backgroundColor = self.headerBarCellColor
            dayView.textAlignment = NSTextAlignment.Center
            dayView.layer.cornerRadius = self.headerBarCellHeight/2
            // let label can fit inside the mask
            dayView.layer.masksToBounds = true
            
            
            // position of x in every day
            var x = self.sideBarWidth + CGFloat(day)*self.headerBarCellWidth + self.headerBarCellWidth/2
            dayView.center = CGPointMake(x, self.headerBarHeight/2+10)
            
            view.addSubview(dayView)
        }
        
        return view as UIView
    }
    
    func contentContainerView() -> UIScrollView {
        
        var view = UIScrollView(frame: CGRectMake(0.0, self.headerBarHeight, self.contentContainerViewWidth, self.contentContainerViewHeight))
        view.contentSize = CGSizeMake(self.contentContainerContentWidth, self.contentContainerContentHeight)
        
        view.addSubview(self.SideBarView())
        view.addSubview(self.GridLineView())
        
        return view as UIScrollView
    }
    
    func SideBarView() -> UIView {
        
        var view = UIView(frame: CGRectMake(0.0, 0.0, self.sideBarWidth, self.sideBarHeight))
        view.backgroundColor = self.sideBarColor
        
        // classes in moring NTU got 0 at the very first class
        // fuck cannot use class so i use session here
        for session in 0...(self.courseCount - 1) {
            var sessionLabel = UILabel(frame: CGRectMake(0.0, 0.0, self.sideBarCellWidth, self.sideBarCellWidth))
            sessionLabel.text = "\(session)"
            sessionLabel.backgroundColor = self.sideBarCellColor
            sessionLabel.textAlignment = NSTextAlignment.Center
            sessionLabel.layer.cornerRadius = 15
            sessionLabel.layer.masksToBounds = true
            
            
            var y = CGFloat(session)*self.sideBarCellHeight + self.sideBarCellHeight/2
            sessionLabel.center = CGPointMake(self.sideBarCellWidth/2, y)
            println("\(session)")
            
            view.addSubview(sessionLabel)
        }
        
        return view as UIView
    }
    
    func GridLineView() -> UIView {
        
        var view = UIView(frame: CGRectMake(self.sideBarWidth, 0.0, self.gridTimeTableWidth, self.gridTimeTableHeight))
        view.backgroundColor = self.girdLineViewColor
        
        for day in 1...4 {
            var line = UIView(frame: CGRectMake(0.0, 0.0, self.gridLineWidth, self.gridTimeTableHeight))
            line.backgroundColor = self.gridLineColor
            line.center.x = CGFloat(day)*self.headerBarCellWidth
            
            view.addSubview(line)
        }
        
        for sessionLine in 1...self.courseCount {
            var line = UIView(frame: CGRectMake(0.0, 0.0, self.gridTimeTableWidth, self.gridLineWidth))
            line.backgroundColor = self.gridLineColor
            line.center.y = CGFloat(sessionLine)*self.sideBarCellHeight
            
            view.addSubview(line)
        }
        
        view.addSubview(self.addCourseView(1, session: 0))
        for i in 0...8 {
            var day = Int(arc4random()%5) + 1
            var session = Int(arc4random()%8)
            view.addSubview(self.addCourseView(day, session: session))
        }
        
        return view as UIView
    }
    
    func addCourseView(day: Int, session: Int, Title: NSString) -> UIView {
        var view = UIView(frame: CGRectMake(0.0, 0.0, 10, 10))
        
        return view as UIView
    }
    
    func addCourseView(day: Int, session: Int) -> UIView {
        var view = UIView(frame: CGRectMake(0.0, 0.0, self.courseViewWidth, self.courseViewHeight))
        view.backgroundColor = self.courseViewColor
        view.layer.cornerRadius = 10
        
        var x = CGFloat(day)*self.courseViewBound.width - self.courseViewBound.width/2-0.5
        var y = CGFloat(session)*self.courseViewBound.height + self.courseViewBound.height/2+0.5
        
        view.center = CGPointMake(x, y)
        
        var button = UIButton(frame: CGRectMake(0.0, 0.0, self.courseViewWidth, self.courseViewHeight))
        button.setTitle("\(day) and \(session)", forState: UIControlState.Normal)
        button.addTarget(self, action: "didTapOnCourse:", forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(button)
        
        // saving courses to a array
        // must send button itself or it can't get the right view
        self.courses.addObject([day, session, button, view])
        
        return view as UIView
    }
    
    func didTapOnCourse(sender: AnyObject) {
//        println(sender)
        
        for name in self.courses {
            if name[2].isEqual(sender) {
                println(name)
                println("\(name[0]) and \(name[1])")
//                performSegueWithIdentifier("showCourseDetail", sender: self)
                let view = name[3] as! UIView
                var scale = CGAffineTransformMakeScale(1.5, 1.5)
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: {
                        view.transform = scale
                    }, completion: nil)
                
                UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: {
                        scale = CGAffineTransformMakeScale(1, 1)
                        view.transform = scale
                    }, completion: nil)
                
                break
            }
        }
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
