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
    @IBOutlet weak var navBarTopConstraint: NSLayoutConstraint!
    
    var duties: Results<Duty>!
    
    var isLoadedOnce: Bool = false
    var refreshControl = UIRefreshControl()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        rosterTableView.rowHeight = UITableViewAutomaticDimension
        rosterTableView.estimatedRowHeight = 100
        rosterTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.getRemoteDuties), for: .valueChanged)
        
        // Load local Roster
        self.duties = DutyRW().getDateWiseDuties()
        if self.duties.count != 0 {
            self.activityIndicatorView.isHidden = true
        }
        
        self.getRemoteDuties()
    }
    
    @objc func getRemoteDuties() {
        DutyRW.getRemoteDuties { (success) in
            if success {
                self.activityIndicatorView.isHidden = true
                self.rosterTableView.reloadData()
            }
            self.isLoadedOnce = true
            self.refreshControl.endRefreshing()
        }
    }
    
    @IBAction func paperPlanePressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(Utils.arPlaneVC(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RosterVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.duties.count == 0 && self.isLoadedOnce {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "DutyCell", for: indexPath) as! DutyCell
        if indexPath.row < self.duties.count && self.refreshControl.isRefreshing == false {
            cell.configureCell(duty: self.duties[indexPath.row], indexPath: indexPath)
            if self.shouldSetDateLabel(index: indexPath.row) {
                cell.setDateLabel()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let duty = self.duties[indexPath.row]
        if !duty.isInvalidated {
            let dutyDetailVC = Utils.dutyDetailVC(forDuty: duty)
            self.navigationController?.pushViewController(dutyDetailVC, animated: true)
        }
    }
    
    // MARK: Overriden scrollView Methods
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewScrolling(scrollView)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollViewScrolling(scrollView)
    }
    
    // MARK: ScrollView Methods
    
    /// hide/show navBar and tabBar as per scroll direction
    func scrollViewScrolling(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!)
        if translation.y > 0 {
            // scroll down
            setNavBarViewVisible(showNavBarView: true)
        } else if translation.y < 0 {
            // scroll up
            setNavBarViewVisible(showNavBarView: false)
        }
    }
    
    /// hides/shows the navBarView by changing containerViewTopConstraint
    private func setNavBarViewVisible(showNavBarView: Bool) {
        UIView.animate(withDuration: 0.25, animations: {
            if showNavBarView {
                self.navBarTopConstraint.constant = 0
            } else {
                self.navBarTopConstraint.constant = -56
            }
            self.view.layoutIfNeeded()
        })
    }
    
    func shouldSetDateLabel(index: Int) -> Bool {
        if index == 0 {
            return true
        }else if self.duties[index].date != self.duties[index - 1].date {
            return true
        }
        return false
    }
    
}
