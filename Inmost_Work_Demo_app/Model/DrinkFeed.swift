//
//  DrinkFeed.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 23.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

struct DrinkFeed: Decodable {
    
    let title: String
    let image : String
    let id : String

    private enum CodingKeys: String, CodingKey {
        case title = "strDrink"
        case image = "strDrinkThumb"
        case id = "idDrink"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        image = try values.decode(String.self, forKey: .image)
        id    = try values.decode(String.self, forKey: .id)
    }
}
