//
//  RestaurantsListViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 25.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class RestaurantsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dispatcher: Dispatcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerReusableCell(cellType: RestaurantTableViewCell.self)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationItem.title = "Заведения".localized()
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }

}

extension RestaurantsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(indexPath, cellType: RestaurantTableViewCell.self)
        
        if indexPath.row == 1 {
            cell.presentImageView.image = UIImage.init(named: "habl")
            cell.nameLabel.text = "Хабл бабл"
            cell.likeCountLabel.text = "4.2"
            cell.distanceLabel.text = "8 км"
        }
        
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

