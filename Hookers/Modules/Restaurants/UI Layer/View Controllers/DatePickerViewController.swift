//
//  DatePickerViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 17.11.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation
import UIKit

final class DatePickerViewController: UIViewController {
    
    var styleguide: DesignStyleGuide!
    var dispatcher: Dispatcher!
    var restaurantStore: RestaurantStore!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cityContainerView: UIView!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var dueDateButton: UIButton!
    @IBOutlet private weak var datePickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var dueDateContainerView: UIView!
    
    private var dueDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dueDateContainerView.layer.cornerRadius = 6
        dueDateContainerView.layer.borderWidth = 1
        
        containerView.addShadowView(radius: 70)
        
        cityContainerView.layer.cornerRadius = 6
        cityContainerView.layer.borderWidth = 1
        
        configurateDatePicker()
        updateDueDateLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
        
        navigationItem.setTitleView(withTitle: "Днепр".localized(),
                                    subtitle: "Выберите день и время".localized(),
                                    titleColor: styleguide.primaryTextColor,
                                    titleFont: styleguide.regularFont(ofSize: 17),
                                    subtitleColor: styleguide.secondaryTextColor,
                                    subtitleFont: styleguide.regularFont(ofSize: 12))
    }
    
    func configurateDatePicker() {
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.minimumDate = Date().addingTimeInterval(-0)
        datePicker.maximumDate = Date().addingTimeInterval(60 * 60 * 24 * 14)
    }
    
    func updateDueDateLabel() {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ru-RU")
        
        let dueDateString = formatter.string(from: dueDate) == formatter.string(from: Date()) ? "Cейчас".localized() : formatter.string(from: dueDate)
        
        let attributeTitle: NSMutableAttributedString =  NSMutableAttributedString(string: dueDateString)
        attributeTitle.addAttribute(NSAttributedStringKey.underlineStyle, value: 1, range: NSMakeRange(0, attributeTitle.length))
        
        dueDateButton.setAttributedTitle(attributeTitle, for: .normal)
    }
    
}

extension DatePickerViewController {
    
    @IBAction func accept(_ sender: Any) {
        restaurantStore.didSelectDueDate(with: dueDate)
        
        let value = RestaurantsEvent.NavigationEvent.DidSelectDueDate.Value(animated: true)
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.DidSelectDueDate.self, result: Result(value: value))
    }
    
    @IBAction func dateChanged(_ datePicker: UIDatePicker) {
        dueDate = datePicker.date
        updateDueDateLabel()
    }
    
    @IBAction func chooseDueDate(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            if self.datePickerHeightConstraint.constant == 0 {
                self.datePickerHeightConstraint.constant = Constants.dataPickerHeight
                self.datePicker.isHidden = false
            } else {
                self.datePicker.isHidden = true
                self.datePickerHeightConstraint.constant = 0
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

}

extension DatePickerViewController {
    
    struct Constants {
        
        static let dataPickerHeight = CGFloat(140.0)
        
    }
    
}

