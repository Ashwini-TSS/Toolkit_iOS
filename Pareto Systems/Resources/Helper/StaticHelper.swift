//
//  StaticHelper.swift
//  Pareto Systems
//
//  Created by Thabresh on 24/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation

let kHeaderSectionTag: Int = 6900;

var includeAppointments:Bool = true
var includeTasks:Bool = true
var includeAttendess:Bool = true
var forUsers:NSArray = []
var forAppointmentTypes:NSArray = []

var startTime:String = ""
var currentMonth : Int!
var endTime:String = ""
var selectedYear:String = ""

var menuItems:NSArray = ["Calendar","Contacts","Accounts","Processes","Services"]

var menuItem:[String:Any] = ["Calendar":["Client Classification","Services","Services Matrix"],
                             "Contacts":["Client Classification","Services","Services Matrix"],
                             "Accounts":["Client Classification","Services","Services Matrix"],
                             "Processes":["Client Classification","Services","Services Matrix"],
                             "Services":["Client Classification","Services","Services Matrix"]]


var sectionItems: Array<Any> = [ [],
                                 [],
                                 [],
                                 [],
                                 []
]
var sectionNames: Array<Any> = ["Calendar","Contacts","Accounts","Processes","Services"]
var sectionImages: Array<Any> = ["ic_calendar_white","ic_phone_book","ic_account_white","ic_processes_white","ic_services_white"]

var recentItmeTabs:NSArray = ["Hatch Architects","Susan Murray","Client Classification","John Smith","Edit Step","Process","New Client Onboarding"]

//Dashboard Recent Tabs
var recentTabs: Array<Any> = ["Hatch Architects","Susan Murray","Client Satisfaction","John Smith","Edit Step","Processes","New Client Onboarding"]

var recentTabImages: Array<Any> = ["ic_hatch","ic_sussan_murray","ic_client_satisfaction","ic_user","ic_edit","ic_process","ic_new_client"]

var officeNames: Array<Any> = ["Chicago Office","Dallas Office","New York Office"]
var officeDropDownItems: Array<Any> = ["Users","Payment","Sync"]
