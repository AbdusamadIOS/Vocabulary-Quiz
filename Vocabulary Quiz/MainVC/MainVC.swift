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
    var round = 0
    var list = Datas.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressTime()
        setupTCollectionViewAndViewUpdate()
        genereteQuiz()
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupTCollectionViewAndViewUpdate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AnswersCell", bundle: nil), forCellWithReuseIdentifier: "AnswersCell")
        conteneirView.layer.cornerRadius = 15
        conteneirView.clipsToBounds = true
        questionLbl.layer.cornerRadius = 10
        questionLbl.clipsToBounds = true
        nextBtn.layer.cornerRadius = 7
        timePV.layer.cornerRadius = 4
    }
    
    private func genereteQuiz() {
        let index = (0..<list.count).randomElement() ?? 0
        currentQuestion = list[index]
        list.remove(at: index)
        currentQuestion?.answers?.shuffle()
        updateUi()
    }
    
    private func updateUi() {
        var sentence = currentQuestion?.question
        sentence = sentence?.replacingOccurrences(of: "<strong>", with: "").replacingOccurrences(of: "</strong>", with: "")
        questionLbl.text = sentence
        questionLbl.adjustsFontSizeToFitWidth = true
        numberLabel.text = "\(round)"
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
        timePV.progress = timePV.progress - 0.085
        if timePV.progress == 0 {
            timePV.progress = 1
            questionAndAnswers()
            print("vaqt tugati")
        }
    }
    
    func questionAndAnswers() {
        if view.backgroundColor == UIColor.systemGreen || view.backgroundColor == UIColor.systemRed {
            view.backgroundColor = .bg
        }
        
        round += 1
        genereteQuiz()
        
        if round == 20 {
            timer?.invalidate()
            collectionView.reloadData()
            let score = ScoreVC(nibName: "ScoreVC", bundle: nil)
            score.result = sum
            navigationController?.setViewControllers([score], animated: true)
        }
    }
    
    func checkAnswer(_ userAnswer: String?) {
        
        if currentQuestion?.answer == userAnswer {
            sum += 1
            timePV.progress = 1
            questionAndAnswers()
            changeBackgroundColorTemporarily(view: view, toColor: .green, duration: 0.1)
            print("togri javob")
        } else {
            timePV.progress = 1
            questionAndAnswers()
            changeBackgroundColorTemporarily(view: view, toColor: .red, duration: 0.1)
            print("xato javob")
        }
    }
    
    func changeBackgroundColorTemporarily(view: UIView, toColor color: UIColor, duration: TimeInterval) {
        
        let originalColor = UIColor.white
        UIView.animate(withDuration: 0.1, animations: {
            self.conteneirView.backgroundColor = color
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                UIView.animate(withDuration: 0.1) {
                    self.conteneirView.backgroundColor = originalColor
                }
            }
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
        
        let cell = collectionView.cellForItem(at: indexPath) as? AnswersCell
        let userAnswer = cell?.textLbl.text
        checkAnswer(userAnswer)
    }
}
