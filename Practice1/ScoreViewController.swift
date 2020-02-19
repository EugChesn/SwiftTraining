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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("Score", comment: "")
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = NSTextAlignment.center
        header.textLabel?.font = UIFont(name: "", size: 20)
        header.textLabel?.textColor = UIColor.systemBlue
    }
}

extension ScoreViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = dataScore?.count{
            return count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        if let data = dataScore{
            let range = (data[indexPath.row].min, data[indexPath.row].max)
            
            cell.textLabel?.text = NSLocalizedString("Steps", comment: "")
                                    + " \(data[indexPath.row].numbersGame)  "
                                    + NSLocalizedString("Wins", comment: "")
                                    + "\(data[indexPath.row].numbersWin)"
            
            cell.detailTextLabel?.text = NSLocalizedString("RangeStat", comment: "")
                                    + " \(range)"
            return cell
        }
        return UITableViewCell()
    }
}
