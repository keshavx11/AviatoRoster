//
//  ViewController.swift
//  AviatoRoster
//
//  Created by Keshav Bansal on 22/06/18.
//

import UIKit
import RealmSwift

class RosterVC: UIViewController {

    @IBOutlet var rosterTableView: UITableView!
    @IBOutlet var activityIndicatorView: UIView!
    
    var duties: Results<Duty>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        // Load local Roster
        self.duties = DutyRW().getAllDuties()
        self.getRemoteDuties()
    }
    
    func getRemoteDuties() {
        DutyRW.getRemoteDuties { (success) in
            if success {
                self.rosterTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RosterVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.duties.count == 0 {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "Nothing here!"
            noDataLabel.textColor     = UIColor.gray
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }else{
            tableView.separatorStyle = .none
            tableView.backgroundView = nil
        }
        return self.duties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
