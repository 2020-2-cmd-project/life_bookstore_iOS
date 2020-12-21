//
//  BookColorViewController.swift
//  life_bookstore
//
//  Created by taehy.k on 2020/12/19.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import FlexColorPicker

class BookColorViewController: DefaultColorPickerViewController {

//    @IBOutlet weak var colorPreviewView: ColorPreviewWithHex!
//    @IBOutlet weak var colorPickerView: ColorPaletteControl!
    
    //MARK: - Variables
    var myChosenColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

    }

    
    //MARK: - IBAction
    
    @IBAction func completeButtonClicked(_ sender: Any) {
        
        let colorValue = myChosenColor?.hexValue()
        
        print(type(of: colorValue))
        print(colorValue ?? "707070")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "clickedColorCell"), object: colorValue)

        
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - pick color
// MyController is the controller that presents DefaultColorPickerViewController
extension BookColorViewController: ColorPickerDelegate {

    func colorPicker(_ colorPicker: ColorPickerController, selectedColor: UIColor, usingControl: ColorControl) {
        // code to handle that user selected a color without confirmed it yet (may change selected color)
//        print("aaaaaa")
        self.myChosenColor = selectedColor
    }
    
    func colorPicker(_ colorPicker: ColorPickerController, confirmedColor: UIColor, usingControl: ColorControl) {
        // code to handle that user has confirmed selected color
        print("완료")
        self.myChosenColor = confirmedColor
        
    }
}
