//
//  BookSearchViewController.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/09/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

// 책 내용 검색 + 해시태그 내용까지 포함하는 뷰컨


import UIKit
import RealmSwift

class BookSearchViewController: UIViewController {
    
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var searchFieldTextLabel: UITextField!
    
    
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        fontSetting()
        searchFieldTextLabel.delegate = self

        // Do any additional setup after loading the view.
    }
    

    
    func fontSetting()
    {
        self.searchTitleLabel.font = UIFont(name: "BareunBatangOTFPro-1", size: 18)
        
        self.searchFieldTextLabel.font = UIFont(name: "BareunBatangOTFPro-1", size: 15)
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }


}


extension BookSearchViewController :UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        Realm.
    }
}
