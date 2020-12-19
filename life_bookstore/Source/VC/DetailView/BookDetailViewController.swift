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
        print("북 데이터",bookData)
    }
    
    //MARK:- IBAction Part
    

    
    //MARK:- default Setting Function Part
    
    func dataLoadFromRealm()
    {
        
        let bookRealmData = realm
            .objects(BookDataModelList.self)
            .filter("name == 'user1'")
        
        let bookData = bookRealmData.first
        
        
        let hashTagList = Array(bookData!.hashTag)
        
        
        
        
        if hashTagList.count > 0
        {
            for i in 0 ... hashTagList.count - 1
            {
                hashTagStringList += "#\(hashTagList[0].hashTag) "
            }
        }
    
        hashTagLabel.text = hashTagStringList
    
        
        titleLabel.text = bookData?.title
        
        categoryLabel.text = bookData?.categoryName
        locationLabel.text = bookData?.location
        dateLabel.text = bookData?.time
        
        
    
        bookCoverImageView.image = UIImage(data:bookData?.bookCoverPhoto ?? Data())
        
        
        questionTitleLabel.text = bookData?.questionName
        contentTextView.text = bookData?.content
        

    }

    //MARK:- Function Part
    

    
    //MARK:- @objc function Part
   
}

    //MARK:- extension 부분
