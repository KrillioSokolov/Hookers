//
//  OrderInfoViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 13.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation
import UIKit

final class OrderInfoViewController: UIViewController {
    
    @IBOutlet private weak var orderButton: UIButton!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var dueDateButton: UIButton!
    
    @IBOutlet weak var peopleCountView: UIView!
    @IBOutlet weak var hookahMasterContainerView: UIView!
    @IBOutlet weak var dueDateContainerView: UIView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var peopleCountLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var hookahMasterLabel: UILabel!
    @IBOutlet weak var hookahBeLabel: UILabel!
    @IBOutlet weak var hookersCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var datePickerHeightConstraint: NSLayoutConstraint!
    
    private var selectedHookahMaster: HookahMaster!
    
    private var dueDate = Date()
    var hookahMasters = HookahMaster.testMasters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateDatePicker()
        configurateCollectionView()
        
        dueDateContainerView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        dueDateContainerView.layer.cornerRadius = 6
        
        peopleCountView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        peopleCountView.layer.cornerRadius = 6
        
        hookahMasterContainerView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        hookahMasterContainerView.layer.cornerRadius = 6
        
        updateDueDateLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let randomMasterIndex = Int(arc4random_uniform(UInt32(hookahMasters.count)))
            
        hookersCollectionView.selectItem(at: IndexPath(row: randomMasterIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        
        selectedHookahMaster = hookahMasters[randomMasterIndex]
        
        updateHookahMasterLabel(name: selectedHookahMaster.name)
    }
    
}

extension OrderInfoViewController {
    
    func updateHookahMasterLabel(name: String) {
        hookahMasterLabel.text = name
    }
    
}

extension OrderInfoViewController {
    
    @IBAction func step(_ sender: UIStepper) {
        peopleCountLabel.text = String(Int(sender.value))
    }
    
}

extension OrderInfoViewController {
    
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
    
    @IBAction func dateChanged(_ datePicker: UIDatePicker) {
        dueDate = datePicker.date
        updateDueDateLabel()
        configurateCollectionViewHeight()
    }
    
    @IBAction func chooseDueDate(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            if self.datePickerHeightConstraint.constant == 0 {
                self.datePickerHeightConstraint.constant = OrderInfoViewController.Constants.dataPickerHeight
                self.datePicker.isHidden = false
            } else {
                self.datePicker.isHidden = true
                self.datePickerHeightConstraint.constant = 0
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}

extension OrderInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func configurateCollectionView() {
        hookersCollectionView.dataSource = self
        hookersCollectionView.delegate = self
        hookersCollectionView.allowsSelection = true
        hookersCollectionView.registerReusableCell(cellType: HookerManCollectionViewCell.self)
        
        collectionViewHeightConstraint.constant = UIScreen.main.bounds.size.height/3 * CollectionViewTransformConstants.scaleFactor
    }
    
    func configurateCollectionViewHeight() {
        if Date.isDateInToday(from: dueDate), collectionViewHeightConstraint.constant == 0 {
            UIView.animate(withDuration: 0.2) {
                self.collectionViewHeightConstraint.constant = UIScreen.main.bounds.size.height/3 * CollectionViewTransformConstants.scaleFactor
                self.view.layoutIfNeeded()
            }
            
            hookahMasterLabel.text = selectedHookahMaster.name
            hookahBeLabel.text = "Вашим кальянщиком будет:".localized()
            hookahBeLabel.textAlignment = .left
        } else if !Date.isDateInToday(from: dueDate) {
            UIView.animate(withDuration: 0.2) {
                self.collectionViewHeightConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
            
            hookahBeLabel.textAlignment = .center
            hookahBeLabel.text = "Извините, на выбранный Вами день расписание кальянщиков не сформировано".localized()
            hookahMasterLabel.text = ""
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hookahMasters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: UIScreen.main.bounds.size.width/2 - 30, height: UIScreen.main.bounds.size.height/3)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath, cellType: HookerManCollectionViewCell.self)
        
        let master = hookahMasters[indexPath.row]
        
        cell.avatarImageView.image = UIImage.init(named: master.photo)
        cell.likeCount.text = String(master.likes)
        cell.nameLabel.text = master.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedHookahMaster = hookahMasters[indexPath.row]
        updateHookahMasterLabel(name: selectedHookahMaster.name)
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
    
}

extension OrderInfoViewController {
    
    struct Constants {
        
        static let dataPickerHeight = CGFloat(120.0)
        
    }
    
}


extension OrderInfoViewController {
    
    func registerKeyboardNotificication() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        
        scrollView.contentInset = contentInset
    }
    
}
