//
//  BookWriteViewController.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/09/01.
//  Copyright © 2020 송지훈. All rights reserved.
//


// 책 카테고리 정하고  >> 질문 정하고 >> 작성하는 부분까지 담당하는 뷰컨



import UIKit
import RealmSwift
import Photos
import FlexColorPicker

class BookWriteViewController: UIViewController {
    

    
    // MARK: - IBOutlet
    @IBOutlet weak var writeTitleLabel: UILabel!
    @IBOutlet weak var writeDirectiveLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var setImageButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextView!
    @IBOutlet weak var colorPickButton: UIButton!
    
    
    // MARK: - Variables
    var bookItems : List<BookDataModelList>?
    let realm = try! Realm()
    let imagePicker = UIImagePickerController()
    let datePicker = UIDatePicker()
    var dateString = String()

    // Storing Data
    var willStoreColor: String?
    var willStoreImage: Data?
    var willStoreCategoryName: String?
    var willStoreQuestionName: String?
    

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fontSetting()
        buttonSetting()
        defaultSetting()
        
        setDataPicker()
        
        contentTextField.delegate = self
        imagePicker.delegate = self
        
        dateTextField.delegate = self
        titleTextField.delegate = self
        locationTextField.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(questionDataReceived), name: NSNotification.Name("clickedQuestionCell"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(colorDataReceived), name: NSNotification.Name("clickedColorCell"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(categoryDataReceived), name: NSNotification.Name("clickedCategoryCell"), object: nil)
        
    }
    
    @objc func questionDataReceived(notification : NSNotification)
    {
        let receivedString = notification.object as? String ?? ""
        self.questionLabel.text = receivedString
        willStoreQuestionName = receivedString
    }
    
    @objc func categoryDataReceived(notification : NSNotification)
    {
        let receivedCategoryData = notification.object as? String ?? ""
//        self.questionLabel.text = receivedString
        willStoreCategoryName = receivedCategoryData
    }
    
