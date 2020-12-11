//
//  BookCategoryViewController.swift
//  life_bookstore
//
//  Created by taehy.k on 2020/12/11.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import RealmSwift

class BookCategoryViewController: UIViewController {

    //MARK: - IBOutlet Part
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Variable Part
    let realm = try! Realm()
    var categoryArray : [CategoryContainerDataModelList] = []

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "categoryTableCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        dataLoadFromRealm()
    }
    
    //MARK: - Default Setting
    func dataLoadFromRealm()
    {
        let list = realm.objects(CategoryContainerDataModelList.self)
        
        let categoryRealmArray = Array(list)
        
        
        categoryArray.removeAll()
        categoryArray = categoryRealmArray
        
        tableView.reloadData()
    }
    

}

extension BookCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableCell", for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.categoryTitleLabel.text = categoryArray[indexPath.row].categoryName
        
        return cell
    }
    
    
}
