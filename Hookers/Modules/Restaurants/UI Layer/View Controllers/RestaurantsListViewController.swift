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
    
    let restaurants = NetworkRestaurant.makeTestRestaurants()
    let hookahMasters = HookahMaster.testMasters()
    
    var displayableData: [DisplayableRestaurantListItem] {
        return segmentedControl.selectedSegmentIndex == 0 ? restaurants : hookahMasters
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerReusableCell(cellType: RestaurantTableViewCell.self)
        tableView.registerReusableCell(cellType: HookahMasterTableViewCell.self)
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
        let title = isRestaurantsList ? "Выберите заведение".localized() :
                                        "Выберите кальянщика".localized()
        
        navigationItem.setTitleView(withTitle: "Днепр".localized(),
                                    subtitle: title,
                                    titleColor: styleguide.primaryTextColor,
                                    titleFont: styleguide.regularFont(ofSize: 17),
                                    subtitleColor: styleguide.secondaryTextColor,
                                    subtitleFont: styleguide.regularFont(ofSize: 12))
        
        tableView.reloadData()
    }
    
}

extension RestaurantsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isRestaurantsList ? restaurants.count : hookahMasters.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell & RestaurantListTableViewCell
        
        cell = isRestaurantsList ? tableView.dequeueReusableCell(indexPath, cellType: RestaurantTableViewCell.self) : tableView.dequeueReusableCell(indexPath, cellType: HookahMasterTableViewCell.self)
        
        let displayableItem = displayableData[indexPath.row]
        
        cell.presentImageView.image = UIImage.init(named: displayableItem.photo)
        cell.nameLabel.text = displayableItem.name
        cell.likeCountLabel.text = displayableItem.likes
        cell.distanceLabel.text = displayableItem.distanse + "км"
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/3.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //KS: TODO: Add correct setting restaurant model
                
        let value = RestaurantsEvent.NavigationEvent.DidChooseRestaurant.Value(restaurantId: String(indexPath.row))
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.DidChooseRestaurant.self, result: Result(value: value, error: nil))
    }
    
}

extension RestaurantsListViewController: RestaurantTableViewCellDelegate {
    
    func didTapRestaurantInfoButton(on cell: UITableViewCell) {
        let value = RestaurantsEvent.NavigationEvent.DidTapInfoButtonOnRestaurantCell.Value(restaurantId: String(cell.tag))
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.DidTapInfoButtonOnRestaurantCell.self, result: Result(value: value, error: nil))
    }
    
}