    @objc func colorDataReceived(notification : NSNotification)
    {
        var receivedColorData = notification.object as? String ?? "#FFFFFF"
        receivedColorData = "#"+receivedColorData
        self.willStoreColor = receivedColorData
        colorPickButton.backgroundColor = UIColor(hexString: receivedColorData)
    }
    
    
    func fontSetting() {
        self.writeTitleLabel.font = UIFont(name: "BareunBatangOTFPro-1", size: 18)
        self.writeDirectiveLabel.font = UIFont(name: "BareunBatangOTFPro-2", size: 20)
        self.categoryButton.titleLabel?.font = UIFont(name: "BareunBatangOTFPro-1", size: 13)
        self.setImageButton.titleLabel?.font = UIFont(name: "BareunBatangOTFPro-1", size: 13)
        self.questionLabel.font = UIFont(name: "BareunBatangOTFPro-2", size: 18)
        
        self.titleTextField.font = UIFont(name: "BareunBatangOTFPro-2", size: 18)
        self.dateTextField.font = UIFont(name: "BareunBatangOTFPro-2", size: 15)
        self.locationTextField.font = UIFont(name: "BareunBatangOTFPro-2", size: 15)
        self.contentTextField.font = UIFont(name: "BareunBatangOTFPro-2", size: 15)
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
        
        colorPickButton.layer.cornerRadius = 14
        colorPickButton.layer.shadowColor = UIColor.black.cgColor
        colorPickButton.layer.shadowRadius = 10
        colorPickButton.layer.shadowOpacity = 0.16
        colorPickButton.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func defaultSetting() {
        imageView.backgroundColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1)
        imageView.layer.cornerRadius = 11
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 22
        imageView.layer.shadowOpacity = 0.16
        imageView.layer.shadowOffset = CGSize(width: 0, height: 8)
    }

    
    func setDataPicker()
   {
       datePicker.datePickerMode = .date
       dateTextField.tintColor = .clear
    
       datePicker.preferredDatePickerStyle = .wheels
       
       
       
       let toolbar = UIToolbar();
       toolbar.sizeToFit()
       
       //done button & cancel button
       let doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(donedatePicker))
       let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
       let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelDatePicker))
       toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
       
       
       dateTextField.inputAccessoryView = toolbar
       dateTextField.inputView = datePicker
   }
           
           
        
           
           
        @objc func donedatePicker(){
            let formatter = DateFormatter()
            let formatter1 = DateFormatter()
            
            
            formatter.timeZone = TimeZone.current
            formatter1.timeZone = TimeZone.current

            
            formatter.dateFormat = "yyyy년 MM월 dd일"
            formatter1.dateFormat = "yyyy-MM-dd"
            
            self.dateString = formatter1.string(from: datePicker.date)
            dateTextField.text = formatter.string(from: datePicker.date)
            self.view.endEditing(true)
            
        }
        
        @objc func cancelDatePicker(){
            self.view.endEditing(true)
        }
    
    // MARK: - IBAction
    
    // 뒤로 가기 버튼
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // 완료 버튼
    @IBAction func completeButtonClicked(_ sender: Any) {
        let book = BookDataModelList()
        
        book.title = titleTextField.text ?? ""
        book.content = contentTextField.text
        book.time = dateTextField.text ?? ""
        book.location = locationTextField.text ?? ""
        book.color = willStoreColor ?? "#707070"
        book.bookCoverPhoto = willStoreImage ?? Data()
        
        book.questionName = willStoreQuestionName ?? String()
        book.categoryName = willStoreCategoryName ?? String()

        
        try! self.realm.write {
            self.realm.add(book)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // 카테고리 선택 버튼
    @IBAction func categoryButtonClicked(_ sender: Any) {
        
        guard let categoryVC = self.storyboard?.instantiateViewController(identifier: "BookCategoryViewController") as? BookCategoryViewController else {return}
        
        categoryVC.modalPresentationStyle = .fullScreen
        present(categoryVC, animated: true, completion: nil)
        
        
    }
    
    // 표지 선택 버튼
    @IBAction func photoAddButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "" , message: "인증 방식을 선택해주세요", preferredStyle: .actionSheet)
                
                let cameraAction = UIAlertAction(title: "카메라로 찍기", style: .default) { (_) in
                    
                    self.imagePicker.sourceType = .camera
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
                
                let galleryAction = UIAlertAction(title: "갤러리에서 선택하기", style: .default) { (_) in
                    
                    self.imagePicker.sourceType = .photoLibrary
                    self.present(self.imagePicker, animated: true, completion: nil)
                    

                }
                
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                
                alert.addAction(cameraAction)
                alert.addAction(galleryAction)
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func pickColorButtonClicked(_ sender: Any) {
        let colorPickerController = DefaultColorPickerViewController()
        
        colorPickerController.delegate = self
        
        guard let bookColorViewController = self.storyboard?.instantiateViewController(identifier: "BookColorViewController") as? BookColorViewController else {return}
        
        bookColorViewController.modalPresentationStyle = .automatic
        present(bookColorViewController, animated: true, completion: nil)

        
    }
    
}

// MARK: - textField delegate
extension BookWriteViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("textfield clicked")
        
        dateTextField.inputView = datePicker

    }
    
    
}


// MARK: - textView delegate
extension BookWriteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        contentTextField.text = ""
    }
}


// MARK: - pick image
extension BookWriteViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
        guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
        
        let imageData = image.pngData()
        willStoreImage = imageData
        
        self.imageView.image = image
        
//        print(type(of: imageData))
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - pick color
// MyController is the controller that presents DefaultColorPickerViewController
extension BookWriteViewController: ColorPickerDelegate {

    func colorPicker(_ colorPicker: ColorPickerController, selectedColor: UIColor, usingControl: ColorControl) {
        // code to handle that user selected a color without confirmed it yet (may change selected color)
        
    }
    
    func colorPicker(_ colorPicker: ColorPickerController, confirmedColor: UIColor, usingControl: ColorControl) {
        // code to handle that user has confirmed selected color

    }
}


// MARK: - Convert Hex Value
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}



