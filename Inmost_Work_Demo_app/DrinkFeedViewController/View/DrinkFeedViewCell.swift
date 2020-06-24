//
//  DrinkFeedViewCell.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 23.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class DrinkFeedViewCell : UITableViewCell {
    
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    
    var viewModel: DrinkFeedCellViewModel!
    
    func fill(model: DrinkFeedCellViewModel){
        self.viewModel = model
        setUpFunctions()
    }
    
    override func awakeFromNib() {
        self.drinkName.font = UIFont.robotoFont19
        self.drinkName.textColor = UIColor.defaultTextColor
    }
    
    override func prepareForReuse() {
        drinkImage.image = nil
        drinkName.text = ""
    }
    

    
    private func setUpFunctions(){
        self.drinkName.text = self.viewModel.title
        
        guard let imageURL = viewModel.imageURL else {
            self.drinkImage.image = UIImage(named: "defaultCoctail")
            return
        }
        
        self.drinkImage.af_setImage(withURL: imageURL)
    }
}
