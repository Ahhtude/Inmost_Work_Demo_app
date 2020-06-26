//
//  TableViewSection.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 24.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

struct TableViewSection<Model> {
    var header: String?
    
    var items: [Model]
    
    init(header: String? = nil, items: [Model]) {
        self.header = header
        self.items = items
    }
}
