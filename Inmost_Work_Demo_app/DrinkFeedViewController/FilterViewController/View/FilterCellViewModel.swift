//
//  FilterCellViewModel.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 26.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

class FilterCellViewModel {
    var title: String
    
    var isApply: Bool = false
    
    init(model: String) {
        self.title = model
    }
}
