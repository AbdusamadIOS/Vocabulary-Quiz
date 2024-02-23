//
//  WelcomeVC.swift
//  Vocabulary Quiz
//
//  Created by Abdusamad Mamasoliyev on 08/02/24.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let text: [Text] = [Text(title: "Beginner"),
                        Text(title: "Elementary"),
                        Text(title: "Pre-intermediate"),
                        Text(title: "Intermediate"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        setupColView()
        setupNavBar()
    }

    func setupColView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "LevelCell", bundle: nil), forCellWithReuseIdentifier: "LevelCell")
        collectionView.layer.cornerRadius = 20
    }
    func setupNavBar() {
        navigationItem.title = "Vocabulary Quiz"
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                       NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold) ]
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }

}

extension WelcomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelCell", for: indexPath) as! LevelCell
        cell.titleLbl.text = text[indexPath.item].title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width:(collectionView.frame.width - 60) / 2,
                          height: (collectionView.frame.height - 60) / 2 )
        
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let unit = UnitVC(nibName: "UnitVC", bundle: nil)
        unit.leves = text[indexPath.item]
        self.navigationController?.pushViewController(unit, animated: true)
    }
    
}
