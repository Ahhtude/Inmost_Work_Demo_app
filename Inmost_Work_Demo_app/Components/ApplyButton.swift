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
    
    var isApply: Bool = false {
        didSet{
            if isApply {
                showSelection()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 6
        clipsToBounds = true
        backgroundColor = UIColor.black
        titleLabel?.font = UIFont.robotoFont19
        titleLabel?.textColor = .white
        titleLabel?.text = "APPLY"
    }
    
    func showSelection() {
        UIView.animate(withDuration: 0.3, animations: {[unowned self] in
            self.backgroundColor = UIColor.white
            }, completion: {[unowned self] _ in
                UIView.animate(withDuration: 0.3 , animations: {[unowned self] in
                    self.backgroundColor = UIColor.black
                })
            })
    }
    
}
