//
//  RestaurantViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 30.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class RestaurantViewController: UIViewController {
    
    @IBOutlet weak var rightArrowImageView: UIImageView!
    @IBOutlet weak var makeHookahButton: UIButton!
    @IBOutlet var orderButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var dispatcher: Dispatcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.addBackButton(with: self, action: #selector(back))
       
        makeHookahButton.layer.borderWidth = 1
        makeHookahButton.layer.borderColor = UIColor.white.cgColor
        
        orderButton.layer.borderWidth = 1
        orderButton.layer.borderColor = UIColor.white.cgColor
        
        rightArrowImageView.image = rightArrowImageView.image?.withRenderingMode(.alwaysTemplate)
        rightArrowImageView.tintColor = .white
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

extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(indexPath, cellType: RestaurantTableViewCell.self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44*3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //KS: TODO: Add correct setting restaurant model
        let value = RestaurantsEvent.NavigationEvent.DidChooseRestaurant.Value(restaurantId: String(indexPath.row))
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.DidChooseRestaurant.self, result: Result(value: value, error: nil))
    }
    
}


