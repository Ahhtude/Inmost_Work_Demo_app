//
//  FilterViewController.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 24.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var acceptButton: ApplyButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        print("title label is \(self.acceptButton.titleLabel)")
    }
    
    private func configureNavigationBar() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 69, height: 28))
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = UIFont.robotoFont28
        titleLabel.sizeToFit()
        let leftTitleItem = UIBarButtonItem.init(customView: titleLabel)
    }
    

}
