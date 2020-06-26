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
    
    var coctailsFilter: Set<String> = []
    
    
    init(networkService: CoctailsListDataManagerProtocol) {
        self.networkService = networkService
    }
    
    private(set) var isUpdating: Bool = false {
        didSet { self.didUpdate?(self) }
    }
    
    func reloadData() {
        self.isUpdating = true
        if !coctailsFilter.isEmpty {
            for keys in coctailsFilter {
                self.getData(keys)
            }
        } else {
            self.getData(nil)
        }
       }
    
    private func getData(_ key: String?){
        print("keys is \(key)")
        self.networkService.getCoctails(filter: key ,resultHandler: {[unowned self] coctails in
            self.dataSource = []
            coctails.map({[unowned self] element in
                self.dataSource.append(element)
            })
            //self.dataSource = coctails
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
