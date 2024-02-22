//
//  MainVC.swift
//  Vocabulary Quiz
//
//  Created by Abdusamad Mamasoliyev on 19/01/24.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var nounLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var conteneirView: UIView!
    @IBOutlet weak var timePV: UIProgressView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentQuestion: Question?
    var timer: Timer?
    var sum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTCollectionView()
        configureUi(question: UnitB1.vocubularies.first!)
        setupNavBar()
        progressTime()
        conteneirView.layer.cornerRadius = 15
        conteneirView.clipsToBounds = true
        nextBtn.layer.cornerRadius = 7
        timePV.layer.cornerRadius = 4
    
    }
    func setupNavBar() {
        navigationItem.hidesBackButton = true
        navigationItem.title = "Question"
        let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold) ]
            navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }
    
    // TODO: TableView Delegate and DataSource
    func setupTCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AnswersCell", bundle: nil), forCellWithReuseIdentifier: "AnswersCell")
        
    }
    // TODO: Check Answer function
    private func checkAnswer(answer: Answer, question: Question) -> Bool {
        return question.answers.contains(where: { $0.text == answer.text }) && answer.correct
        
        }
    // TODO: Configure Ui Update
    private func configureUi(question: Question) {
        questionLbl.text = question.text
        nounLbl.text = question.noun
        currentQuestion = question
        collectionView.reloadData()
    
    }
    // TODO: Next Button
    @IBAction func nextBtn(_ sender: UIButton) {
        timePV.progress = timePV.progress - 1
        if timePV.progress == 0 {
            print("tugadi va keyingi savol")
           let question = currentQuestion
            _ = question?.answers
            if let index = UnitB1.vocubularies.firstIndex(where: { $0.text == question?.text}) {
                if index < (UnitB1.vocubularies.count - 1) {
                    let nextQuestion = UnitB1.vocubularies[index + 1]
                    currentQuestion = nil
                    configureUi(question: nextQuestion)
                    timePV.progress = 1
                } else {
                    timer?.invalidate()
                    let scoreVC = ScoreVC(nibName: "ScoreVC", bundle: nil)
                    scoreVC.result = sum
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
        timePV.progress = timePV.progress - 0.11
        if timePV.progress == 0 {
            print("tugadi va keyingi savol")
           let question = currentQuestion
            _ = question?.answers
            if let index = UnitB1.vocubularies.firstIndex(where: { $0.text == question?.text}) {
                if index < (UnitB1.vocubularies.count - 1) {
                    let nextQuestion = UnitB1.vocubularies[index + 1]
                    currentQuestion = nil
                    configureUi(question: nextQuestion)
                    timePV.progress = 1
                } else {
                    timer?.invalidate()
                    let scoreVC = ScoreVC(nibName: "ScoreVC", bundle: nil)
                    scoreVC.result = sum
                    self.navigationController?.setViewControllers([scoreVC], animated: true)
                }
            }
        }
    }
}
// MARK: Extension CollectionViewDataSourche and CollectionViewDelegate
extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswersCell", for: indexPath) as! AnswersCell
        cell.textLbl.text = currentQuestion?.answers[indexPath.row].text
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height - 80) / 3)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let question = currentQuestion else {
            return
        }
        
        let answer = question.answers[indexPath.row]
        
        if checkAnswer(answer: answer, question: question) {
            // correct answer
            if let index = UnitB1.vocubularies.firstIndex(where: { $0.text == question.text}) {
                if index < (UnitB1.vocubularies.count - 1) {
                    sum += 1
                    let nextQuestion = UnitB1.vocubularies[index + 1]
                    currentQuestion = nil
                    configureUi(question: nextQuestion)
                    timePV.progress = 1
                   
                } else {
                    timer?.invalidate()
                    let scoreVC = ScoreVC(nibName: "ScoreVC", bundle: nil)
                    scoreVC.result = sum
                    self.navigationController?.setViewControllers([scoreVC], animated: true)
                }
            }
        } else {
            // Wrong answer
            if let index = UnitB1.vocubularies.firstIndex(where: { $0.text == question.text}) {
                if index < (UnitB1.vocubularies.count - 1) {
                    let nextQuestion = UnitB1.vocubularies[index + 1]
                    currentQuestion = nil
                    configureUi(question: nextQuestion)
                    timePV.progress = 1
                    
                }
            }
        }
    }
}
struct Question {
    let text: String
    let noun: String
    let answers: [Answer]
    
}
struct Answer {
    let text: String
    let correct: Bool
}


