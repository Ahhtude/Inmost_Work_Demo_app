//
//  FilterViewModel.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 24.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

class FilterViewModel {
    var dataSource: [String] = ["Ordinary Drink","Cocktail","Milk / Float / Shake","Other/Unknown","Cocoa","Shot","Coffee / Tea","Homemade Liqueur","Beer","Punch / Party Drink"]
    
    var selectedFilters: Set<String> = []
    
}
