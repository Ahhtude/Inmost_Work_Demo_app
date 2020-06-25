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
    
    private var viewModel : FilterViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        acceptButton.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)
    }
    
    private func configureNavigationBar() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 69, height: 28))
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = UIFont.robotoFont28
        titleLabel.sizeToFit()
        let leftTitleItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    private func configureTableView() {
        tableView.rowHeight = 80
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView?.register(UINib(nibName: "FilterCell", bundle: nil),
        forCellReuseIdentifier: "FilterCell")
    }
}

extension FilterViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterCell else {return}
        cell.isApply = !cell.isApply
        
        if cell.isApply {
            viewModel.selectedFilters.insert(cell.filterTitle.text!)
        } else {
            viewModel.selectedFilters.remove(cell.filterTitle.text!)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell") as? FilterCell else { return UITableViewCell() }
        cell.fill(model: viewModel.dataSource[indexPath.row])
        return cell
    }
    
    @objc func applyFilters (sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
