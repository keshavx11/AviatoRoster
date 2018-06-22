//
//  TableViewCell.swift
//  AviatoRoster
//
//  Created by Keshav Bansal on 22/06/18.
//

import UIKit

class DutyCell: UITableViewCell {
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dutyIconLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var miscLabel: UILabel!
    
    var duty: Duty!
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func resetCell() {
        self.dateViewHeightConstraint.constant = 0
        self.dateView.isHidden = true
        
        self.dutyIconLabel.text = ""
        self.titleLabel.text = nil
        self.subTitleLabel.text = nil
        self.timeLabel.text = nil
        self.miscLabel.text = nil
    }
    
    func configureCell(duty: Duty, indexPath: IndexPath) {
        
        self.resetCell()
        
        self.duty = duty
        self.indexPath = indexPath
        
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
        }
        
        self.subTitleLabel.isHidden = self.subTitleLabel.text == "" || self.subTitleLabel.text == nil
    }
    
    func setDateLabel() {
        self.dateViewHeightConstraint.constant = 32
        self.dateLabel.text = self.duty.dateString
        self.dateView.isHidden = false
    }

}

