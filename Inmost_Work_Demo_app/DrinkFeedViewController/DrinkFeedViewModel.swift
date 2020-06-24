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
    
    init(networkService: CoctailsListDataManagerProtocol) {
        self.networkService = networkService
        getCoctails()
    }
    
    private func getCoctails(){
        networkService.getCoctails(resultHandler: { data in
            print("data is \(data.count)")
            //self.dataSource = [TableViewSection.init(items: data)]
            self.dataSource = data
            NotificationCenter.default.post(name: .reloadTableView, object: nil)
        }, errorHandler: { error in
            print("FAILED")
        })
    }
}

extension Notification.Name {
    static let reloadTableView = Notification.Name("reloadTableView")
}
