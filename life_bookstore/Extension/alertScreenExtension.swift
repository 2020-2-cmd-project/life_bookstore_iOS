//
//  alertScreenExtension.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/10/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

// 알림창 쉽게 만들수 있도록 함수 생성해둠
import Foundation
import UIKit

public func makeAlert(title : String, message : String, vc : UIViewController)
{
    let alertViewController = UIAlertController(title: title, message: message,
                                                preferredStyle: .alert)
    let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
    alertViewController.addAction(action)
    vc.present(alertViewController, animated: true, completion: nil)
}

