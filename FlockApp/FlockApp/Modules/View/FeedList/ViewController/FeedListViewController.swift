//
//  FeedListViewController.swift
//  FlockApp
//
//  Created by Admin on 18/09/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class FeedListViewController: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    
    // MARK:- Properties
    
    private var viewModel = FeedListVMModel(dataFetcher: FeedWSManager())
    var feedModel:[Feed]?
    
    
    // MARK:- ViewLifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        viewModel.viewDidLoad()
        setupNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
     * This method will setup NavigationBar
     */
    func setupNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barTintColor = UIColor(hexColor: UIConstant.appColor)!
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(hexColor: UIConstant.navTextColor)!]
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named:UIConstant.Images.logouticon), for: .normal)
        button.addTarget(self, action: #selector(self.logoutButtonPressed), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = leftBarButton
        self.title = "Feeds"
        
        if UIDevice.current.iPhoneX {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
  
    
    
    /*
     This method will prepare TableView for Data Source.
     */
    private func prepareTableView() {
        FeedListCell.registerWithTable(feedTableView)
        observeEvents()
    }
    
    // MARK:- Observer Methods
    
    /*
     This method is Observer of ViewModel.
     */
    private func observeEvents() {
        
        viewModel.reloadTable = { [weak self]  in
            DispatchQueue.main.async {
                // self?.indicator.stopAnimating()
                self?.feedTableView.dataSource = self
                self?.feedTableView.delegate = self
                self?.feedTableView.reloadData()
            }
        }
    }
    
    @objc func logoutButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
// MARK:- UITableViewDataSource

extension FeedListViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentModel:FeedCellVMModel = viewModel.cellViewModel(indexPath: indexPath)
        return (currentModel.calculateHeightRow(viewModel: currentModel)).height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedListCell.reuseIdentifier, for: indexPath) as! FeedListCell
        cell.accessibilityIdentifier = "FeedListCell\(indexPath.row)"
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.prepareCell(viewModel: viewModel.cellViewModel(indexPath: indexPath))
        return cell
    }
}


