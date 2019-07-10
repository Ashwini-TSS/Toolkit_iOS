//
//    GetLinkedAccountsResult.swift
//
//    Create by thabresh thabu on 16/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GetLinkedAccountsResult : NSObject, NSCoding{
    
    var addressLine1 : String!
    var addressLine2 : String!
    var addressLine3 : String!
    var city : String!
    var createdBy : String!
    var createdOn : String!
    var descriptionField : String!
    var eMailAddress1 : String!
    var eMailAddress2 : String!
    var eMailAddress3 : String!
    var fax : String!
    var ftpSiteUrl : String!
    var id : String!
    var legalName : String!
    var mobilePhone : String!
    var modifiedBy : String!
    var modifiedOn : String!
    var name : String!
    var pager : String!
    var poBox : String!
    var postal : String!
    var primaryContactId : String!
    var state : String!
    var telephone1 : String!
    var telephone2 : String!
    var telephone3 : String!
    var webSiteUrl : String!
    
    
    var assistantName : String!
    var assistantPhone : String!
    
    var clientClassId : String!
    var companyName : String!
    
    var creditLimit : Int!
    var creditOnHold : Int!
    var department : String!
    
    var driversLicenseNumber : String!
    
    var executorName : String!
    var familyNotes : String!
    
    var firstName : String!
    
    var fullName : String!
    var governmentIdent : String!
    var groupInsurance : String!
    var groupPensionPlan : String!
    
    var income : Int!
    var jobTitle : String!
    var lastName : String!
    var middleName : String!
    
    var moneyNotes : String!
    var nickName : String!
    var occupationNotes : String!
    var owningOrganizationUserId : String!
    
    var powerofAttorneyName : String!
    var privateField : Bool!
    var recreationNotes : String!
    var revenue : Int!
    var salutation : String!
    var spousePartnerName : String!
    
    var suffix : String!
    
    var title : String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        addressLine1 = dictionary["AddressLine1"] as? String ?? ""
        addressLine2 = dictionary["AddressLine2"] as? String ?? ""
        addressLine3 = dictionary["AddressLine3"] as? String ?? ""
        city = dictionary["City"] as? String ?? ""
        createdBy = dictionary["CreatedBy"] as? String ?? ""
        createdOn = dictionary["CreatedOn"] as? String ?? ""
        descriptionField = dictionary["Description"] as? String ?? ""
        eMailAddress1 = dictionary["EMailAddress1"] as? String ?? ""
        eMailAddress2 = dictionary["EMailAddress2"] as? String ?? ""
        eMailAddress3 = dictionary["EMailAddress3"] as? String ?? ""
        fax = dictionary["Fax"] as? String ?? ""
        ftpSiteUrl = dictionary["FtpSiteUrl"] as? String ?? ""
        id = dictionary["Id"] as? String ?? ""
        legalName = dictionary["LegalName"] as? String ?? ""
        mobilePhone = dictionary["MobilePhone"] as? String ?? ""
        modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
        modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
        name = dictionary["Name"] as? String ?? ""
        pager = dictionary["Pager"] as? String ?? ""
        poBox = dictionary["PoBox"] as? String ?? ""
        postal = dictionary["Postal"] as? String ?? ""
        primaryContactId = dictionary["PrimaryContactId"] as? String ?? ""
        state = dictionary["State"] as? String ?? ""
        telephone1 = dictionary["Telephone1"] as? String ?? ""
        telephone2 = dictionary["Telephone2"] as? String ?? ""
        telephone3 = dictionary["Telephone3"] as? String ?? ""
        webSiteUrl = dictionary["WebSiteUrl"] as? String ?? ""
        addressLine1 = dictionary["AddressLine1"] as? String ?? ""
        addressLine2 = dictionary["AddressLine2"] as? String ?? ""
        addressLine3 = dictionary["AddressLine3"] as? String ?? ""
        assistantName = dictionary["AssistantName"] as? String ?? ""
        assistantPhone = dictionary["AssistantPhone"] as? String ?? ""
        city = dictionary["City"] as? String ?? ""
        clientClassId = dictionary["ClientClassId"] as? String ?? ""
        companyName = dictionary["CompanyName"] as? String ?? ""
        createdBy = dictionary["CreatedBy"] as? String ?? ""
        createdOn = dictionary["CreatedOn"] as? String ?? ""
        creditLimit = dictionary["CreditLimit"] as? Int
        creditOnHold = dictionary["CreditOnHold"] as? Int
        department = dictionary["Department"] as? String ?? ""
        descriptionField = dictionary["Description"] as? String ?? ""
        driversLicenseNumber = dictionary["DriversLicenseNumber"] as? String ?? ""
        eMailAddress1 = dictionary["EMailAddress1"] as? String ?? ""
        eMailAddress2 = dictionary["EMailAddress2"] as? String ?? ""
        eMailAddress3 = dictionary["EMailAddress3"] as? String ?? ""
        executorName = dictionary["ExecutorName"] as? String ?? ""
        familyNotes = dictionary["FamilyNotes"] as? String ?? ""
        fax = dictionary["Fax"] as? String ?? ""
        firstName = dictionary["FirstName"] as? String ?? ""
        ftpSiteUrl = dictionary["FtpSiteUrl"] as? String ?? ""
        fullName = dictionary["FullName"] as? String ?? ""
        governmentIdent = dictionary["GovernmentIdent"] as? String ?? ""
        groupInsurance = dictionary["GroupInsurance"] as? String ?? ""
        groupPensionPlan = dictionary["GroupPensionPlan"] as? String ?? ""
        id = dictionary["Id"] as? String ?? ""
        income = dictionary["Income"] as? Int
        jobTitle = dictionary["JobTitle"] as? String ?? ""
        lastName = dictionary["LastName"] as? String ?? ""
        middleName = dictionary["MiddleName"] as? String ?? ""
        mobilePhone = dictionary["MobilePhone"] as? String ?? ""
        modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
        modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
        moneyNotes = dictionary["MoneyNotes"] as? String ?? ""
        nickName = dictionary["NickName"] as? String ?? ""
        occupationNotes = dictionary["OccupationNotes"] as? String ?? ""
        owningOrganizationUserId = dictionary["OwningOrganizationUserId"] as? String ?? ""
        pager = dictionary["Pager"] as? String ?? ""
        poBox = dictionary["PoBox"] as? String ?? ""
        postal = dictionary["Postal"] as? String ?? ""
        powerofAttorneyName = dictionary["PowerofAttorneyName"] as? String ?? ""
        privateField = dictionary["Private"] as? Bool
        recreationNotes = dictionary["RecreationNotes"] as? String ?? ""
        revenue = dictionary["Revenue"] as? Int
        salutation = dictionary["Salutation"] as? String ?? ""
        spousePartnerName = dictionary["SpousePartnerName"] as? String ?? ""
        state = dictionary["State"] as? String ?? ""
        suffix = dictionary["Suffix"] as? String ?? ""
        telephone1 = dictionary["Telephone1"] as? String ?? ""
        telephone2 = dictionary["Telephone2"] as? String ?? ""
        telephone3 = dictionary["Telephone3"] as? String ?? ""
        title = dictionary["Title"] as? String ?? ""
        webSiteUrl = dictionary["WebSiteUrl"] as? String ?? ""
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if addressLine1 != nil{
            dictionary["AddressLine1"] = addressLine1
        }
        if addressLine2 != nil{
            dictionary["AddressLine2"] = addressLine2
        }
        if addressLine3 != nil{
            dictionary["AddressLine3"] = addressLine3
        }
        if city != nil{
            dictionary["City"] = city
        }
        if createdBy != nil{
            dictionary["CreatedBy"] = createdBy
        }
        if createdOn != nil{
            dictionary["CreatedOn"] = createdOn
        }
        if descriptionField != nil{
            dictionary["Description"] = descriptionField
        }
        if eMailAddress1 != nil{
            dictionary["EMailAddress1"] = eMailAddress1
        }
        if eMailAddress2 != nil{
            dictionary["EMailAddress2"] = eMailAddress2
        }
        if eMailAddress3 != nil{
            dictionary["EMailAddress3"] = eMailAddress3
        }
        if fax != nil{
            dictionary["Fax"] = fax
        }
        if ftpSiteUrl != nil{
            dictionary["FtpSiteUrl"] = ftpSiteUrl
        }
        if id != nil{
            dictionary["Id"] = id
        }
        if legalName != nil{
            dictionary["LegalName"] = legalName
        }
        if mobilePhone != nil{
            dictionary["MobilePhone"] = mobilePhone
        }
        if modifiedBy != nil{
            dictionary["ModifiedBy"] = modifiedBy
        }
        if modifiedOn != nil{
            dictionary["ModifiedOn"] = modifiedOn
        }
        if name != nil{
            dictionary["Name"] = name
        }
        if pager != nil{
            dictionary["Pager"] = pager
        }
        if poBox != nil{
            dictionary["PoBox"] = poBox
        }
        if postal != nil{
            dictionary["Postal"] = postal
        }
        if primaryContactId != nil{
            dictionary["PrimaryContactId"] = primaryContactId
        }
        if state != nil{
            dictionary["State"] = state
        }
        if telephone1 != nil{
            dictionary["Telephone1"] = telephone1
        }
        if telephone2 != nil{
            dictionary["Telephone2"] = telephone2
        }
        if telephone3 != nil{
            dictionary["Telephone3"] = telephone3
        }
        if webSiteUrl != nil{
            dictionary["WebSiteUrl"] = webSiteUrl
        }
        if addressLine1 != nil{
            dictionary["AddressLine1"] = addressLine1
        }
        if addressLine2 != nil{
            dictionary["AddressLine2"] = addressLine2
        }
        if addressLine3 != nil{
            dictionary["AddressLine3"] = addressLine3
        }
        if assistantName != nil{
            dictionary["AssistantName"] = assistantName
        }
        if assistantPhone != nil{
            dictionary["AssistantPhone"] = assistantPhone
        }
        if city != nil{
            dictionary["City"] = city
        }
        if clientClassId != nil{
            dictionary["ClientClassId"] = clientClassId
        }
        if companyName != nil{
            dictionary["CompanyName"] = companyName
        }
        if createdBy != nil{
            dictionary["CreatedBy"] = createdBy
        }
        if createdOn != nil{
            dictionary["CreatedOn"] = createdOn
        }
        if creditLimit != nil{
            dictionary["CreditLimit"] = creditLimit
        }
        if creditOnHold != nil{
            dictionary["CreditOnHold"] = creditOnHold
        }
        if department != nil{
            dictionary["Department"] = department
        }
        if descriptionField != nil{
            dictionary["Description"] = descriptionField
        }
        if driversLicenseNumber != nil{
            dictionary["DriversLicenseNumber"] = driversLicenseNumber
        }
        if eMailAddress1 != nil{
            dictionary["EMailAddress1"] = eMailAddress1
        }
        if eMailAddress2 != nil{
            dictionary["EMailAddress2"] = eMailAddress2
        }
        if eMailAddress3 != nil{
            dictionary["EMailAddress3"] = eMailAddress3
        }
        if executorName != nil{
            dictionary["ExecutorName"] = executorName
        }
        if familyNotes != nil{
            dictionary["FamilyNotes"] = familyNotes
        }
        if fax != nil{
            dictionary["Fax"] = fax
        }
        if firstName != nil{
            dictionary["FirstName"] = firstName
        }
        if ftpSiteUrl != nil{
            dictionary["FtpSiteUrl"] = ftpSiteUrl
        }
        if fullName != nil{
            dictionary["FullName"] = fullName
        }
        if governmentIdent != nil{
            dictionary["GovernmentIdent"] = governmentIdent
        }
        if groupInsurance != nil{
            dictionary["GroupInsurance"] = groupInsurance
        }
        if groupPensionPlan != nil{
            dictionary["GroupPensionPlan"] = groupPensionPlan
        }
        if id != nil{
            dictionary["Id"] = id
        }
        if income != nil{
            dictionary["Income"] = income
        }
        if jobTitle != nil{
            dictionary["JobTitle"] = jobTitle
        }
        if lastName != nil{
            dictionary["LastName"] = lastName
        }
        if middleName != nil{
            dictionary["MiddleName"] = middleName
        }
        if mobilePhone != nil{
            dictionary["MobilePhone"] = mobilePhone
        }
        if modifiedBy != nil{
            dictionary["ModifiedBy"] = modifiedBy
        }
        if modifiedOn != nil{
            dictionary["ModifiedOn"] = modifiedOn
        }
        if moneyNotes != nil{
            dictionary["MoneyNotes"] = moneyNotes
        }
        if nickName != nil{
            dictionary["NickName"] = nickName
        }
        if occupationNotes != nil{
            dictionary["OccupationNotes"] = occupationNotes
        }
        if owningOrganizationUserId != nil{
            dictionary["OwningOrganizationUserId"] = owningOrganizationUserId
        }
        if pager != nil{
            dictionary["Pager"] = pager
        }
        if poBox != nil{
            dictionary["PoBox"] = poBox
        }
        if postal != nil{
            dictionary["Postal"] = postal
        }
        if powerofAttorneyName != nil{
            dictionary["PowerofAttorneyName"] = powerofAttorneyName
        }
        if privateField != nil{
            dictionary["Private"] = privateField
        }
        if recreationNotes != nil{
            dictionary["RecreationNotes"] = recreationNotes
        }
        if revenue != nil{
            dictionary["Revenue"] = revenue
        }
        if salutation != nil{
            dictionary["Salutation"] = salutation
        }
        if spousePartnerName != nil{
            dictionary["SpousePartnerName"] = spousePartnerName
        }
        if state != nil{
            dictionary["State"] = state
        }
        if suffix != nil{
            dictionary["Suffix"] = suffix
        }
        if telephone1 != nil{
            dictionary["Telephone1"] = telephone1
        }
        if telephone2 != nil{
            dictionary["Telephone2"] = telephone2
        }
        if telephone3 != nil{
            dictionary["Telephone3"] = telephone3
        }
        if title != nil{
            dictionary["Title"] = title
        }
        if webSiteUrl != nil{
            dictionary["WebSiteUrl"] = webSiteUrl
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        addressLine1 = aDecoder.decodeObject(forKey: "AddressLine1") as? String ?? ""
        addressLine2 = aDecoder.decodeObject(forKey: "AddressLine2") as? String ?? ""
        addressLine3 = aDecoder.decodeObject(forKey: "AddressLine3") as? String ?? ""
        city = aDecoder.decodeObject(forKey: "City") as? String ?? ""
        createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String ?? ""
        createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String ?? ""
        descriptionField = aDecoder.decodeObject(forKey: "Description") as? String ?? ""
        eMailAddress1 = aDecoder.decodeObject(forKey: "EMailAddress1") as? String ?? ""
        eMailAddress2 = aDecoder.decodeObject(forKey: "EMailAddress2") as? String ?? ""
        eMailAddress3 = aDecoder.decodeObject(forKey: "EMailAddress3") as? String ?? ""
        fax = aDecoder.decodeObject(forKey: "Fax") as? String ?? ""
        ftpSiteUrl = aDecoder.decodeObject(forKey: "FtpSiteUrl") as? String ?? ""
        id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
        legalName = aDecoder.decodeObject(forKey: "LegalName") as? String ?? ""
        mobilePhone = aDecoder.decodeObject(forKey: "MobilePhone") as? String ?? ""
        modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
        modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? ""
        name = aDecoder.decodeObject(forKey: "Name") as? String ?? ""
        pager = aDecoder.decodeObject(forKey: "Pager") as? String ?? ""
        poBox = aDecoder.decodeObject(forKey: "PoBox") as? String ?? ""
        postal = aDecoder.decodeObject(forKey: "Postal") as? String ?? ""
        primaryContactId = aDecoder.decodeObject(forKey: "PrimaryContactId") as? String ?? ""
        state = aDecoder.decodeObject(forKey: "State") as? String ?? ""
        telephone1 = aDecoder.decodeObject(forKey: "Telephone1") as? String ?? ""
        telephone2 = aDecoder.decodeObject(forKey: "Telephone2") as? String ?? ""
        telephone3 = aDecoder.decodeObject(forKey: "Telephone3") as? String ?? ""
        webSiteUrl = aDecoder.decodeObject(forKey: "WebSiteUrl") as? String ?? ""
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if addressLine1 != nil{
            aCoder.encode(addressLine1, forKey: "AddressLine1")
        }
        if addressLine2 != nil{
            aCoder.encode(addressLine2, forKey: "AddressLine2")
        }
        if addressLine3 != nil{
            aCoder.encode(addressLine3, forKey: "AddressLine3")
        }
        if city != nil{
            aCoder.encode(city, forKey: "City")
        }
        if createdBy != nil{
            aCoder.encode(createdBy, forKey: "CreatedBy")
        }
        if createdOn != nil{
            aCoder.encode(createdOn, forKey: "CreatedOn")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "Description")
        }
        if eMailAddress1 != nil{
            aCoder.encode(eMailAddress1, forKey: "EMailAddress1")
        }
        if eMailAddress2 != nil{
            aCoder.encode(eMailAddress2, forKey: "EMailAddress2")
        }
        if eMailAddress3 != nil{
            aCoder.encode(eMailAddress3, forKey: "EMailAddress3")
        }
        if fax != nil{
            aCoder.encode(fax, forKey: "Fax")
        }
        if ftpSiteUrl != nil{
            aCoder.encode(ftpSiteUrl, forKey: "FtpSiteUrl")
        }
        if id != nil{
            aCoder.encode(id, forKey: "Id")
        }
        if legalName != nil{
            aCoder.encode(legalName, forKey: "LegalName")
        }
        if mobilePhone != nil{
            aCoder.encode(mobilePhone, forKey: "MobilePhone")
        }
        if modifiedBy != nil{
            aCoder.encode(modifiedBy, forKey: "ModifiedBy")
        }
        if modifiedOn != nil{
            aCoder.encode(modifiedOn, forKey: "ModifiedOn")
        }
        if name != nil{
            aCoder.encode(name, forKey: "Name")
        }
        if pager != nil{
            aCoder.encode(pager, forKey: "Pager")
        }
        if poBox != nil{
            aCoder.encode(poBox, forKey: "PoBox")
        }
        if postal != nil{
            aCoder.encode(postal, forKey: "Postal")
        }
        if primaryContactId != nil{
            aCoder.encode(primaryContactId, forKey: "PrimaryContactId")
        }
        if state != nil{
            aCoder.encode(state, forKey: "State")
        }
        if telephone1 != nil{
            aCoder.encode(telephone1, forKey: "Telephone1")
        }
        if telephone2 != nil{
            aCoder.encode(telephone2, forKey: "Telephone2")
        }
        if telephone3 != nil{
            aCoder.encode(telephone3, forKey: "Telephone3")
        }
        if webSiteUrl != nil{
            aCoder.encode(webSiteUrl, forKey: "WebSiteUrl")
        }
        
    }
    
}
