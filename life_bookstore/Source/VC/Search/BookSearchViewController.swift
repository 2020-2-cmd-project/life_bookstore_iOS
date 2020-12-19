//
//  BookSearchViewController.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/09/01.m
//  Copyright © 2020 송지훈. All rights reserved.
//

// 책 내용 검색 + 해시태그 내용까지 포함하는 뷰컨


import UIKit
import RealmSwift

class BookSearchViewController: UIViewController {
    
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var searchFieldTextLabel: UITextField!
    
    @IBOutlet weak var bookCollectionView: UICollectionView!
    

    let realm = try! Realm()
    
    var categoryName = ""
    var isViewMode = false
    var bookData : [BookDataModelList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fontSetting()
        searchFieldTextLabel.delegate = self
        setCollectionView()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDataSetting()
    }
    
    
    func viewDataSetting()
    {
        
        
        if isViewMode == true // 책 보기 모드 
        {
            searchTitleLabel.text = categoryName
        }
        else
        {
            self.searchTitleLabel.text = "책 찾아보기"
        }
    }
    
    func setCollectionView()
    {
        self.bookCollectionView.delegate = self
        self.bookCollectionView.dataSource = self
        
        
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
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if searchFieldTextLabel.text != "" // 여기에 검색 결과에 대한 값 뿌려야 됨
        {
      
            // 모든 카테고리 안에 있는 책들을 조회해서
            // 검색이 들어가야 한다
            let bookRealmData = realm
                .objects(BookDataModelList.self)
                .filter("name contains '\(searchFieldTextLabel.text)'")
            

        }
        
        
        return true
    }
}


extension BookSearchViewController : UICollectionViewDelegate
{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        
        let detailStoryboard = UIStoryboard(name: "bookDetail", bundle: nil)
        
        guard let detailVC = detailStoryboard.instantiateViewController(identifier: "BookDetailViewController") as? BookDetailViewController else {return}
        
        detailVC.bookData = bookData[indexPath.row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (bookCollectionView.frame.width - 70) / 3
        let height = width * 1.41
        
        return CGSize(width: width, height: height)
        
    }
}


extension BookSearchViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookSearchCollectionCell", for: indexPath) as? BookSearchCollectionCell else {return UICollectionViewCell() }
        
        bookCell.setData(title: bookData[indexPath.row].title, date: bookData[indexPath.row].time, coverImageData: bookData[indexPath.row].bookCoverPhoto, color: bookData[indexPath.row].color)
        
        return bookCell
    }
    
    
}

extension BookSearchViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { // 섹션 안에 마진 셋팅
        
        return UIEdgeInsets(top: 40, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { // 옆라인 간격 조정
        return 15
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { // 위 아래 간격 조정
        return 30
    }
}
