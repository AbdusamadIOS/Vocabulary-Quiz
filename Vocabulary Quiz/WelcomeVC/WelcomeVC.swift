//
//  WelcomeVC.swift
//  Vocabulary Quiz
//
//  Created by Abdusamad Mamasoliyev on 08/02/24.
//

import UIKit

class WelcomeVC: AnimationView {
    
    @IBOutlet weak var beginBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var results = [Result]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        beginBtn.layer.cornerRadius = 10
        beginBtn.clipsToBounds = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "WelcomeVCCell", bundle: nil), forCellReuseIdentifier: "WelcomeVCCell")
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        fetchCoreData()
    }
    
     func fetchCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            results = try context.fetch(Result.fetchRequest()) as? [Result] ?? []
            results = results.reversed()
        } catch {
            print("error-Fetching data")
            errorAlert("error-Fetching data")
        }
    }
    
    @IBAction func beginBtn(_ sender: UIButton) {
        animateView(sender)
        let vc = MainVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    func setupNavBar() {
        navigationItem.title = "Quiz"
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:
                                                        UIColor.white,
                                                       NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold) ]
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        
        let time = UIBarButtonItem(image: UIImage(systemName: "deskclock"), style: .done, target: self, action: #selector(timeTap))
        time.tintColor = .white
        navigationItem.rightBarButtonItem = time
    }
    
    @objc func timeTap() {
        
        let vc = TimeAndQuestionVC(nibName: "TimeAndQuestionVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WelcomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WelcomeVCCell", for: indexPath) as? WelcomeVCCell else { return UITableViewCell() }
        
        let relust = results[indexPath.row]
        cell.dateLabel.text = relust.date
        cell.answerLabel.text = relust.answer
        cell.questionLabel.text = relust.question
        cell.timeLabel.text = relust.vaqt
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
