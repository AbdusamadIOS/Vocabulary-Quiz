//
//  WelcomeVC.swift
//  Vocabulary Quiz
//
//  Created by Abdusamad Mamasoliyev on 08/02/24.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var beginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        beginBtn.layer.cornerRadius = 10
        beginBtn.clipsToBounds = true
    }

    @IBAction func beginBtn(_ sender: Any) {
        let vc = MainVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    func setupNavBar() {
        navigationItem.title = "Vocabulary Quiz"
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: 
                                                    UIColor.white,
                                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold) ]
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }

}

