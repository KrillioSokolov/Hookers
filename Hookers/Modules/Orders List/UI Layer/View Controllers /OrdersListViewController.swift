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

        configurateTableView()
        configurateService()
        ordersListStore.getOrdersList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigation()
    }

    private func setupNavigation() {
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationItem.title = "Мои Заказы".localized()
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
    }
    
}

//MARK: - Configurate
extension OrdersListViewController {
    
    private func configurateTableView() {
        tableView.backgroundColor = .black
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    private func configurateService() {
        service = OrdersListTableViewService(tableView: tableView)
        service.configurate(with: self, styleGuide: styleguide)
    }
    
}

//MARK: - OrdersListServiceDelegate
extension OrdersListViewController: OrdersListServiceDelegate {
    
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
    
    //CS: TODO:
    private func ordersListStoreStateChange(change: OrdersListStoreStateChange) {
        if change.contains(.isLoadingState) {
            ordersListStore.isLoading ? self.showSpinner() : self.hideSpinner()

            //KS: TODO: Show/hide skeleton
            //restaurantStore.isLoading ? addSkeletonViewController() : hideSkeletonViewController()
        }

        if change.contains(.orders) {
            guard let orders = ordersListStore.orders else { return }

            self.service.updateOrdersList(with: orders)
        }
    }
    
}
