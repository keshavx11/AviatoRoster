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
            if let duties = duties, error == nil {
                DutyRW().saveToDB(duties: duties)
                callback(true)
            } else {
                callback(false)
            }
        }
    }
    
    func saveToDB(duties: [Duty]){
        let realm = try! Realm()
        try! realm.safeWrite {
            realm.add(duties, update: true)
        }
    }
    
    func getAllDuties() -> Results<Duty> {
        let realm = try! Realm()
        let results = realm.objects(Duty.self)
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

