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
    
    let viewModel = DrinkFeedViewModel(networkService: CoctailsListDataManager())
    
    unowned var filterController: FilterViewController {
        let vc =  UIStoryboard(name: "FilterViewController", bundle: nil)
        .instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        vc.viewModel = FilterViewModel()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        bindToViewModel()
        
    }
    
    override func awakeFromNib() {
        //self.reloadCoctailsData()
    }
    
    private func configureNavigationBar(){
        self.navigationController?.navigationBar.tintColor = .black
        let rightItem = UIBarButtonItem.init()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Constants.titleWidth, height: Constants.titleHeight))
        titleLabel.font = UIFont.robotoFont28
        titleLabel.textAlignment = .left
        let leftTitleItem = UIBarButtonItem.init(customView: titleLabel)
    
        rightItem.tintColor = .black
        rightItem.image = UIImage(named: "filterNavigationButton")
        
        rightItem.target = self
        rightItem.action = #selector(filterViewController)
        
        
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
        //NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: .reloadTableView, object: nil)
    }
    
    private func bindToViewModel() {
        self.viewModel.didUpdate = { [weak self] _ in
            self?.viewModelDidUpdate()
        }
        self.viewModel.didError = { [weak self] error in
            self?.viewModelDidError(error: error)
        }
        reloadCoctailsData()
    }
    
    private func viewModelDidUpdate() {
        
        self.tableView.reloadData()
    }
    
    private func viewModelDidError(error: NetworkError) {
       //UIAlertView(title: "Error", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    func reloadCoctailsData() {
//        print("FILTERS \( self.filterController.viewModel.selectedFilters.count)")
        self.viewModel.reloadData()
    }
    
    
}

extension DrinkFeedViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkFeedCellViewModel") as? DrinkFeedViewCell else { return UITableViewCell() }
        let feed = viewModel.dataSource[indexPath.row]
        cell.fill(model: DrinkFeedCellViewModel(model: feed))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let feed = viewModel.dataSource[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }
    
//    @objc func updateTableView(_ notification: Notification){
//        self.tableView.reloadData()
//    }
    
    @objc func filterViewController(sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(self.filterController, animated: true)
    }
}
