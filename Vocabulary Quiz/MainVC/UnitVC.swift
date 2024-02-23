//
//  UnitVC.swift
//  Vocabulary Quiz
//
//  Created by Abdusamad Mamasoliyev on 02/02/24.
//

import UIKit

class UnitVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var units: [Unit] = [Unit(text: "Unit 1"),
                         Unit(text: "Unit 2"),
                         Unit(text: "Unit 3"),
                         Unit(text: "Unit 4"),
                         Unit(text: "Unit 5"),
                         Unit(text: "Unit 6"),
                         Unit(text: "Unit 7"),
                         Unit(text: "Unit 8"),
                         Unit(text: "Unit 9"),
                         Unit(text: "Unit 10"),
                         Unit(text: "Unit 11"),
                         Unit(text: "Unit 12"),
                         Unit(text: "Unit 13"),
                         Unit(text: "Unit 14"),
                         Unit(text: "Unit 15"),
                         Unit(text: "Unit 16"),
                         Unit(text: "Unit 17"),
                         Unit(text: "Unit 18"),
                         Unit(text: "Unit 19"),
                         Unit(text: "Unit 20"),
                         Unit(text: "Unit 21"),
                         Unit(text: "Unit 22"),
                         Unit(text: "Unit 23"),
                         Unit(text: "Unit 24"),
                         Unit(text: "Unit 25"),
                         Unit(text: "Unit 26"),
                         Unit(text: "Unit 27"),
                         Unit(text: "Unit 28"),
                         Unit(text: "Unit 29"),
                         Unit(text: "Unit 30")]
    var leves: Text?
    override func viewDidLoad() {
        super.viewDidLoad()

      setupTableView()
      setupNavBar()
    }
    func setupNavBar() {
        navigationItem.backButtonTitle = "back"
        navigationItem.title = leves?.title
        navigationController?.navigationBar.tintColor = .white
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(named: "bg")
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold) ]
            navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "UnitCell", bundle: nil), forCellReuseIdentifier: "UnitCell")
    }
}

extension UnitVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leves?.title == "Beginner" {
           
            1
        } else {
            0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UnitCell", for: indexPath) as! UnitCell
        cell.textLbl.text = units[indexPath.row].text
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainVC = MainVC(nibName: "MainVC", bundle: nil)
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rotationTransfer = CATransform3DTranslate(CATransform3DIdentity, -60, -60, -60)
        cell.layer.transform = rotationTransfer
        cell.alpha = 0.6
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}
