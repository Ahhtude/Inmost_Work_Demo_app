//
//  DrinkFeedCellViewModel.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 24.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

class DrinkFeedCellViewModel {
    var model: DrinkFeed
    
    var title : String {
        return model.title
    }
    
    var image : String {
        return model.image
    }
    
    init(model: DrinkFeed) {
        self.model = model
    }
}

extension DrinkFeedCellViewModel {
    var imageURL: URL? {
        return URL(string: image)
    }
}
