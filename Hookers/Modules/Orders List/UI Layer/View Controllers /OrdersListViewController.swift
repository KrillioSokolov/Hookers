//
//  OrdersListViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 25.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class OrdersListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var dispatcher: Dispatcher!
    var styleguide: DesignStyleGuide!
    var ordersListStore: OrdersListStore! {
        didSet {
            ordersListStore.addDataStateListener(self)
        }
    }
    
    private var service: OrdersListTableViewService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurateTableViewService()
        ordersListStore.getOrdersList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigation()
    }

    private func setupNavigation() {
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Мои Заказы".localized()
    }
    
}

//MARK: - Configurate
extension OrdersListViewController {
    
    private func configurateTableViewService() {
        service = OrdersListTableViewService(tableView: tableView)
        service.configurate(with: styleguide)
    }
    
}

//MARK: - DataStateListening
extension OrdersListViewController: DataStateListening {
    
    func domainModel(_ model: DomainModel, didChangeDataStateOf change: DataStateChange) {
        DispatchQueue.updateUI {
            self.domainModelChanged(model, didChangeDataStateOf: change)
        }
    }
    
    private func domainModelChanged(_ model: DomainModel, didChangeDataStateOf change: DataStateChange) {
        if let change = change as? OrdersListStoreStateChange {
            ordersListStoreStateChange(change: change)
        }
    }
    
    private func ordersListStoreStateChange(change: OrdersListStoreStateChange) {
        if change.contains(.isLoadingState) {
            ordersListStore.isLoading ? showSpinner() : hideSpinner()

            //KS: TODO: Show/hide skeleton
            //restaurantStore.isLoading ? addSkeletonViewController() : hideSkeletonViewController()
        }

        if change.contains(.orders) {
            guard let orders = ordersListStore.orders else { return }

            service.updateOrdersList(with: orders)
        }
    }
    
}
