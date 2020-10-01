//
//  BookWriteViewController.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/09/01.
//  Copyright © 2020 송지훈. All rights reserved.
//


// 책 카테고리 정하고  >> 질문 정하고 >> 작성하는 부분까지 담당하는 뷰컨



import UIKit

class BookWriteViewController: UIViewController {
    
    @IBOutlet weak var writeTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontSetting()
        // Do any additional setup after loading the view.
    }
    
    
    func fontSetting()
    {
        self.writeTitleLabel.font = UIFont(name: "BareunBatangOTFPro-1", size: 18)
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

}
