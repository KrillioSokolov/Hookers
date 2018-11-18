//
//  RestaurantInfoViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 05.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class RestaurantInfoViewController: UIViewController {

    @IBOutlet private weak var letsMakeHookahButton: UIButton!
    @IBOutlet private weak var workingTimeButton: UIButton!
    @IBOutlet private weak var restaurantDescription: UILabel!
    @IBOutlet private weak var restaurantImageView: UIImageView!
    @IBOutlet weak var hookahPrice: UILabel!
    
    var dispatcher: Dispatcher!
    var styleguide: DesignStyleGuide!
    var restaurant: NetworkRestaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.addCloseButton(with: self, action: #selector(close), tintColor: styleguide.primaryColor)
    
        configurateUI()
        refreshUI(withStyleguide: styleguide)
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
    
    func configurateUI() {
        restaurantImageView.download(image: restaurant.imageURL, placeholderImage: nil)
        restaurantDescription.text = restaurant.description
    }
    
    @IBAction func letsMakeHookah(_ sender: Any) {
        let value = RestaurantsEvent.NavigationEvent.DidChooseRestaurant.Value(restaurant: restaurant)
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.DidChooseRestaurant.self, result: Result(value: value, error: nil))
    }
    
    @IBAction func getWorkingTime(_ sender: Any) {
        
    }
    
    @objc func close() {
        let value = RestaurantsEvent.NavigationEvent.CloseScreen.Value(animated: true)
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.CloseScreen.self, result: Result(value: value))
    }

}

extension RestaurantInfoViewController: UIStyleGuideRefreshing {
    
    func refreshUI(withStyleguide styleguide: DesignStyleGuide) {
        restaurantDescription.textColor = styleguide.labelTextColor
        hookahPrice.textColor = styleguide.labelTextColor
        letsMakeHookahButton.backgroundColor = styleguide.primaryColor
    }
    
}
