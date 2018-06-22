//
//  Utils.swift
//  AviatoRoster
//
//  Created by Keshav Bansal on 22/06/18.
//

import Foundation
import Realm
import RealmSwift

class Utils {
    
    class func convertToTimeStamp(_ dateString: String?) -> Int? {
        if let dateString = dateString, !dateString.isEmpty {
            let dfmatter = DateFormatter()
            dfmatter.dateFormat = "dd/MM/yyyy"
            if let date = dfmatter.date(from: dateString) {
                let dateStamp: TimeInterval = date.timeIntervalSince1970
                return Int(dateStamp)
            }
        }
        return nil
    }
    
    class func viewController(fromStoryboard name: String, withViewControllerIdentifier identifier: String) -> UIViewController {
        let storyBoard = UIStoryboard(name: name, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: identifier) as UIViewController
    }
    
    class func dutyDetailVC(forDuty duty: Duty) -> DutyDetailVC {
        let viewController = self.viewController(fromStoryboard: "Main", withViewControllerIdentifier: "DutyDetailVC") as! DutyDetailVC
        viewController.duty = duty
        return viewController
    }
    
    class func arPlaneVC() -> ARPlaneVC {
        let viewController = self.viewController(fromStoryboard: "Main", withViewControllerIdentifier: "ARPlaneVC") as! ARPlaneVC
        return viewController
    }
}


public extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
