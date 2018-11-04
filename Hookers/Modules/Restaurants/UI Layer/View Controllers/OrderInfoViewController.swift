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
    @IBOutlet private weak var datePickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var dueDateContainerView: UIView!
    
    @IBOutlet private weak var peopleCountView: UIView!
    @IBOutlet private weak var peopleCountLabel: UILabel!
    @IBOutlet private weak var stepper: UIStepper!
    @IBOutlet private weak var peopleCountContainerView: UIView!
    @IBOutlet private weak var commentTextView: UITextView!
    
    @IBOutlet private weak var hookahMasterContainerView: UIView!
    @IBOutlet private weak var hookahMasterLabel: UILabel!
    @IBOutlet private weak var hookahBeLabel: UILabel!
    @IBOutlet private weak var hookersCollectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var yourOrderContainer: UIView!
    @IBOutlet private weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var orderItemsTableView: UITableView!
    
    private var orderItemsTableViewService: OrderItemsTableViewService!
    private var hookahMastersCollectionViewService: HookahMastersCollectionViewService!
    
    private var dueDate = Date()
    private var hookahMasters: [HookahMaster] = []
    
    var mixesForOrder: [HookahMix]!
    var restaurant: NetworkRestaurant!
    var dispatcher: Dispatcher!
    var styleguide: DesignStyleGuide!
    var restaurantStore: RestaurantStore! {
        didSet {
            restaurantStore.addDataStateListener(self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateCollectionView()
        configurateTableView()
    
        navigationItem.addBackButton(with: self, action: #selector(back), tintColor: styleguide.primaryColor)
    
        restaurantStore.getHookahMastersList(restaurantId: restaurant.restaurantId)
        configurateDatePicker()
        
        commentTextView.text = "Коментарий к заказу"
        commentTextView.textColor = styleguide.secondaryTextColor
        
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
        
        navigationItem.setTitleView(withTitle: restaurant.name,
                                    subtitle: "Заполните информацию о заказе".localized(),
                                    titleColor: styleguide.primaryTextColor,
                                    titleFont: styleguide.regularFont(ofSize: 17),
                                    subtitleColor: styleguide.secondaryTextColor,
                                    subtitleFont: styleguide.regularFont(ofSize: 12))
        
        dueDateContainerView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        dueDateContainerView.layer.cornerRadius = 6
        
        peopleCountContainerView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        peopleCountContainerView.layer.cornerRadius = 6
        
        hookahMasterContainerView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        hookahMasterContainerView.layer.cornerRadius = 6
        
        yourOrderContainer.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        yourOrderContainer.layer.cornerRadius = 6
        
        updateDueDateLabel()
    }
    
}

extension OrderInfoViewController {
    
    private func updateHookahMasterLabel(name: String?) {
        hookahMasterLabel.text = name
    }
    
    private func selectRandomHookahMaster() {
        let randomMasterIndex = Int(arc4random_uniform(UInt32(hookahMastersCollectionViewService.hookahMasters.count)))
        
        hookersCollectionView.selectItem(at: IndexPath(row: randomMasterIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        
        hookahMastersCollectionViewService.selectedHookahMaster = hookahMastersCollectionViewService.hookahMasters[randomMasterIndex]
        
        updateHookahMasterLabel(name: hookahMastersCollectionViewService.selectedHookahMaster?.name)
    }
    
    @objc private func back() {
        let value = RestaurantsEvent.NavigationEvent.CloseScreen.Value(animated: true)
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.CloseScreen.self, result: Result(value: value))
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

extension OrderInfoViewController {
    
    private func configurateTableView() {
        tableViewHeightConstraint.constant = CGFloat(mixesForOrder.count) * OrderItemsTableViewService.Constants.cellHeight - 1
        
        orderItemsTableViewService = OrderItemsTableViewService(tableView: orderItemsTableView)
        orderItemsTableViewService.orderedMixes = mixesForOrder
        orderItemsTableViewService.configurate(with: self)
        orderItemsTableView?.isUserInteractionEnabled = false
    }
    
    private func configurateCollectionView() {
        hookahMastersCollectionViewService = HookahMastersCollectionViewService(collectionView: hookersCollectionView)
        
        collectionViewHeightConstraint.constant = UIScreen.main.bounds.size.height/3 * CollectionViewTransformConstants.scaleFactor
        
        hookahMastersCollectionViewService.configurate(with: self)
    }
    
    private func configurateCollectionViewHeight() {
        if Date.isDateInToday(from: dueDate), collectionViewHeightConstraint.constant == 0 {
            UIView.animate(withDuration: 0.2) {
                self.collectionViewHeightConstraint.constant = UIScreen.main.bounds.size.height/3 * CollectionViewTransformConstants.scaleFactor
                self.view.layoutIfNeeded()
            }
            selectRandomHookahMaster()
            hookahMasterLabel.text = hookahMastersCollectionViewService.selectedHookahMaster?.name
            hookahBeLabel.text = "Вашим кальянщиком будет:".localized()
            hookahBeLabel.textAlignment = .left
            
        } else if !Date.isDateInToday(from: dueDate) {
            UIView.animate(withDuration: 0.2) {
                self.collectionViewHeightConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
            hookahMastersCollectionViewService.selectedHookahMaster = nil
            hookahBeLabel.textAlignment = .center
            hookahBeLabel.text = "Извините, на выбранный Вами день расписание кальянщиков не сформировано".localized()
            hookahMasterLabel.text = nil
        }
    }
    
}

extension OrderInfoViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if commentTextView.textColor == styleguide.secondaryTextColor {
            commentTextView.text = nil
            commentTextView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextView.text.isEmpty {
            commentTextView.text = "Коментарий к заказу"
            commentTextView.textColor = styleguide.secondaryTextColor
        }
    }
    
}

extension OrderInfoViewController: DataStateListening {
    
    func domainModel(_ model: DomainModel, didChangeDataStateOf change: DataStateChange) {
        DispatchQueue.updateUI {
            self.domainModelChanged(model, didChangeDataStateOf: change)
        }
    }
    
    private func domainModelChanged(_ model: DomainModel, didChangeDataStateOf change: DataStateChange) {
        if let change = change as? RestaurantStoreStateChange {
            restaurantStoreStateChange(change: change)
        }
    }
    
    private func restaurantStoreStateChange(change: RestaurantStoreStateChange) {
        if change.contains(.isLoadingState) {
            restaurantStore.isLoading ? showSpinner() : hideSpinner()
            
            //KS: TODO: Show/hide skeleton
            //restaurantStore.isLoading ? addSkeletonViewController() : hideSkeletonViewController()
        }
        
        if change.contains(.hookahMastersForRestaurant) {
            
            guard let hookahMasters = restaurantStore.hookahMastersData?.hookahMasters else { return }
            
            hookahMastersCollectionViewService.updateHookahMasters(hookahMasters: hookahMasters)
            
            DispatchQueue.delay(delay: 0.1) {
                self.selectRandomHookahMaster()
            }
        }
    }
    
}

extension OrderInfoViewController: OrderItemsServiceDelegate {
    
    func orderItemsServiceDidDeleteItem(_ service: OrderItemsTableViewService, deletedItem item: HookahMix) {
        
    }
    
}

extension OrderInfoViewController: HookahMastersServiceDelegate {
    
    func serviceDidChoseHookahMaster(_ service: HookahMastersCollectionViewService, chosenHookahMaster hookahMaster: HookahMaster) {
        updateHookahMasterLabel(name: hookahMaster.name)
    }
    
}

extension OrderInfoViewController {
    
    struct Constants {
        
        static let dataPickerHeight = CGFloat(120.0)
        
    }
    
}
