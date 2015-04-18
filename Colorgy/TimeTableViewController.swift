//
//  TimeTableViewController.swift
//  WeekTable
//
//  Created by David on 2015/4/16.
//  Copyright (c) 2015年 David. All rights reserved.
//

import UIKit

class TimeTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(self.WeekBarView())
        self.view.addSubview(self.TimeSideBarView())
        self.view.addSubview(self.TimeTableGridView())
    }
    
    func WeekBarView() -> UIView {
        
        var view = UIView(frame: CGRectMake(0.0, 0.0, self.view.frame.width, 64.0))
        view.backgroundColor = UIColor.redColor()
        
        var timeSideBarWidth: CGFloat = 40
        
        // you got 5 days a week
        for day in 0...4 {
            let width = (self.view.frame.width - 40)/5
            var dayOffset = timeSideBarWidth + CGFloat(day)*width
            var dayView = UILabel(frame: CGRectMake(dayOffset, 20, 40, 40))
            dayView.text = "\(day+1)"
            dayView.backgroundColor = UIColor.blueColor()
            dayView.textAlignment = NSTextAlignment.Center
            dayView.layer.cornerRadius = 5
            dayView.layer.masksToBounds = true
            
            view.addSubview(dayView)
        }
        
        return view as UIView
    }
    
    func TimeSideBarView() -> UIView {
        
        var view = UIView(frame: CGRectMake(0.0, 64.0, 40, self.view.frame.height - 64))
        view.backgroundColor = UIColor.grayColor()
        
        // classes in moring NTU got 0 at the very first class
        // fuck cannot use class so i use session here
        for session in 0...8 {
            let height = (self.view.frame.height - 64)/9
            var classOffset = CGFloat(session)
            var sessionLabel = UILabel(frame: CGRectMake(0.0, classOffset*height, 30, 30))
            sessionLabel.text = "\(session)"
            sessionLabel.backgroundColor = UIColor.brownColor()
            sessionLabel.textAlignment = NSTextAlignment.Center
            sessionLabel.layer.cornerRadius = 15
            sessionLabel.layer.masksToBounds = true
            
            view.addSubview(sessionLabel)
        }
        
        return view as UIView
    }
    
    func TimeTableGridView() -> UIView {
        
        var gridViewWidth = self.view.frame.width-40
        var gridViewHeight = self.view.frame.height-64
        
        var gridView = UIView(frame: CGRectMake(40, 64, self.view.frame.width-40, self.view.frame.height-64))
        gridView.backgroundColor = UIColor.purpleColor()
        
        for i in 1...4 {
            let width = gridViewWidth/5
            var offset = CGFloat(i)
            var line = UIView(frame: CGRectMake(width*offset, 0.0, 0.5, gridViewHeight))
            
            line.backgroundColor = UIColor.blackColor()
            
            gridView.addSubview(line)
        }
        
        for i in 0...8 {
            let height = gridViewHeight/9
            var offest = CGFloat(i)
            var line = UIView(frame: CGRectMake(0.0, offest*height, gridViewWidth, 0.5))
            
            line.backgroundColor = UIColor.blackColor()
            
            gridView.addSubview(line)
        }
        
        return gridView as UIView
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
    
//    func addCourseView() -> UIView {
//        
//    }

}
