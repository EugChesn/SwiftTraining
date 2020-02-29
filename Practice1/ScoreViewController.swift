//
//  ScoreViewController.swift
//  Practice1
//
//  Created by Евгений on 02.02.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import UIKit


class ScoreViewController: UIViewController ,UITableViewDelegate{
    
    var dataScore: [SourceData]?
    @IBOutlet weak var tableView : UITableView!
    
    private enum LocalizeStat{
        static let score = "Score"
        static let steps = "Steps"
        static let wins = "Wins"
        static let range = "RangeStat"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(LocalizeStat.score, comment: "")
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = NSTextAlignment.center
        header.textLabel?.font = UIFont(name: "", size: 20)
        header.textLabel?.textColor = UIColor.systemBlue
    }
}

extension ScoreViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataScore?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        if let data = dataScore{
            let range = (data[indexPath.row].min, data[indexPath.row].max)
            
            let textLabelStr = NSLocalizedString(LocalizeStat.steps, comment: "")
                                + " \(data[indexPath.row].numbersGame)  "
                                + NSLocalizedString(LocalizeStat.wins, comment: "")
                                + "\(data[indexPath.row].numbersWin)"
            let detailLabelStr = NSLocalizedString(LocalizeStat.range, comment: "") + " \(range)"
            
            cell.textLabel?.text = textLabelStr
            cell.detailTextLabel?.text = detailLabelStr
            
            return cell
        }
        return UITableViewCell()
    }
}
