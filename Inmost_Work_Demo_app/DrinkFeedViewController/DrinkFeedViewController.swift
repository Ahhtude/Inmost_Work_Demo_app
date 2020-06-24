//
//  ViewController.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 23.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import UIKit


fileprivate struct Constants {
    static let titleHeight = 28
    static let titleWidth = 69
    static let rowHeight: CGFloat = .init(100.0)
    static let titleText = "Coctails"
}

class DrinkFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = DrinkFeedViewModel(networkService: CoctailsListDataManager())

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }
    
    private func configureNavigationBar(){
        
        let rightItem = UIBarButtonItem.init()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Constants.titleWidth, height: Constants.titleHeight))
        titleLabel.font = UIFont.robotoFont28
        let leftTitleItem = UIBarButtonItem.init(customView: titleLabel)
    
        rightItem.tintColor = .black
        rightItem.image = UIImage(named: "filterNavigationButton")
        titleLabel.textAlignment = .left
        titleLabel.text = Constants.titleText
        
        navigationItem.setRightBarButton(rightItem, animated: true)
        navigationItem.setLeftBarButton(leftTitleItem, animated: true)
        
    }
    
    private func configureTableView() {
        tableView.rowHeight = Constants.rowHeight
    
        tableView?.register(UINib(nibName: "DrinkFeedViewCell", bundle: nil),
        forCellReuseIdentifier: "DrinkFeedCellViewModel")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: .reloadTableView, object: nil)
        
    }
}

extension DrinkFeedViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkFeedCellViewModel") as? DrinkFeedViewCell else { return UITableViewCell() }
        print("table view sections is \(viewModel.dataSource[indexPath.row].title)")
        let feed = viewModel.dataSource[indexPath.row]
        cell.fill(model: DrinkFeedCellViewModel(model: feed))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feed = viewModel.dataSource[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }
    
    @objc func updateTableView(_ notification: Notification){
        self.tableView.reloadData()
    }
}


