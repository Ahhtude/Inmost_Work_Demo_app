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
    
    var viewModel: FilterCellViewModel!
    
    var isApply: Bool = true {
        didSet {
            isSelected = isApply
            self.viewModel.isApply = isApply
            applyAction(state: viewModel.isApply)
            self.reloadInputViews()
        }
    }
    
    override func awakeFromNib() {
        filterTitle.font = UIFont.robotoFont19
        filterTitle.textColor = UIColor.defaultTextColor
        selectionStyle = .none
    }
    
    func fill(model: FilterCellViewModel){
        self.viewModel = model
        filterTitle.text = model.title
        isApply = model.isApply
    }
    
    override func prepareForReuse() {
        applyImage.image = nil
        filterTitle.text = ""
    }
    
    func applyAction(state: Bool) {
        if state {
            applyImage.isHidden = false
        } else {
            applyImage.isHidden = true
        }
    }
}
