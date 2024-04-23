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
    @IBOutlet weak var yakunlashBtn: UIButton!
    
    var currentQuestion: QuestionModel?
    var timer: Timer?
    var sum = 0
    var theEnd = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTCollectionViewAndViewUpdate()
        configureUi(question: Datas.list.filter{ $0.type == .test }.first!)
        setupNavBar()
        progressTime()
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    // TODO: TableView Delegate and DataSource
    func setupTCollectionViewAndViewUpdate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AnswersCell", bundle: nil), forCellWithReuseIdentifier: "AnswersCell")
        conteneirView.layer.cornerRadius = 15
        conteneirView.clipsToBounds = true
        nextBtn.layer.cornerRadius = 7
        yakunlashBtn.layer.cornerRadius = 7
        timePV.layer.cornerRadius = 4
    }
    // TODO: Configure Ui Update
    private func configureUi(question: QuestionModel) {
        questionLbl.text = question.question
        currentQuestion = question
        numberLabel.text = "\(theEnd)"
    }
    // TODO: Yakunlash Button
    @IBAction func yakunlashBtn(_ sender: UIButton) {
        timer?.invalidate()
        let scoreVC = ScoreVC(nibName: "ScoreVC", bundle: nil)
        scoreVC.result = sum
        scoreVC.number = theEnd
        self.navigationController?.setViewControllers([scoreVC], animated: true)
    }
    // TODO: Next Button
    @IBAction func nextBtn(_ sender: UIButton) {
        timePV.progress = timePV.progress - 1
        if timePV.progress == 0 {
            print("tugadi va keyingi savol")
            let question = currentQuestion
            _ = question?.answers
            if let index = Datas.list.firstIndex(where: { $0.answers == question?.answers}) {
                if index < (Datas.list.count - 1) {
                    let nextQuestion = Datas.list[index + 11]
                    theEnd += 1
                    currentQuestion = nil
                    configureUi(question: nextQuestion)
                    timePV.progress = 1
                    collectionView.reloadData()
                } else {
                    timer?.invalidate()
                    collectionView.reloadData()
                    let scoreVC = ScoreVC(nibName: "ScoreVC", bundle: nil)
                    scoreVC.result = sum
                    scoreVC.number = theEnd
                    self.navigationController?.setViewControllers([scoreVC], animated: true)
                }
            }
        }
    }
    // TODO: ProgressView time and setting
    func progressTime() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeBtn), userInfo: nil, repeats: true)
    }
    // Time Button
    @objc func timeBtn() {
        timePV.progress = timePV.progress - 0.12
        if timePV.progress == 0 {
            print("tugadi va keyingi savol")
            print(theEnd)
            let question = currentQuestion
            _ = question?.answers
            if let index = Datas.list.firstIndex(where: { $0.answers == question?.answers}) {
                if index < (Datas.list.count - 1) {
                    let nextQuestion = Datas.list[index + 11]
                    currentQuestion = nil
                    theEnd += 1
                    configureUi(question: nextQuestion)
                    timePV.progress = 1
                    collectionView.reloadData()
            } else {
                    timer?.invalidate()
                    collectionView.reloadData()
                    let scoreVC = ScoreVC(nibName: "ScoreVC", bundle: nil)
                    scoreVC.result = sum
                    scoreVC.number = theEnd
                    self.navigationController?.setViewControllers([scoreVC], animated: true)
                }
            }
        }
    }
}
// MARK: Extension CollectionViewDataSourche and CollectionViewDelegate
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
        guard let question = currentQuestion else {
            return
        }
        
        let answer = Datas.list.first?.answers?[indexPath.row]
        if Datas.list[indexPath.row].answer == answer {
            //             correct answer
            if let index = Datas.list.firstIndex(where: { $0.answers == question.answers}) {
                if index < (Datas.list.count - 1) {
                    sum += 1
                    theEnd += 1
                    let nextQuestion = Datas.list[index + 11]
                    currentQuestion = nil
                    configureUi(question: nextQuestion)
                    collectionView.reloadData()
                    timePV.progress = 1
                } else {
                    timer?.invalidate()
                    let scoreVC = ScoreVC(nibName: "ScoreVC", bundle: nil)
                    scoreVC.result = sum
                    scoreVC.number = theEnd
                    self.navigationController?.setViewControllers([scoreVC], animated: true)
                }
            }
        } else {
            // Wrong answer
            if let index = Datas.list.firstIndex(where: { $0.answers == question.answers}) {
                if index < (Datas.list.count - 1) {
                    let nextQuestion = Datas.list[index + 11]
                    currentQuestion = nil
                    theEnd += 1
                    configureUi(question: nextQuestion)
                    collectionView.reloadData()
                    timePV.progress = 1
                } else {
                    timer?.invalidate()
                    let scoreVC = ScoreVC(nibName: "ScoreVC", bundle: nil)
                    scoreVC.result = sum
                    scoreVC.number = theEnd
                    self.navigationController?.setViewControllers([scoreVC], animated: true)
                }
            }
        }
    }
}

