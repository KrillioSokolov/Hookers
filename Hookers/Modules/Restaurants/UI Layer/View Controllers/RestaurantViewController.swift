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
//    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonHeightConstraint: NSLayoutConstraint!
    fileprivate let categoryCollectionViewService = CategoryCollectionViewService()
    fileprivate let mixListCollectionViewService = MixListCollectionViewService()
    fileprivate let orderItemsTableViewService = OrderItemsTableViewService()
    
    fileprivate var sectionsState = [Int : Bool]()
    fileprivate var sectionRowsHeightAmount = [Int : CGFloat]()
    
    var dispatcher: Dispatcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.addBackButton(with: self, action: #selector(back))
        //addHandButton()
        
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
        
    }
    
    func addHandButton() {
        let backButton = UIButton()
        let image = UIImage(named: "hand")?.withRenderingMode(.alwaysTemplate)
        let barButtonItem = UIBarButtonItem(customView: backButton)
        
        backButton.setImage(image, for: .normal)
        backButton.tintColor = view.tintColor
        backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        //backButton.addTarget(target, action: nil, for: .touchUpInside)
        var contentInsets = backButton.contentEdgeInsets
        contentInsets.left = -30
        backButton.contentEdgeInsets = contentInsets
        navigationItem.setRightBarButton( barButtonItem, animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationItem.title = "Hookah Place".localized()
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
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
        //orderButton.isHighlighted = false
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
