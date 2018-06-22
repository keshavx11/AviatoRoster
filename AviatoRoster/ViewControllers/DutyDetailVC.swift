//
//  DutyDetailVC.swift
//  AviatoRoster
//
//  Created by Keshav Bansal on 23/06/18.
//

import UIKit

class DutyDetailVC: UIViewController {
    
    @IBOutlet weak var dutyIconLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!

    var duty: Duty!
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    func configureView() {
        
        self.subTitleLabel.text = nil
        if let code = duty.dutyCode {
            switch code {
            case "Standby":
                self.dutyIconLabel.text = ""
                break
            case "OFF":
                self.dutyIconLabel.text = ""
                break
            case "Layover":
                self.dutyIconLabel.text = ""
                break
            default:
                break
            }
        }
        
        if let dutyID = duty.dutyID, !dutyID.isEmpty {
            self.titleLabel.text = duty.dutyCode
            self.subTitleLabel.text = dutyID
        } else if let departure = duty.departure, let destination = duty.destination, !departure.isEmpty && !destination.isEmpty  {
            self.titleLabel.text = "\(departure) - \(destination)"
        } else if let departure = duty.departure, !departure.isEmpty {
            self.titleLabel.text = departure
        } else if let destination = duty.destination, !destination.isEmpty {
            self.titleLabel.text = destination
        }
        
        if let time_Arrive = duty.time_Arrive, let time_Depart = duty.time_Depart, !time_Arrive.isEmpty && !time_Depart.isEmpty  {
            self.timeLabel.text = "\(time_Depart) - \(time_Arrive)"
        } else if let time_Arrive = duty.departure, !time_Arrive.isEmpty {
            self.timeLabel.text = "\(time_Arrive) hours"
        } else if let time_Depart = duty.destination, !time_Depart.isEmpty {
            self.timeLabel.text = "\(time_Depart) hours"
        } else {
            self.timeView.isHidden = true
        }
        
        if let date = self.duty.dateString, !date.isEmpty {
            self.dateLabel.text = date
        } else {
            self.dateView.isHidden = true
        }
        
        self.subTitleLabel.isHidden = self.subTitleLabel.text == "" || self.subTitleLabel.text == nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
