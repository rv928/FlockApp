//
//  FeedListVMModel.swift
//  FlockApp
//
//  Created by Admin on 19/09/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

class FeedListVMModel {
    
    // Output
    var numberOfRows = 0
    
    private var dataSource = [FeedCellVMModel]()
    
    /// Callback to reload the table.
    var reloadTable: ()->() = { }
    
    // Event
    var userSelected: (Feed?)->() = { _ in }
    
    var dataFetcher: FeedWSDataFetcherProtocol!
    
    // Input
    var viewDidLoad: () -> () = { }
    
    private var dataModel: [Feed]! {
        didSet {
            prepareTableDataSource()
            configureOutput()
        }
    }
    
    /*
     * This method will create Dependency Injection
     */
    init(dataFetcher:FeedWSDataFetcherProtocol) {
        self.dataFetcher = dataFetcher
        viewDidLoad = { [weak self] in
            self?.getFeedData()
        }
    }
    
    /*
     * This method will fetch Git User and create model
     */
    func getFeedData() {
        
        self.getFeedList(completion: { (feedList) in
            guard let feeds = feedList else {
                return
            }
            self.dataModel = feeds
        })
    }
    
    /*
     * This method will prepare datasource for UITableView
     */
    func prepareTableDataSource() {
        self.dataSource = dataModel!.map {  return FeedCellVMModel(feed: $0) }
        self.reloadTable()
    }
    
    private func configureOutput() {
        self.numberOfRows = self.dataSource.count
    }
    
    /*
     * This method will prepare Cell Model for UITableViewCell.
     */
    func cellViewModel(indexPath: IndexPath) -> FeedCellVMModel {
        let cellViewModel = dataSource[indexPath.row]
        return cellViewModel
    }
    
    /*
     This method will fetch Feed list.
     */
    private func getFeedList(completion: @escaping ([Feed]?)->()) {
        SharedClass.sharedInstance.showProgressHUD(true)
        
        FeedWSManager().feedListWS() { (dataDict,error) in
            SharedClass.sharedInstance.showProgressHUD(false)
            
            if dataDict != nil {
                let kDict:Dictionary<String,Any> = dataDict?["kstream"] as! Dictionary<String,Any>
                let listArray:Array<Any> = kDict["data"] as! Array<Any>
                let objFeedList:[Feed] = try! DictionaryDecoder().decode([Feed].self, from: listArray)
                completion(objFeedList)
            }
        }
    }
}
