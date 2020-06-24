//
//  ApplyButton.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 24.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit

class ApplyButton : UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 6
        backgroundColor = UIColor.black
        titleLabel?.font = UIFont.robotoFont19
        self.titleLabel?.text = "APPLY"
    }
}
