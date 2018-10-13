//
//  OrderInfoViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 13.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation
import UIKit
import DateTimePicker

final class OrderInfoViewController: UIViewController {
    
    
    @IBOutlet private var dateTimePickerContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        let min = Date().addingTimeInterval(Date.timeIntervalSince(Date()))
        let max = Date().addingTimeInterval(60 * 60 * 24 * 4)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        
        picker.timeInterval = DateTimePicker.MinuteInterval.ten
        picker.frame = CGRect(x: 0, y: 150, width: picker.frame.size.width, height: picker.frame.size.height)
        self.view.addSubview(picker)
    }
    
}
