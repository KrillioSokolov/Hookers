//
//  ConfirmOrderViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 21.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class ConfirmOrderViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var validationNumberTextField: UITextField!
    
    var styleguide: DesignStyleGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "123456789".localized(), attributes: [NSAttributedStringKey.foregroundColor: UIColor.purple])
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Джон Кальяно".localized(), attributes: [NSAttributedStringKey.foregroundColor: UIColor.purple])
    }

    @IBAction func confirmOrder(_ sender: Any) {
        descriptionLabel.isHidden = false
        validationNumberTextField.isHidden = false
    }
    
}
