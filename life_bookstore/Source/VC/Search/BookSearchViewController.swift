//
//  BookSearchViewController.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/09/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

// 책 내용 검색 + 해시태그 내용까지 포함하는 뷰컨


import UIKit

class BookSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }


}
