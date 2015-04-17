//
//  CalendarViewController.swift
//  Colorgy
//
//  Created by David on 2015/4/8.
//  Copyright (c) 2015年 David. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UIScrollViewDelegate {
    
    var calendarView: UIScrollView!
    
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var columnWidht: CGFloat!
    var columnHeight: CGFloat!
    var cellWidth: CGFloat!
    var cellHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("calendar view did load")
        
        screenWidth = self.view.frame.width
        screenHeight = self.view.frame.height
        
        cellWidth = screenWidth
        cellHeight = screenHeight*3
        
        calendarView = UIScrollView(frame: CGRectMake(0.0, 0.0, screenWidth, screenHeight))
        calendarView.contentSize = CGSizeMake(screenWidth*7, screenHeight)
        calendarView.pagingEnabled = true
        
        for i in 0...6 {
            var position = CGFloat(i)*screenWidth
            var view = UIScrollView(frame: CGRectMake(position, 0.0, screenWidth, screenHeight))
            view.contentSize = CGSizeMake(cellWidth, cellHeight)
            view.backgroundColor = UIColor(red: CGFloat(Double(arc4random()%255)/255.0), green: CGFloat(Double(arc4random()%255)/255.0), blue: CGFloat(Double(arc4random()%255)/255.0), alpha: CGFloat(0.5))
            view.decelerationRate = 0.0
            
            self.calendarView.addSubview(view)
        }
        
        self.view.addSubview(self.calendarView)
    }
}
