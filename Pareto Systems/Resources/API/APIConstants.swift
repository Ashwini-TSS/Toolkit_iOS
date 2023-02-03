//
//  APIConstants.swift
//  ExpertHelper
//
//  Created by vivid on 20/04/18.
//  Copyright © 2018 Thabresh. All rights reserved.
// 
import Foundation
import UIKit

var selectedContactInfo:ContactListResult!
let defaultNoteCellHeight = 138
let commentHeight = 40

let phoneNumberLength:Int = 9

var globalURL : String! =  UserDefaults.standard.string(forKey: "logg")
//let endpintURL:String = "https://toolkit.bluesquareapps.com/endpoints/ajax/"
var endpintURL:String = globalURL + "/endpoints/ajax/"

var passListAppointments : NSDictionary!

//let imageLoadURL:String = "https://toolkit.bluesquareapps.com"
var imageLoadURL:String = globalURL

var dataEndPointURL:String = "com.platform.vc.endpoints.data.VCDataEndpoint/"

var orgEndPointURL:String = "com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/"

var calenderEndPointURL:String = "com.platform.vc.endpoints.calendar.VCCalendarEndpoint/"

var syncEndPointURL:String = "com.platform.vc.endpoints.sync.VCSyncEndpoint/"

var APIBaseURL:String = endpintURL + dataEndPointURL

var orgBaseURL:String = endpintURL + orgEndPointURL

var calenderBaseURL:String = endpintURL + calenderEndPointURL

var syncBaseURL:String = endpintURL + syncEndPointURL

var getHistoryURL:String = syncBaseURL + "getHistory.json"

var loginURL:String = APIBaseURL + "login.json"

var signupURL:String = APIBaseURL + "signup.json"

var forgotURL:String = APIBaseURL + "forgotPassword.json"

var listByOrgURL:String = APIBaseURL + "listUserOrganizations.json"

var organizationStatusURL:String = orgBaseURL + "organizationStatus.json"

var listDefaultTrialPeriods:String = APIBaseURL + "listDefaultTrialPeriods.json"

var packagesURL:String = APIBaseURL + "listSaleableVerticalPackages.json"

var userListByOrgURL:String = APIBaseURL + "listUsersInOrganization.json"

var paymentListURL:String = APIBaseURL + "listPaymentCards.json"

var inviteUserURL:String = APIBaseURL + "createEmailInvite.json"

var deleteEmailInviteURL:String = APIBaseURL + "deleteEmailInvite.json"

var listEmailInviteURL:String = APIBaseURL + "listEmailInvites.json"

var createPaymentURL:String = APIBaseURL + "createPaymentCard.json"

var changePasswordURL:String = APIBaseURL + "setPassword.json"

var getDefaultPaymentCardURL:String = APIBaseURL + "getDefaultPaymentCard.json"

var deletePaymentCardURL:String = APIBaseURL + "deletePaymentCard.json"

var setDefaultCardURL:String = APIBaseURL + "setDefaultPaymentCard.json"

var getUserURL:String = APIBaseURL + "whoAmI.json"

var modifyUserURL:String = APIBaseURL + "modifyUser.json"

var getUserMetaURL:String = APIBaseURL + "getUserMeta.json"

var getContactListURL:String = APIBaseURL + "list.json"

var getOrgListURL:String = orgBaseURL + "list.json"

var deleteContactListURL:String = orgBaseURL + "delete.json"

var createContact:String = orgBaseURL + "create.json"

var searchURL:String = orgBaseURL + "search.json"

var deleteActivityURL:String = orgBaseURL + "delete.json"

var linkedURL:String = orgBaseURL + "listLinked.json"

var linkURL:String = orgBaseURL + "link.json"

var removeLinkURL:String = orgBaseURL + "removeLink.json"

var ListNotes:String = orgBaseURL + "listNotes.json"

var modifyURL:String = orgBaseURL + "modify.json"

var getIncompleteActivitiesURL:String = calenderBaseURL + "getIncompleteActivities.json"

var orgListURL:String = orgBaseURL + "list.json"

var getURL:String = orgBaseURL + "get.json"

var getActivities:String = calenderBaseURL + "getActivities.json"

var getOrganizationStatusInfo:String = APIBaseURL + "getOrganizationStatus.json"

var purchasePackageURL:String = APIBaseURL + "linkVerticalPackageToOrganization.json"


