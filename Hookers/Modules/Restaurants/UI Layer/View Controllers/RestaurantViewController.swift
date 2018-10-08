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
        
        tableView.registerReusableCell(cellType: CircleImageHorizontalScrollTableViewCell.self)
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

extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Миксы дня"
        case 1:
            return "Миксы недели"
        case 2:
            return "Сегодня забивают"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath, cellType: CircleImageHorizontalScrollTableViewCell.self)
        switch indexPath.section {
        case 0:
            cell.cellImage = UIImage(named: "lemon_pie")
            cell.mixName = "Лимонный пирог"
        case 1:
            cell.cellImage = UIImage(named: "mafin")
            cell.mixName = "Ванильный мафин"
        case 2:
            cell.cellImage = UIImage(named: "hookerMan")
            cell.mixName = "Nicolas"
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CircleImageTableViewHeaderFooterView.instantiateFromNib()
        
        headerView.headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerView.backgroundColor = .black
       
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //KS: TODO: Add correct setting restaurant model
        let value = RestaurantsEvent.NavigationEvent.DidChooseRestaurant.Value(restaurantId: String(indexPath.row))
        
        dispatcher.dispatch(type: RestaurantsEvent.NavigationEvent.DidChooseRestaurant.self, result: Result(value: value, error: nil))
    }
    
}


