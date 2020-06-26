//
//  DrinkFeedViewModel.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 23.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

fileprivate struct Constants{
    static var defaurlNetworkRequestKey = "Ordinary Drink"
}


class DrinkFeedViewModel {
    private let networkService : CoctailsListDataManagerProtocol
        
    var tableViewSections: [TableViewSection<DrinkFeed>] = []
    var coctailsFilter: Set<String> = []
    
    var didError: ((NetworkError) -> Void)?
    var didUpdate: ((DrinkFeedViewModel) -> Void)?
    
    init(networkService: CoctailsListDataManagerProtocol) {
        self.networkService = networkService
    }
    
    private(set) var isUpdating: Bool = false {
        didSet { self.didUpdate?(self) }
    }
    
    func reloadData() {
        self.tableViewSections = []
        
        self.isUpdating = true
        
        if !coctailsFilter.isEmpty {
            coctailsFilter.map({[unowned self] key in self.getData(key)})
        } else {
            self.getData(nil)
        }
    }
    
    private func getData(_ key: String?) {
        let forceKey = key ?? Constants.defaurlNetworkRequestKey
        
        self.networkService.getCoctails(filter: forceKey ,resultHandler: {[unowned self] coctails in
            self.tableViewSections.append(TableViewSection.init(header: forceKey, items: coctails))
            self.isUpdating = false
            }, errorHandler: { [unowned self] error in
                   self.didError?(error!)
                   self.isUpdating = false
               }
           )
    }
    
    
    //Network request with NotificationCenter
//    private func getCoctails() {
//        networkService.getCoctails(resultHandler: { data in
            //self.dataSource = [TableViewSection.init(items: data)]
//            self.dataSource = data
            //NotificationCenter.default.post(name: .reloadTableView, object: nil)
//        }, errorHandler: { error in
//            print("FAILED")
//        })
//    }
    
}

//extension Notification.Name {
    //static let reloadTableView = Notification.Name("reloadTableView")
//}
