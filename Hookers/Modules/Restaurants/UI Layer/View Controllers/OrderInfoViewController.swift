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
    
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var dueDateLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var peopleCountLabel: UIView!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var hookersCollectionView: UICollectionView!
    
    private var dueDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.minimumDate = Date().addingTimeInterval(-0)
        datePicker.maximumDate = Date().addingTimeInterval(60 * 60 * 24 * 14)
        
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "123456789", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightText])
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Джон Кальяно", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightText])
        
        hookersCollectionView.dataSource = self
        hookersCollectionView.delegate = self
        hookersCollectionView.registerReusableCell(cellType: HookerManCollectionViewCell.self)
        
        updateDueDateLabel()
    }
    
    @IBAction func dateChanged(_ datePicker: UIDatePicker) {
        dueDate = datePicker.date
        updateDueDateLabel()
    }
    
    func updateDueDateLabel() {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ru-RU")
        
        dueDateLabel.text = formatter.string(from: dueDate)
    }
    
}

extension OrderInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath, cellType: HookerManCollectionViewCell.self)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 0.3
    }
    
}
