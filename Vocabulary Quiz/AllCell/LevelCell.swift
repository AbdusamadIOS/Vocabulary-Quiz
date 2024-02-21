//
//  LevelCell.swift
//  Vocabulary Quiz
//
//  Created by Abdusamad Mamasoliyev on 02/02/24.
//

import UIKit

class LevelCell: UICollectionViewCell {

    @IBOutlet weak var conteneirView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        conteneirView.layer.cornerRadius = 20
    }

}
