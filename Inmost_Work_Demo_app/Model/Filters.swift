//
//  Filters.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 26.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

struct Filters: Decodable {
    
    let title: String

    private enum CodingKeys: String, CodingKey {
        case title = "strCategory"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
    }
}
