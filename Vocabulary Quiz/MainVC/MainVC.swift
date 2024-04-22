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
    
    var currentQuestion: QuestionModel?
    var timer: Timer?
    var sum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTCollectionView()
        configureUi(question: Datas.list.filter{ $0.type == .test }.first!)
        setupNavBar()
        progressTime()
        conteneirView.layer.cornerRadius = 15
        conteneirView.clipsToBounds = true
        nextBtn.layer.cornerRadius = 7
        timePV.layer.cornerRadius = 4
    }
    func setupNavBar() {
        navigationItem.title = "Question"
        navigationItem.hidesBackButton = true
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold) ]
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(backBtn))
        back.tintColor = .white
        navigationItem.leftBarButtonItem = back
    }
    @objc func backBtn() {
        
        timer?.invalidate()
        print("back")
        self.navigationController?.popViewController(animated: true)
    }
    
    // TODO: TableView Delegate and DataSource
    func setupTCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AnswersCell", bundle: nil), forCellWithReuseIdentifier: "AnswersCell")
        
    }
    
    // TODO: Configure Ui Update
    private func configureUi(question: QuestionModel) {
        questionLbl.text = question.question
        nounLbl.text = ""
        currentQuestion = question
        
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
                    currentQuestion = nil
                    configureUi(question: nextQuestion)
                    timePV.progress = 1
                    collectionView.reloadData()
                } else {
                    timer?.invalidate()
                    collectionView.reloadData()
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
        timePV.progress = timePV.progress - 0.12
        if timePV.progress == 0 {
            print("tugadi va keyingi savol")
            let question = currentQuestion
            _ = question?.answers
            if let index = Datas.list.firstIndex(where: { $0.answers == question?.answers}) {
                if index < (Datas.list.count - 11) {
                    let nextQuestion = Datas.list[index + 11]
                    currentQuestion = nil
                    configureUi(question: nextQuestion)
                    timePV.progress = 1
                    collectionView.reloadData()
                } else {
                    timer?.invalidate()
                    collectionView.reloadData()
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
        return Datas.list.first?.answers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswersCell", for: indexPath) as! AnswersCell
        cell.textLbl.text = Datas.list.first?.answers?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height - 80) / 3)
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
                    let nextQuestion = Datas.list[index + 11]
                    currentQuestion = nil
                    configureUi(question: nextQuestion)
                    collectionView.reloadData()
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
            if let index = Datas.list.firstIndex(where: { $0.answers == question.answers}) {
                if index < (Datas.list.count - 1) {
                    let nextQuestion = Datas.list[index + 1]
                    currentQuestion = nil
                    configureUi(question: nextQuestion)
                    collectionView.reloadData()
                    timePV.progress = 1
                }
            }
        }
    }
}

