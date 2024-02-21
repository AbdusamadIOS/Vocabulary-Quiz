//
//  AnswersCell.swift
//  Vocabulary Quiz
//
//  Created by Abdusamad Mamasoliyev on 12/02/24.
//

import UIKit

class AnswersCell: UICollectionViewCell {

    @IBOutlet weak var conteneirView: UIView!
    @IBOutlet weak var textLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        conteneirView.layer.cornerRadius = 15
        conteneirView.layer.borderColor = UIColor.white.cgColor
        conteneirView.layer.borderWidth = 0.8
        
    }

}
