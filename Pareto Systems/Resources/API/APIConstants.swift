//
//  APIConstants.swift
//  ExpertHelper
//
//  Created by vivid on 20/04/18.
//  Copyright © 2018 Thabresh. All rights reserved.
//
import Foundation

var selectedContactInfo:ContactListResult!

let phoneNumberLength:Int = 9

let endpintURL:String = "https://beta.paretoacademy.com/endpoints/ajax/"

let imageLoadURL:String = "https://beta.paretoacademy.com"

let dataEndPointURL:String = "com.platform.vc.endpoints.data.VCDataEndpoint/"

let orgEndPointURL:String = "com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/"

let calenderEndPointURL:String = "com.platform.vc.endpoints.calendar.VCCalendarEndpoint/"

let syncEndPointURL:String = "com.platform.vc.endpoints.sync.VCSyncEndpoint/"

let APIBaseURL:String = endpintURL + dataEndPointURL

let orgBaseURL:String = endpintURL + orgEndPointURL

let calenderBaseURL:String = endpintURL + calenderEndPointURL

let syncBaseURL:String = endpintURL + syncEndPointURL

let getHistoryURL:String = syncBaseURL + "getHistory.json"

let loginURL:String = APIBaseURL + "login.json"

let signupURL:String = APIBaseURL + "signup.json"

let forgotURL:String = APIBaseURL + "forgotPassword.json"

let listByOrgURL:String = APIBaseURL + "listUserOrganizations.json"

let organizationStatusURL:String = orgBaseURL + "organizationStatus.json"

let listDefaultTrialPeriods:String = APIBaseURL + "listDefaultTrialPeriods.json"

let packagesURL:String = APIBaseURL + "listSaleableVerticalPackages.json"

let userListByOrgURL:String = APIBaseURL + "listUsersInOrganization.json"

let paymentListURL:String = APIBaseURL + "listPaymentCards.json"

let inviteUserURL:String = APIBaseURL + "createEmailInvite.json"

let deleteEmailInviteURL:String = APIBaseURL + "deleteEmailInvite.json"

let listEmailInviteURL:String = APIBaseURL + "listEmailInvites.json"

let createPaymentURL:String = APIBaseURL + "createPaymentCard.json"

let changePasswordURL:String = APIBaseURL + "setPassword.json"

let getDefaultPaymentCardURL:String = APIBaseURL + "getDefaultPaymentCard.json"

let deletePaymentCardURL:String = APIBaseURL + "deletePaymentCard.json"

let setDefaultCardURL:String = APIBaseURL + "setDefaultPaymentCard.json"

let getUserURL:String = APIBaseURL + "whoAmI.json"

let modifyUserURL:String = APIBaseURL + "modifyUser.json"

let getUserMetaURL:String = APIBaseURL + "getUserMeta.json"

let getContactListURL:String = APIBaseURL + "list.json"

let getOrgListURL:String = orgBaseURL + "list.json"

let deleteContactListURL:String = orgBaseURL + "delete.json"

let createContact:String = orgBaseURL + "create.json"

let searchURL:String = orgBaseURL + "search.json"

let linkedURL:String = orgBaseURL + "listLinked.json"

let linkURL:String = orgBaseURL + "link.json"

let removeLinkURL:String = orgBaseURL + "removeLink.json"

let modifyURL:String = orgBaseURL + "modify.json"

let getIncompleteActivitiesURL:String = calenderBaseURL + "getIncompleteActivities.json"

let orgListURL:String = orgBaseURL + "list.json"

let getURL:String = orgBaseURL + "get.json"

let getActivities:String = calenderBaseURL + "getActivities.json"

let getOrganizationStatusInfo:String = APIBaseURL + "getOrganizationStatus.json"

let purchasePackageURL:String = APIBaseURL + "linkVerticalPackageToOrganization.json"


