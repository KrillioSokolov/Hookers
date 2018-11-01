//
//  RestaurantViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 30.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class RestaurantViewController: UIViewController {
    
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var mixListCollectionView: UICollectionView!
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    @IBOutlet private weak var orderButton: UIButton!
    @IBOutlet private weak var bucketContainerView: UIView!
    @IBOutlet private weak var orderItemsTableView: UITableView!
    @IBOutlet private weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var buttonHeightConstraint: NSLayoutConstraint!
    
    fileprivate var categoryCollectionViewService: CategoryCollectionViewService!
    fileprivate var mixListCollectionViewService: MixListCollectionViewService!
    fileprivate var orderItemsTableViewService: OrderItemsTableViewService!
    
    var dispatcher: Dispatcher!
    var styleguide: DesignStyleGuide!
    var restaurantStore: RestaurantStore! {
        didSet {
            restaurantStore.addDataStateListener(self)
        }
    }
    
    var restaurant: NetworkRestaurant!
    var menu: [MixCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.addBackButton(with: self, action: #selector(back), tintColor: styleguide.primaryColor)
        
        configurateOrderItemsTableView()
        configurateMixListCollectionView()
        configurateMixCategoryCollectionView()
        configurateDisableOrderButton()
        
        restaurantStore.getHookahMenu(byRestaurantId: restaurant.restaurantId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
        
        navigationItem.setTitleView(withTitle: restaurant.name,
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
        let value = RestaurantsEvent.NavigationEvent.DidChooseMixesForOrder.Value.init(restaurant: restaurant, mixesForOrder: orderItemsTableViewService.orderedMixes)
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.DidChooseMixesForOrder.self, result: Result(value: value))
    }
    
}

extension RestaurantViewController {
    
    func configurateMixCategoryCollectionView() {
        categoryCollectionViewService = CategoryCollectionViewService(colletionView: categoryCollectionView)
        categoryCollectionViewService.configurate(with: self)
    }
    
    func configurateMixListCollectionView() {
        mixListCollectionViewService = MixListCollectionViewService(collectionView: mixListCollectionView)
        mixListCollectionViewService.configurate(with: self)
    }
    
    func configurateOrderItemsTableView() {
        orderItemsTableViewService = OrderItemsTableViewService(tableView: orderItemsTableView)
        orderItemsTableViewService.configurate(with: self)
        orderItemsTableView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        
        bucketContainerView.layer.cornerRadius = 8
        
        shadowView.layer.borderWidth = 0.5
        shadowView.layer.borderColor = UIColor.lightGray.cgColor
        shadowView.layer.cornerRadius = 8
        shadowView.addDefaultShadow()
    }
    
}


extension RestaurantViewController {
    
    func configurateDisableOrderButton() {
        orderButton.setTitleColor(styleguide.secondaryTextColor, for: .normal)
        orderButton.isEnabled = false
    }
    
    func configurateEnabledOrderButton() {
        orderButton.setTitleColor(.white, for: .normal)
        orderButton.isEnabled = true
    }
    
}

extension RestaurantViewController: CategoryServiceDelegate {
    
    func serviceDidChoseCategory(_ service: CategoryCollectionViewService, chosenCategory category: DisplayableCategory) {
        guard let mixes = menu.first(where: {$0.categoryId == category.categoryId})?.mixes else { return }
        
        categoryCollectionView.performBatchUpdates(nil, completion: nil)
        mixListCollectionViewService.updateMixes(with: mixes)
        
            self.mixListCollectionView.reloadData()
    }
    
}

extension RestaurantViewController: MixListServiceDelegate {
    
    func serviceDidChoseMix(_ service: MixListCollectionViewService, chosenMix mix: HookahMix) {
        orderItemsTableViewService.addMixToOrder(mix)
        configurateEnabledOrderButton()
        shadowView.layer.shadowOpacity = 0.8
        
        UIView.animate(withDuration: 0.3) {
            self.tableViewHeightConstraint.constant = RestaurantViewController.Constants.orderCellHeight * self.tableViewHeightConstraintIndex() + 2
            self.buttonHeightConstraint.constant = RestaurantViewController.Constants.orderCellHeight
            self.view.layoutIfNeeded()
        }
        
        orderItemsTableView.reloadData()
        orderItemsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
}

extension RestaurantViewController: OrderItemsServiceDelegate {
    
    func orderItemsServiceDidDeleteItem(_ service: OrderItemsTableViewService, deletedItem item: HookahMix) {
        if orderItemsTableViewService.orderedMixes.count == 0 {
            UIView.animate(withDuration: 0.5) {
                self.tableViewHeightConstraint.constant = 0
                self.configurateDisableOrderButton()
                self.shadowView.layer.shadowOpacity = 0
                self.view.layoutIfNeeded()
            }
        } else if orderItemsTableViewService.orderedMixes.count <= 3 {
            UIView.animate(withDuration: 0.5) {
                self.tableViewHeightConstraint.constant = RestaurantViewController.Constants.orderCellHeight * self.tableViewHeightConstraintIndex()
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    func tableViewHeightConstraintIndex() -> CGFloat {
        let index: CGFloat
        
        switch self.orderItemsTableViewService.orderedMixes.count {
        case 0, 1, 2:
            index = CGFloat(self.orderItemsTableViewService.orderedMixes.count)
        default:
            index = 2.5
        }
        
        return index
    }
    
}

extension RestaurantViewController: DataStateListening {
    
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
        
        if change.contains(.hookahMenu) {
            guard let categories = restaurantStore.hookahMenuData?.categories, categories.count > 0 else { return }
            
            menu = categories
            
            categoryCollectionViewService.updateCategories(categories: categories.map{DisplayableCategory(categoryId: $0.categoryId, name: $0.name, imageURL: $0.imageURL)})
            
            mixListCollectionViewService.updateMixes(with: categories.first?.mixes ?? [])
            
//            categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .left)
        }
    }
    
}

extension RestaurantViewController {
    
    struct Constants {
        
        static let grn = "₴"
        static let orderCellHeight = CGFloat(44.0)
        
    }
    
}
