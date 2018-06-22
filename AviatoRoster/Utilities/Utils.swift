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
        if let dateString = dateString {
            let dfmatter = DateFormatter()
            dfmatter.dateFormat = "dd/MM/yyyy"
            let date = dfmatter.date(from: dateString)
            let dateStamp: TimeInterval = date!.timeIntervalSince1970
            return Int(dateStamp)
        }
        return nil
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
