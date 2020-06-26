//
//  FilterViewController.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 24.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit

fileprivate struct Constants {
    static var rowHeight: CGFloat = .init(80.0)
}

class FilterViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var acceptButton: ApplyButton!
    
    var viewModel : FilterViewModel = .init()
    
    private unowned var mainVC: DrinkFeedViewController {
        return navigationController!.rootVC as! DrinkFeedViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        acceptButton.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)
    }
    
    private func configureTableView() {
        tableView.rowHeight = Constants.rowHeight
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView?.register(UINib(nibName: "FilterCell", bundle: nil),
        forCellReuseIdentifier: "FilterCellViewModel")
    }
    
}

extension FilterViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterCell else {return}
        
        cell.isApply = !cell.viewModel.isApply
        
        if cell.viewModel.isApply {
            viewModel.selectedFilters.insert(cell.filterTitle.text!)
        } else {
            viewModel.selectedFilters.remove(cell.filterTitle.text!)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCellViewModel") as? FilterCell else { return UITableViewCell() }
        cell.fill(model: FilterCellViewModel(model: viewModel.dataSource[indexPath.row]))
        return cell
    }
    
    @objc func applyFilters (sender : UIButton) {
        mainVC.viewModel.coctailsFilter = viewModel.selectedFilters
        mainVC.reloadCoctailsData()
        self.navigationController?.popViewController(animated: true)
    }
    
}
