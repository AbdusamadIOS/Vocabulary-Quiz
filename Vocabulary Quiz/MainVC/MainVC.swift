//
//  MainVC.swift
//  Vocabulary Quiz
//
//  Created by Abdusamad Mamasoliyev on 19/01/24.
//

import UIKit
import Foundation

class MainVC: UIViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var conteneirView: UIView!
    @IBOutlet weak var timePV: UIProgressView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentQuestion: QuestionModel?
    var timer: Timer?
    var sum = 0
    var theEnd = 0
    var list = Datas.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressTime()
        setupTCollectionViewAndViewUpdate()
        configureUi()
        navigationController?.navigationBar.isHidden = true
    }
   
    func setupTCollectionViewAndViewUpdate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AnswersCell", bundle: nil), forCellWithReuseIdentifier: "AnswersCell")
        conteneirView.layer.cornerRadius = 15
        conteneirView.clipsToBounds = true
        nextBtn.layer.cornerRadius = 7
        timePV.layer.cornerRadius = 4
    }
    
    private func configureUi() {
        let index = (0..<list.count).randomElement() ?? 0
        questionLbl.text = list[index].question
        questionLbl.adjustsFontSizeToFitWidth = true
        currentQuestion = list[index]
        list.remove(at: index)
        numberLabel.text = "\(theEnd)"
        collectionView.reloadData()
    }
    
    @IBAction func nextBtn(_ sender: UIButton) {
        timePV.progress = 1
        questionAndAnswers()
        print("keyingi savolga o'tildi")
    }
    
    func progressTime() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeBtn), userInfo: nil, repeats: true)
    }
    
    @objc func timeBtn() {
        timePV.progress = timePV.progress - 0.12
        if timePV.progress == 0 {
            timePV.progress = 1
            questionAndAnswers()
            print("vaqt tugati")
        }
    }
    
    func questionAndAnswers() {
        theEnd += 1
        configureUi()
        collectionView.reloadData()
        if theEnd == 20 {
            timer?.invalidate()
            collectionView.reloadData()
            let score = ScoreVC(nibName: "ScoreVC", bundle: nil)
            score.result = sum
            navigationController?.setViewControllers([score], animated: true)
        }
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentQuestion?.answers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswersCell", for: indexPath) as! AnswersCell
        
        cell.textLbl.text = currentQuestion?.answers?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height - 60) / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let answer = Datas.list.first?.answers?[indexPath.row]
        if Datas.list[indexPath.row].answer == answer {
            sum += 1
            timePV.progress = 1
            questionAndAnswers()
            print("togri javob")
        } else {
            timePV.progress = 1
            questionAndAnswers()
            print("xato javob")
        }
    }
}
