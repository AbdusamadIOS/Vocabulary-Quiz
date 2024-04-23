//
//  ScoreVC.swift
//  Vocabulary Quiz
//
//  Created by Abdusamad Mamasoliyev on 02/02/24.
//

import UIKit

class ScoreVC: UIViewController {

    @IBOutlet weak var scoreImg: UIImageView!
    @IBOutlet weak var firstStarimg: UIImageView!
    @IBOutlet weak var secondStarImg: UIImageView!
    @IBOutlet weak var thredStarImg: UIImageView!
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    
    var number = 0
    var result = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        refreshBtn.layer.cornerRadius = 12
        homeBtn.layer.cornerRadius = 12
        let allNumber = number - 1
        resultLbl.text = "\(result)"
        numberLbl.text = "\(allNumber)"
        let bad = Double(number) * 0.6
        let good = Double(number) * 0.8
        
                if result <= Int(bad) {
                scoreImg.image = UIImage(named: "bad")
                navigationItem.title = "Bad!"
                firstStarimg.image = UIImage(systemName: "star.fill")
                secondStarImg.image = UIImage(systemName: "star")
                thredStarImg.image = UIImage(systemName: "star")
            } else if result <= Int(good) {
                navigationItem.title = "Good!"
                scoreImg.image = UIImage(named: "good")
                firstStarimg.image = UIImage(systemName: "star.fill")
                secondStarImg.image = UIImage(systemName: "star.fill")
                thredStarImg.image = UIImage(systemName: "star")
            } else if result <= number {
                navigationItem.title = "Very Good!"
                scoreImg.image = UIImage(named: "nice")
                firstStarimg.image = UIImage(systemName: "star.fill")
                secondStarImg.image = UIImage(systemName: "star.fill")
                thredStarImg.image = UIImage(systemName: "star.fill")
            }
        }
    func setupNavBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold) ]
            navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }
    
    @IBAction func refreshBtn(_ sender: UIButton) {
        
        let main = MainVC(nibName: "MainVC", bundle: nil)
        self.navigationController?.setViewControllers([main], animated: true)
    }
    
    @IBAction func homeBtn(_ sender: UIButton) {
        
        let home = WelcomeVC(nibName: "WelcomeVC", bundle: nil)
        
        self.navigationController?.setViewControllers([home], animated: true)
    }
}
