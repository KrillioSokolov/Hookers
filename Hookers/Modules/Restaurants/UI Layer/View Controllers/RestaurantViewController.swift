//
//  RestaurantViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 30.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class RestaurantViewController: UIViewController {
    
    @IBOutlet private weak var mixListCollectionView: UICollectionView!
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    @IBOutlet private var orderButton: UIButton!
    @IBOutlet weak var bucketContainerView: UIView!
    @IBOutlet weak var orderItemsTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonHeightConstraint: NSLayoutConstraint!
    
    fileprivate let categoryCollectionViewService = CategoryCollectionViewService()
    fileprivate let mixListCollectionViewService = MixListCollectionViewService()
    fileprivate let orderItemsTableViewService = OrderItemsTableViewService()
    
    fileprivate var sectionsState = [Int : Bool]()
    fileprivate var sectionRowsHeightAmount = [Int : CGFloat]()
    
    var dispatcher: Dispatcher!
    var styleguide: DesignStyleGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.addBackButton(with: self, action: #selector(back))

        bucketContainerView.layer.borderWidth = 0.5
        bucketContainerView.layer.borderColor = UIColor.lightGray.cgColor
        
        categoryCollectionView.registerReusableCell(cellType: MixCategoryCollectionViewCell.self)
        mixListCollectionView.registerReusableCell(cellType: MixListCollectionViewCell.self)
        orderItemsTableView.registerReusableCell(cellType: OrderItemTableViewCell.self)
        
        categoryCollectionView.delegate = categoryCollectionViewService
        categoryCollectionView.dataSource = categoryCollectionViewService
        categoryCollectionViewService.delegate = self
        
        mixListCollectionView.delegate = mixListCollectionViewService
        mixListCollectionView.dataSource = mixListCollectionViewService
        mixListCollectionViewService.delegate = self
        
        orderItemsTableView.delegate = orderItemsTableViewService
        orderItemsTableView.dataSource = orderItemsTableViewService
        orderItemsTableViewService.delegate = self
        
        orderButton.alpha = 0.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
        
        navigationItem.setTitleView(withTitle: "Hookah Place".localized(),
                                    subtitle: "Выберите микс".localized(),
                                    titleColor: styleguide.primaryTextColor,
                                    titleFont: styleguide.regularFont(ofSize: 17),
                                    subtitleColor: styleguide.secondaryTextColor,
                                    subtitleFont: styleguide.regularFont(ofSize: 12))
    }

    deinit {
        print("deinit RestaurantViewController")
    }
    
    @objc func back() {
        let value = RestaurantsEvent.NavigationEvent.CloseScreen.Value(animated: true)
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.CloseScreen.self, result: Result(value: value))
    }
    
    @IBAction func order(_ sender: Any) {
        
    }
    
}

extension RestaurantViewController: CategoryServiceDelegate {
    
    func serviceDidChoseCategory(_ service: CategoryCollectionViewService, chosenCategory category: String) {
        //KS: TODO: Test code remove them later
        
        mixListCollectionViewService.data.shuffle()
        mixListCollectionView.reloadData()
    }
    
}

extension RestaurantViewController: MixListServiceDelegate {
    
    func serviceDidChoseMix(_ service: MixListCollectionViewService, chosenMixName mixName: String) {
        
        orderItemsTableViewService.data.insert(mixName, at: 0)
        orderButton.alpha = 1
        orderButton.isEnabled = true
        
        UIView.animate(withDuration: 0.3) {
            self.tableViewHeightConstraint.constant = 44 * self.tableViewHeightConstraintIndex() + 2
            self.buttonHeightConstraint.constant = 44
            self.view.layoutIfNeeded()
        }
        
        orderItemsTableView.reloadData()
    }
    
}

extension RestaurantViewController: OrderItemsServiceDelegate {
    
    func orderItemsServiceDidDeleteItem(_ service: OrderItemsTableViewService, deletedItem item: String) {
        
        if orderItemsTableViewService.data.count == 0 {
            UIView.animate(withDuration: 0.5) {
                self.tableViewHeightConstraint.constant = 0
                self.orderButton.isHighlighted = true
                self.orderButton.alpha = 0.5
                self.view.layoutIfNeeded()
                //self.orderItemsTableView.reloadData()
            }
        } else if orderItemsTableViewService.data.count <= 3 {
            UIView.animate(withDuration: 0.5) {
                self.tableViewHeightConstraint.constant = 44 * self.tableViewHeightConstraintIndex()
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    func tableViewHeightConstraintIndex() -> CGFloat {
        let index: CGFloat
        
        switch self.orderItemsTableViewService.data.count {
        case 0, 1, 2:
            index = CGFloat(self.orderItemsTableViewService.data.count)
        default:
            index = 2.5
        }
        
        return index
    }
    
}
