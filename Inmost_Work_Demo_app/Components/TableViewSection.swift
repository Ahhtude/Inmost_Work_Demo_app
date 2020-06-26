//
//  TableViewSection.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 24.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

struct TableViewSection<T> {
    
    var header: String?
    
    var items: [T]
    
    init(header: String? = nil, items: [T]) {
        self.header = header
        self.items = items
    }
}
