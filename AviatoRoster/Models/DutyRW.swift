//
//  DutyRW.swift
//  AviatoRoster
//
//  Created by Keshav Bansal on 22/06/18.
//

import Foundation
import RealmSwift
import ObjectMapper

typealias DutyRW = Duty

extension DutyRW {
    
    class func getRemoteDuties(callback: @escaping  (_ success: Bool) -> Void){
        WebClient.getRosterData { (duties, error) in
            DispatchQueue.main.sync {
                if let duties = duties, error == nil {
                    DutyRW().saveToDB(duties: duties)
                    callback(true)
                } else {
                    callback(false)
                }
            }
        }
    }
    
    func saveToDB(duties: [Duty]){
        self.deleteAllDuties()
        let realm = try! Realm()
        try! realm.safeWrite {
            realm.add(duties, update: false)
        }
    }
    
    func getAllDuties() -> Results<Duty> {
        let realm = try! Realm()
        let results = realm.objects(Duty.self)
        return results
    }
    
    func getDateWiseDuties() -> Results<Duty> {
        let predicate = NSPredicate(format: "dateString != nil AND dateString != ''")
        let results = self.getAllDuties().filter(predicate).sorted(byKeyPath: "date", ascending: true)
        return results
    }
    
    func deleteFromDuties(){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
    }
    
    func deleteAllDuties(){
        let realm = try! Realm()
        let results = getAllDuties()
        try! realm.safeWrite {
            realm.delete(results)
        }
    }
}

