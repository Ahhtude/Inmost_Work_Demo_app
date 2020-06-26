//
//  FilterViewModel.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 24.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

class FilterViewModel {
    private let networkService : CoctailsListDataManagerProtocol
    
    var dataSource: [String] = []
    
    var selectedFilters: Set<String> = []
    
    var didError: ((NetworkError) -> Void)?
    var didUpdate: ((FilterViewModel) -> Void)?
    
    private(set) var isUpdating: Bool = false {
        didSet { self.didUpdate?(self) }
    }
    
    init(networkService: CoctailsListDataManagerProtocol) {
        self.networkService = networkService
        networkService.getFilters(resultHandler: {resp in
        }, errorHandler: {_ in })
    }
    
    func reloadData() {
        self.dataSource = []
        self.isUpdating = true
        
        self.networkService.getFilters(resultHandler: {[unowned self] filters in
            filters.map({[unowned self] key in
                self.dataSource.append(key.title)
            })
            
            self.isUpdating = false
            }, errorHandler: { [unowned self] error in
                   self.didError?(error!)
                   self.isUpdating = false
               }
           )
    }
}
