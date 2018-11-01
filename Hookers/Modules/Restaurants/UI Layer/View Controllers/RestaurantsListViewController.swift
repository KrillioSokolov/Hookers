//
//  RestaurantsListViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 25.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class RestaurantsListViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var dispatcher: Dispatcher!
    var styleguide: DesignStyleGuide!
    var restaurantStore: RestaurantStore! {
        didSet {
            restaurantStore.addDataStateListener(self)
        }
    }
    
    var restaurants: [NetworkRestaurant] = [] //NetworkRestaurant.makeTestRestaurants()
    var hookahMasters: [HookahMaster]?
    
    var displayableData: [DisplayableRestaurantListItem] {
        return segmentedControl.selectedSegmentIndex == 0 ? restaurants : hookahMasters ?? []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerReusableCell(cellType: RestaurantTableViewCell.self)
        tableView.registerReusableCell(cellType: HookahMasterTableViewCell.self)
        
        restaurantStore.getRestaurantsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
        
        navigationItem.setTitleView(withTitle: "Днепр".localized(),
                                    subtitle: "Выберите заведение".localized(),
                                    titleColor: styleguide.primaryTextColor,
                                    titleFont: styleguide.regularFont(ofSize: 17),
                                    subtitleColor: styleguide.secondaryTextColor,
                                    subtitleFont: styleguide.regularFont(ofSize: 12))
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        segmentedControl.tintColor = UIColor.white.withAlphaComponent(0.9)
    }
    
    private var isRestaurantsList: Bool {
        return segmentedControl.selectedSegmentIndex == 0
    }
    
}

extension RestaurantsListViewController {
    
    @IBAction func changeSegment(_ sender: Any) {
        var title = isRestaurantsList ? "Выберите заведение".localized() :
                                        "Выберите кальянщика".localized()
        
        if isRestaurantsList {
            title = "Выберите заведение".localized()
            
            tableView.reloadData()
        } else {
            title = "Выберите кальянщика".localized()
            
            guard hookahMasters == nil else {
                tableView.reloadData()
                return
            }
            
            restaurantStore.getHookahMastersList()
        }
        
        navigationItem.setTitleView(withTitle: "Днепр".localized(),
                                    subtitle: title,
                                    titleColor: styleguide.primaryTextColor,
                                    titleFont: styleguide.regularFont(ofSize: 17),
                                    subtitleColor: styleguide.secondaryTextColor,
                                    subtitleFont: styleguide.regularFont(ofSize: 12))
        
        
    }
    
}

extension RestaurantsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isRestaurantsList ? restaurants.count : hookahMasters?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell & RestaurantListTableViewCell = isRestaurantsList ?
            tableView.dequeueReusableCell(indexPath, cellType: RestaurantTableViewCell.self) :
            tableView.dequeueReusableCell(indexPath, cellType: HookahMasterTableViewCell.self)
        
        let displayableItem = displayableData[indexPath.row]
        
        let placeholderImage = UIImage(named: "avatar_default", in: Bundle(for: type(of: self)), compatibleWith: nil)
        
        cell.presentImageView.download(image: displayableItem.imageURL, placeholderImage: placeholderImage)
        cell.nameLabel.text = displayableItem.name
        cell.likeCountLabel.text = String(displayableItem.likes)
        cell.distanceLabel.text = displayableItem.distanse + "км"
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/3.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //KS: TODO: Add correct setting restaurant model
                
        let value = RestaurantsEvent.NavigationEvent.DidChooseRestaurant.Value(restaurant: restaurants[indexPath.row])
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.DidChooseRestaurant.self, result: Result(value: value, error: nil))
    }
    
}

extension RestaurantsListViewController: RestaurantTableViewCellDelegate {
    
    func didTapRestaurantInfoButton(on cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let value = RestaurantsEvent.NavigationEvent.DidTapInfoButtonOnRestaurantCell.Value(restaurant: restaurants[indexPath.row])
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.DidTapInfoButtonOnRestaurantCell.self, result: Result(value: value, error: nil))
    }
    
}

extension RestaurantsListViewController: DataStateListening {
    
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
            restaurantStore.isLoading ? self.showSpinner() : self.hideSpinner()
            
            //KS: TODO: Show/hide skeleton
            //restaurantStore.isLoading ? addSkeletonViewController() : hideSkeletonViewController()
        }
        
        if change.contains(.restaurants) {
            guard let restaurants = restaurantStore.restaurants else { return }
            
            self.restaurants = restaurants
            tableView.reloadData()
        }
        
        if change.contains(.bestHookahMasters) {
            guard let hookahMasters = restaurantStore.hookahMastersData?.hookahMasters else { return }
            
            self.hookahMasters = hookahMasters
            tableView.reloadData()
        }
    }
    
}

