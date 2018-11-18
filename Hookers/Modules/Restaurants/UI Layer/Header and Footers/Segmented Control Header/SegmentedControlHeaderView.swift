//
//  SegmentedControlHeaderView.swift
//  Hookers
//
//  Created by Kirill Sokolov on 18.11.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class SegmentedControlHeaderView: UITableViewHeaderFooterView, NibLoadable {

    
    @IBOutlet weak var segmentedControl2: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("awake")
    }
    
}
