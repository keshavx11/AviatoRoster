//
//  Duty.swift
//  AviatoRoster
//
//  Created by Keshav Bansal on 22/06/18.
//

import UIKit
import Realm
import RealmSwift
import ObjectMapper

class Duty: Object, Mappable {

    @objc dynamic var flightNR: String?
    @objc dynamic var dateString: String?
    @objc dynamic var date: Int = 0
    @objc dynamic var aircraftType: String?
    @objc dynamic var tail: String?
    @objc dynamic var departure: String?
    @objc dynamic var destination: String?
    @objc dynamic var time_Depart: String?
    @objc dynamic var time_Arrive: String?
    @objc dynamic var dutyID: String?
    @objc dynamic var dutyCode: String?
    @objc dynamic var Captain: String?
    @objc dynamic var firstOfficer: String?
    @objc dynamic var flightAttendant: String?

    
    required convenience init?(map: Map){
        self.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema){
        super.init(realm: realm, schema: schema)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value:value, schema:schema)
    }
    
    func mapping(map: Map) {
        
        dateString <- map[DutyDataKeys.date]
        if let date = Utils.convertToTimeStamp(dateString) {
            self.date = date
        }
        
        flightNR <- map[DutyDataKeys.flightNR]
        aircraftType <- map[DutyDataKeys.aircraftType]
        tail <- map[DutyDataKeys.tail]
        departure <- map[DutyDataKeys.departure]
        destination <- map[DutyDataKeys.destination]
        time_Depart <- map[DutyDataKeys.time_Depart]
        time_Arrive <- map[DutyDataKeys.time_Arrive]
        dutyID <- map[DutyDataKeys.dutyID]
        dutyCode <- map[DutyDataKeys.dutyCode]
        Captain <- map[DutyDataKeys.Captain]
        firstOfficer <- map[DutyDataKeys.firstOfficer]
        flightAttendant <- map[DutyDataKeys.flightAttendant]
    }
}

