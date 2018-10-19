//
//  OrderStepsExpandedSectionTableViewHeader.swift
//  Hookers
//
//  Created by Kirill on 18.11.2017.
//  Copyright © 2017 Hookers. All rights reserved.
//

import UIKit

protocol MyPaymentsExpandedTableViewHeaderDelegate: class {
    
    func toggleSection(with sectionHeader: OrderStepsExpandedSectionTableViewHeaderProperties, section: Int)
    
}

protocol OrderStepsExpandedSectionTableViewHeaderProperties: class {
    
    var serviceImageView: UIImageView! { get }
    var serviceNameLabel: UILabel! { get }
    var serviceAmountLabel: UILabel! { get }
    var serviceArrowImage: UIImageView! { get }
    var sectionHeaderContentView: UIView! { get }
    var section: Int { get set }
    var delegate: MyPaymentsExpandedTableViewHeaderDelegate? { get set }
 
    func setCollapsed(_ collapsed: Bool)
}

final class OrderStepsExpandedSectionTableViewHeader: UITableViewHeaderFooterView, UIGestureRecognizerDelegate, OrderStepsExpandedSectionTableViewHeaderProperties {

    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var serviceAmountLabel: UILabel!
    @IBOutlet weak var serviceArrowImage: UIImageView!
    @IBOutlet weak var sectionHeaderContentView: UIView!
    
    weak var delegate: MyPaymentsExpandedTableViewHeaderDelegate? {
        didSet {
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OrderStepsExpandedSectionTableViewHeader.tapHeader(_:))))
        }
    }
    
    var section = 0
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? OrderStepsExpandedSectionTableViewHeader else {
            return
        }
        delegate?.toggleSection(with: self, section: cell.section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        serviceArrowImage.rotate(collapsed ? 0.0 : .pi)
    }
    
}
