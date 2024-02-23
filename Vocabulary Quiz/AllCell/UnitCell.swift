//
//  UnitCell.swift
//  Vocabulary Quiz
//
//  Created by Abdusamad Mamasoliyev on 23/02/24.
//

import UIKit

class UnitCell: UITableViewCell {

    @IBOutlet weak var conteneirView: UIView!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star1: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        conteneirView.layer.cornerRadius = 10
        conteneirView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
