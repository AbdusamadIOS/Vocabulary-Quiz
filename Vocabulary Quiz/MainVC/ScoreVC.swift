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
   
    var result: Result?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        refreshBtn.layer.cornerRadius = 12
        homeBtn.layer.cornerRadius = 12
  
        let vc = MainVC(nibName: "MainVC", bundle: nil)
        vc.closure = { [self] task in
            resultLbl.text = String("\(task)")
            print("ddsdsssddddddddd======\(task)")
        }
            
//            if result <= 14 {
//                scoreImg.image = UIImage(named: "bad")
//                firstStarimg.image = UIImage(systemName: "star.fill")
//                secondStarImg.image = UIImage(systemName: "star")
//                thredStarImg.image = UIImage(systemName: "star")
//            } else if result <= 17 {
//                scoreImg.image = UIImage(named: "good")
//                firstStarimg.image = UIImage(systemName: "star.fill")
//                secondStarImg.image = UIImage(systemName: "star.fill")
//                thredStarImg.image = UIImage(systemName: "star")
//            } else if result <= 20 {
//                scoreImg.image = UIImage(named: "nice")
//                firstStarimg.image = UIImage(systemName: "star.fill")
//                secondStarImg.image = UIImage(systemName: "star.fill")
//                thredStarImg.image = UIImage(systemName: "star.fill")
//            }
        }
    func setupNavBar() {
        navigationItem.title = "Result!"
        let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold) ]
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
