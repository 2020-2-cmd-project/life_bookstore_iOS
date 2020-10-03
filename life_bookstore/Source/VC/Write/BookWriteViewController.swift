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
    @IBOutlet weak var writeDirectiveLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var setImageButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontSetting()
        buttonSetting()
        defaultSetting()
    }
    
    
    func fontSetting() {
        self.writeTitleLabel.font = UIFont(name: "BareunBatangOTFPro-1", size: 18)
        self.writeDirectiveLabel.font = UIFont(name: "BareunBatangOTFPro-2", size: 18)
        self.categoryButton.titleLabel?.font = UIFont(name: "BareunBatangOTFPro-1", size: 13)
        self.setImageButton.titleLabel?.font = UIFont(name: "BareunBatangOTFPro-1", size: 13)
        self.questionLabel.font = UIFont(name: "BareunBatangOTFPro-2", size: 15)
    }
    
    func buttonSetting() {
        categoryButton.backgroundColor = UIColor.white
        categoryButton.layer.cornerRadius = 14
        categoryButton.layer.shadowColor = UIColor.black.cgColor
        categoryButton.layer.shadowRadius = 10
        categoryButton.layer.shadowOpacity = 0.16
        categoryButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        setImageButton.backgroundColor = UIColor.white
        setImageButton.layer.cornerRadius = 14
        setImageButton.layer.shadowColor = UIColor.black.cgColor
        setImageButton.layer.shadowRadius = 10
        setImageButton.layer.shadowOpacity = 0.16
        setImageButton.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func defaultSetting() {
        imageView.backgroundColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1)
        imageView.layer.cornerRadius = 11
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 22
        imageView.layer.shadowOpacity = 0.16
        imageView.layer.shadowOffset = CGSize(width: 0, height: 8)
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

}
