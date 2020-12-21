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
    
    @IBOutlet weak var searchBackgroundImageView: UIImageView!
    
    @IBOutlet weak var searchIconImageView: UIImageView!
    @IBOutlet weak var deleteImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(setDeletedBookList), name: NSNotification.Name("reloadBookData"), object: nil)
    }
    
    
    func viewDataSetting()
    {
        
        
        if isViewMode == true // 책 보기 모드 
        {
            deleteImageView.isHidden = false
            deleteButton.isHidden = false
            searchIconImageView.isHidden = true
            searchBackgroundImageView.isHidden = true
            searchFieldTextLabel.isHidden = true
            searchTitleLabel.text = categoryName
        }
        else // 검색 모드
        {
            deleteImageView.isHidden = true
            deleteButton.isHidden = true
            searchIconImageView.isHidden = false
            searchBackgroundImageView.isHidden = false
            searchFieldTextLabel.isHidden = false
            self.searchTitleLabel.text = "책 찾아보기"
        }
    }
    
    func setCollectionView()
    {
        self.bookCollectionView.delegate = self
        self.bookCollectionView.dataSource = self
    }
    
    @objc func setDeletedBookList(noti : NSNotification) // 책이 삭제됐을때 호출되는 메소드, 해당 값에 대해서 삭제가 들어가야 함
    {
        let bookList = realm.objects(BookDataModelList.self).filter("categoryName == '\(categoryName)'")
        
        self.bookData = Array(bookList)
        
  
        self.bookCollectionView.reloadData()
    }

    
    func fontSetting()
    {
        self.searchTitleLabel.font = UIFont(name: "BareunBatangOTFPro-1", size: 18)
        
        self.searchFieldTextLabel.font = UIFont(name: "BareunBatangOTFPro-1", size: 15)
        
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }

    @IBAction func deleteCategoryButtonClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "알림", message: "해당 카테고리를 삭제하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            
            // 제목에 해당하는 데이터 삭제
            let categoryObject = self.realm.objects(CategoryContainerDataModelList.self).filter("categoryName == '\(self.categoryName)'")
            
            try! self.realm.write {
                self.realm.delete(categoryObject)
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
                .filter("title contains '\(searchFieldTextLabel.text!)'")
            
            
            print("검색버튼 눌림",bookRealmData.count)
            
            
            
            if bookRealmData.count == 0
            {
                makeAlert(title: "알림", message: "검색 된 도서가 없습니다", vc: self)
                self.bookData.removeAll()
                self.bookCollectionView.reloadData()
            }
            else
            {
                self.bookData = Array(bookRealmData)
                self.bookCollectionView.reloadData()
            }


        }
        else
        {
            makeAlert(title: "알림", message: "검색어를 입력 해주세요", vc: self)
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
