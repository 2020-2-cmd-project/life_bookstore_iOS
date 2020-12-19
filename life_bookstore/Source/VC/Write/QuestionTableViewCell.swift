//
//  QuestionTableViewCell.swift
//  life_bookstore
//
//  Created by taehy.k on 2020/12/19.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var questionContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(content : String)
    {
        self.questionContentLabel.text = content
    }
    
}
