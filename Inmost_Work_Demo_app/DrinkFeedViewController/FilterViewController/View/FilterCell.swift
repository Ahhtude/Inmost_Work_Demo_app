//
//  FilterCell.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 25.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var applyImage: UIImageView!
    @IBOutlet weak var filterTitle: UILabel!
    
    var isApply: Bool = false {
        didSet{
            if isApply {
                applyImage.isHidden = false
            } else {
                applyImage.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        filterTitle.font = UIFont.robotoFont19
        filterTitle.textColor = UIColor.defaultTextColor
        selectionStyle = .none
        isApply = false
    }
    
    func fill(model: String){
        filterTitle.text = model
    }
    
    override func prepareForReuse() {
        applyImage.image = nil
        filterTitle.text = ""
    }
}
