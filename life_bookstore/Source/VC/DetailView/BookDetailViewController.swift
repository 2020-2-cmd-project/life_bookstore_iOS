//
//  BookDetailViewController.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/09/01.
//  Copyright © 2020 송지훈. All rights reserved.
//


// 책 내용 자세히보기 담당하는 뷰컨


import UIKit
import RealmSwift

class BookDetailViewController: UIViewController {

    //MARK:- IBOutlet Part
    
    @IBOutlet weak var titleLabel: UITextView!
    @IBOutlet weak var hashTagLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    //MARK:- Variable Part
    
    let realm = try! Realm()
    var bookData = BookDataModelList()
    
    
    var hashTagStringList = ""
    
    

    //MARK:- Constraint Part
    

    //MARK:- Life Cycle Part
    override func viewDidLoad() {
        super.viewDidLoad()
        fontSetting()
        print("북 데이터",bookData)
      
    }
    override func viewWillAppear(_ animated: Bool) {

        loadBookData()
    }

    
    //MARK:- IBAction Part
    

    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func modifyButtonClicked(_ sender: Any) {
    }
    
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "알림", message: "해당 책을 삭제하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            
            // 제목에 해당하는 데이터 삭제
            let bookObject = self.realm.objects(BookDataModelList.self).filter("title == '\(self.titleLabel.text!)'")
            
            try! self.realm.write {
                self.realm.delete(bookObject)
                NotificationCenter.default.post(name: NSNotification.Name("reloadBookData"), object: nil)
             
            }
  
            
            let detailAlert = UIAlertController(title: "알림", message: "삭제가 완료되었습니다", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
                self.navigationController?.popViewController(animated: true)

            }
            
            detailAlert.addAction(okAction)
            self.present(detailAlert, animated: true, completion: nil)
            
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    //MARK:- default Setting Function Part
    
    func fontSetting()
    {

        
        titleLabel.font = UIFont(name: "BareunBatangOTFPro-2", size: 26)
        titleLabel.textColor = .white
        
        hashTagLabel.font = UIFont(name: "BareunBatangOTFPro-1", size: 14)
        hashTagLabel.textColor = .white
        
        categoryLabel.font = UIFont(name: "BareunBatangOTFPro-1", size: 13)
        categoryLabel.textColor = .white
        
        
        dateLabel.font = UIFont(name: "BareunBatangOTFPro-1", size: 14)
        dateLabel.textColor = .white
        
        locationLabel.font = UIFont(name: "BareunBatangOTFPro-1", size: 13)
        locationLabel.textColor = .white
        
        questionTitleLabel.font = UIFont(name: "BareunBatangOTFPro-2", size: 16)
        questionTitleLabel.textColor = .black
        
        contentTextView.font = UIFont(name: "BareunBatangOTFPro-1", size: 14)
        contentTextView.textColor = .init(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        
    }
    
    
    func loadBookData()
    {
        
//        let bookRealmData = realm
//            .objects(BookDataModelList.self)
//            .filter("name == 'user1'")
//
//        let bookData = bookRealmData.first
//
//
//        let hashTagList = Array(bookData!.hashTag)
//
        
//
//
//        if hashTagList.count > 0
//        {
//            for i in 0 ... hashTagList.count - 1
//            {
//                hashTagStringList += "#\(hashTagList[0].hashTag) "
//            }
//        }
//
//        hashTagLabel.text = hashTagStringList
    
        
        titleLabel.text = bookData.title
        
        categoryLabel.text = bookData.categoryName
        locationLabel.text = bookData.location
        dateLabel.text = bookData.time
        
        
    
        if bookData.bookCoverPhoto.isEmpty
        {
            bookCoverImageView.image = UIImage(named: "defaultThumbnail")
        }
        
        else
        {
            bookCoverImageView.image = UIImage(data:bookData.bookCoverPhoto ?? Data())
        }
   
        
        questionTitleLabel.text = bookData.questionName
        contentTextView.text = bookData.content
        

    }

    //MARK:- Function Part
    

    
    //MARK:- @objc function Part
   
     

}

    //MARK:- extension 부분
