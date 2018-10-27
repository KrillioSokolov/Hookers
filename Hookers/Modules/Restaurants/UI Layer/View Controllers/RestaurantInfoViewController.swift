//
//  RestaurantInfoViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 05.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class RestaurantInfoViewController: UIViewController {

    @IBOutlet weak var letsMakeHookahButton: UIButton!
    @IBOutlet weak var workingTimeButton: UIButton!
    
    var dispatcher: Dispatcher!
    var styleguide: DesignStyleGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.addCloseButton(with: self, action: #selector(close), tintColor: styleguide.primaryColor)
        
        letsMakeHookahButton.layer.borderWidth = 1
        letsMakeHookahButton.layer.borderColor = UIColor.white.cgColor
        
        letsMakeHookahButton.layer.borderWidth = 1
        letsMakeHookahButton.layer.borderColor = UIColor.white.cgColor

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
    
    @IBAction func letsMakeHookah(_ sender: Any) {
        let value = RestaurantsEvent.NavigationEvent.DidChooseRestaurant.Value(restaurantId: "1")
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.DidChooseRestaurant.self, result: Result(value: value, error: nil))
    }
    
    @IBAction func getWorkingTime(_ sender: Any) {
        
    }
    
    @objc func close() {
        let value = RestaurantsEvent.NavigationEvent.CloseScreen.Value(animated: true)
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.CloseScreen.self, result: Result(value: value))
    }

}
