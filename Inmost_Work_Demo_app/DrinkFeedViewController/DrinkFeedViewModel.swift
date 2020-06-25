//
//  DrinkFeedViewModel.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 23.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation


class DrinkFeedViewModel {
    private let networkService : CoctailsListDataManagerProtocol
    
    //var dataSource: [TableViewSection<DrinkFeed>] = []
    var dataSource: [DrinkFeed] = []
    
    var didError: ((NetworkError) -> Void)?
    var didUpdate: ((DrinkFeedViewModel) -> Void)?
    
    
    init(networkService: CoctailsListDataManagerProtocol) {
        self.networkService = networkService
    }
    
    private(set) var isUpdating: Bool = false {
        didSet { self.didUpdate?(self) }
    }
    
    func reloadData() {
           self.isUpdating = true
           self.networkService.getCoctails(resultHandler: { [unowned self] coctails in
                    self.dataSource = coctails
                   self.isUpdating = false
               },
                   errorHandler: { [unowned self] error in
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
