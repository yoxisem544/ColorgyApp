//
//  CalendarViewController.swift
//  Colorgy
//
//  Created by David on 2015/4/8.
//  Copyright (c) 2015年 David. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    var calendarView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendarView = UIScrollView(frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height))
        self.calendarView.backgroundColor = UIColor.redColor()
        
        self.calendarView.contentSize = CGSizeMake(self.calendarView.frame.width*5, self.calendarView.frame.height)
        var view = UIView(frame: CGRectMake(10.0, 10.0, 50, 50))
        view.backgroundColor = UIColor.blueColor()
        
        
        self.view.addSubview(self.calendarView)
        self.view.addSubview(view)
    }
}
