//
//  TimeAndQuestionVC.swift
//  Vocabulary Quiz
//
//  Created by Abdusamad Mamasoliyev on 20/05/24.
//

import UIKit

class TimeAndQuestionVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ortaTime: UIButton!
    @IBOutlet weak var sekinTime: UIButton!
    @IBOutlet weak var tezTime: UIButton!
    @IBOutlet weak var saqlashButton: UIButton!
    
    var questionsCount: [QuestionDataModel] = [QuestionDataModel(title: "10"),
                                               QuestionDataModel(title: "15"),
                                               QuestionDataModel(title: "20"),
                                               QuestionDataModel(title: "30"),
                                               QuestionDataModel(title: "50"),
                                               QuestionDataModel(title: "70"),
    ]
    
    var timeCount: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonSetting()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AnswersCell", bundle: nil), forCellWithReuseIdentifier: "AnswersCell")
        
    }
    
    func buttonSetting() {
        
        ortaTime.layer.cornerRadius = 10
        ortaTime.clipsToBounds = true
        ortaTime.layer.borderColor = UIColor.white.cgColor
        ortaTime.layer.borderWidth = 0.6
        sekinTime.layer.cornerRadius = 10
        sekinTime.clipsToBounds = true
        sekinTime.layer.borderColor = UIColor.white.cgColor
        sekinTime.layer.borderWidth = 0.6
        tezTime.layer.cornerRadius = 10
        tezTime.clipsToBounds = true
        tezTime.layer.borderColor = UIColor.white.cgColor
        tezTime.layer.borderWidth = 0.6
        saqlashButton.layer.cornerRadius = 10
        saqlashButton.clipsToBounds = true
        saqlashButton.layer.borderColor = UIColor.white.cgColor
        saqlashButton.layer.borderWidth = 0.6
    }
    
    @IBAction func saqlashButtom(_ sender: UIButton) {
        
        let vc = MainVC(nibName: "MainVC", bundle: nil)
        vc.timaCount = timeCount
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sekinButton(_ sender: UIButton) {
        timeCount = 0.04
    }
    
    @IBAction func ortaButton(_ sender: UIButton) {
        timeCount = 0.08
    }
    
    @IBAction func tezButton(_ sender: UIButton) {
        timeCount = 0.12
    }
}

extension TimeAndQuestionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionsCount.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswersCell", for: indexPath) as! AnswersCell
        cell.textLbl.text = questionsCount[indexPath.item].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widht = (collectionView.frame.width - 30) / 3
        let height = (collectionView.frame.height - 15) / 2
        return CGSize(width: widht, height: height)
    }
}
