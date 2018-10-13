//
//  OrderItemTableViewCell.swift
//  Hookers
//
//  Created by Kirill Sokolov on 12.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class OrderItemTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var itemNumberLabel: UILabel!
    @IBOutlet weak var itemNubmerStepper: UIStepper!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    private var itemNumber = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func step(_ sender: UIStepper) {
        
        itemNumberLabel.text = String(Int(sender.value))
    }
    
}
