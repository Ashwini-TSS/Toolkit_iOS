//
//    ContactListResult.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ContactListResult : NSObject, NSCoding{
    
    var addressLine1 : String!
    var addressLine2 : String!
    var addressLine3 : String!
    var assistantName : String!
    var assistantPhone : String!
    var city : String!
    var clientClassId : String!
    var companyId : String!
    var companyName : String!
    var createdBy : String!
    var createdOn : String!
    var creditLimit : NSNumber!
    var creditOnHold : NSNumber!
    var department : String!
    var descriptionField : String!
    var driversLicenseNumber : String!
    var eMailAddress1 : String!
    var eMailAddress2 : String!
    var eMailAddress3 : String!
    var executorName : String!
    var familyNotes : String!
    var fax : String!
    var firstName : String!
    var ftpSiteUrl : String!
    var fullName : String!
    var gender : String!
    var governmentIdent : String!
    var groupInsurance : String!
    var groupPensionPlan : String!
    var id : String!
    var income : NSNumber!
    var jobTitle : String!
    var lastName : String!
    var middleName : String!
    var mobilePhone : String!
    var modifiedBy : String!
    var modifiedOn : String!
    var moneyNotes : String!
    var nickName : String!
    var occupationNotes : String!
    var owningOrganizationUserId : String!
    var pager : String!
    var poBox : String!
    var postal : String!
    var powerofAttorneyName : String!
    var privateField : Bool!
    var recreationNotes : String!
    var revenue : NSNumber!
    var salutation : String!
    var spousePartnerName : String!
    var state : String!
    var suffix : String!
    var telephone1 : String!
    var telephone2 : String!
    var telephone3 : String!
    var title : String!
    var webSiteUrl : String!
    var country:String!
    var BirthDate:String!
    var renewDate:String!
    var licenseExpiry:String!
    var anniversay:String!
    var clientSince:String!
    var executorID:String!
    var powerOfAttronyID:String!
    var spousePartnerID:String!
    var ChildrensNames:String!
    var maritalStatus:String!
    var businessPhoneExt:String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        print(dictionary)
        maritalStatus = dictionary["MaritalStatus"] as? String ?? ""
        businessPhoneExt = dictionary["Telephone1Ext"] as? String ?? ""

        ChildrensNames = dictionary["ChildrensNames"] as? String ?? ""
        spousePartnerID = dictionary["SpousePartnerId"] as? String ?? ""
        clientSince = dictionary["ClientSince"] as? String ?? ""
        executorID = dictionary["ExecutorId"] as? String ?? ""
        powerOfAttronyID = dictionary["PowerofAttorneyId"] as? String ?? ""
        anniversay = dictionary["Anniversary"] as? String ?? ""
        BirthDate = dictionary["BirthDate"] as? String ?? ""
        renewDate = dictionary["ReviewDate"] as? String ?? ""
        licenseExpiry = dictionary["DriversLicenseExpiry"] as? String ?? ""
        
        addressLine1 = dictionary["AddressLine1"] as? String ?? ""
        addressLine2 = dictionary["AddressLine2"] as? String ?? ""
        addressLine3 = dictionary["AddressLine3"] as? String ?? ""
        assistantName = dictionary["AssistantName"] as? String ?? ""
        assistantPhone = dictionary["AssistantPhone"] as? String ?? ""
        city = dictionary["City"] as? String ?? ""
        clientClassId = dictionary["ClientClassId"] as? String ?? ""
        companyId = dictionary["CompanyId"] as? String ?? ""
        companyName = dictionary["CompanyName"] as? String ?? ""
        createdBy = dictionary["CreatedBy"] as? String ?? ""
        createdOn = dictionary["CreatedOn"] as? String ?? ""
        creditLimit = dictionary["CreditLimit"] as? NSNumber
        creditOnHold = dictionary["CreditOnHold"] as? NSNumber
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
        if fullName == "Donald Trump" {
            print(dictionary)
        }
        gender = dictionary["Gender"] as? String ?? ""
        governmentIdent = dictionary["GovernmentIdent"] as? String ?? ""
        groupInsurance = dictionary["GroupInsurance"] as? String ?? ""
        groupPensionPlan = dictionary["GroupPensionPlan"] as? String ?? ""
        id = dictionary["Id"] as? String ?? ""
        income = dictionary["Income"] as? NSNumber
        if fullName == "Donald Trump" {
            print(income)
            if let incme = dictionary["Income"] as? Int {
                print(incme)
            }else if let incme = dictionary["Income"] as? NSNumber {
                print(incme)
            }
        }
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
        revenue = dictionary["Revenue"] as? NSNumber
        salutation = dictionary["Salutation"] as? String ?? ""
        spousePartnerName = dictionary["SpousePartnerName"] as? String ?? ""
        state = dictionary["State"] as? String ?? ""
        suffix = dictionary["Suffix"] as? String ?? ""
        telephone1 = dictionary["Telephone1"] as? String ?? ""
        telephone2 = dictionary["Telephone2"] as? String ?? ""
        telephone3 = dictionary["Telephone3"] as? String ?? ""
        title = dictionary["Title"] as? String ?? ""
        webSiteUrl = dictionary["WebSiteUrl"] as? String ?? ""
        country = dictionary["Country"] as? String ?? ""
    }
    
    init(fromDictiary dictionary: NSDictionary){
        print(dictionary)
        businessPhoneExt = dictionary["Telephone1Ext"] as? String ?? ""

        maritalStatus = dictionary["MaritalStatus"] as? String ?? ""
        
        ChildrensNames = dictionary["ChildrensNames"] as? String ?? ""
        spousePartnerID = dictionary["SpousePartnerId"] as? String ?? ""
        clientSince = dictionary["ClientSince"] as? String ?? ""
        executorID = dictionary["ExecutorId"] as? String ?? ""
        powerOfAttronyID = dictionary["PowerofAttorneyId"] as? String ?? ""
        anniversay = dictionary["Anniversary"] as? String ?? ""
        BirthDate = dictionary["BirthDate"] as? String ?? ""
        renewDate = dictionary["ReviewDate"] as? String ?? ""
        licenseExpiry = dictionary["DriversLicenseExpiry"] as? String ?? ""
        
        addressLine1 = dictionary["AddressLine1"] as? String ?? ""
        addressLine2 = dictionary["AddressLine2"] as? String ?? ""
        addressLine3 = dictionary["AddressLine3"] as? String ?? ""
        assistantName = dictionary["AssistantName"] as? String ?? ""
        assistantPhone = dictionary["AssistantPhone"] as? String ?? ""
        city = dictionary["City"] as? String ?? ""
        clientClassId = dictionary["ClientClassId"] as? String ?? ""
        companyId = dictionary["CompanyId"] as? String ?? ""
        companyName = dictionary["CompanyName"] as? String ?? ""
        createdBy = dictionary["CreatedBy"] as? String ?? ""
        createdOn = dictionary["CreatedOn"] as? String ?? ""
        creditLimit = dictionary["CreditLimit"] as? NSNumber
        creditOnHold = dictionary["CreditOnHold"] as? NSNumber
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
       
        gender = dictionary["Gender"] as? String ?? ""
        governmentIdent = dictionary["GovernmentIdent"] as? String ?? ""
        groupInsurance = dictionary["GroupInsurance"] as? String ?? ""
        groupPensionPlan = dictionary["GroupPensionPlan"] as? String ?? ""
        id = dictionary["Id"] as? String ?? ""
        income = dictionary["Income"] as? NSNumber
        if fullName == "Donald Trump" {
            print(income)
            if let incme = dictionary["Income"] as? Int {
                print(incme)
            }else if let incme = dictionary["Income"] as? NSNumber {
                print(incme)
            }
        }
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
        revenue = dictionary["Revenue"] as? NSNumber
        salutation = dictionary["Salutation"] as? String ?? ""
        spousePartnerName = dictionary["SpousePartnerName"] as? String ?? ""
        state = dictionary["State"] as? String ?? ""
        suffix = dictionary["Suffix"] as? String ?? ""
        telephone1 = dictionary["Telephone1"] as? String ?? ""
        telephone2 = dictionary["Telephone2"] as? String ?? ""
        telephone3 = dictionary["Telephone3"] as? String ?? ""
        title = dictionary["Title"] as? String ?? ""
        webSiteUrl = dictionary["WebSiteUrl"] as? String ?? ""
        country = dictionary["Country"] as? String ?? ""
    }
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        //        businessPhoneExt = dictionary["Telephone1Ext"] as? String ?? ""
        if businessPhoneExt != nil{
            dictionary["Telephone1Ext"] = businessPhoneExt
        }
        if maritalStatus != nil{
            dictionary["MaritalStatus"] = maritalStatus
        }
        if ChildrensNames != nil{
            dictionary["ChildrensNames"] = ChildrensNames
        }
        if spousePartnerID != nil{
            dictionary["SpousePartnerId"] = spousePartnerID
        }
        if powerOfAttronyID != nil{
            dictionary["PowerofAttorneyId"] = powerOfAttronyID
        }
        if clientSince != nil{
            dictionary["ClientSince"] = clientSince
        }
        if executorID != nil{
            dictionary["ExecutorId"] = executorID
        }
        if anniversay != nil{
            dictionary["Anniversary"] = anniversay
        }
        if BirthDate != nil{
            dictionary["BirthDate"] = BirthDate
        }
        if renewDate != nil{
            dictionary["ReviewDate"] = renewDate
        }
        if licenseExpiry != nil{
            dictionary["DriversLicenseExpiry"] = licenseExpiry
        }
        if country != nil{
            dictionary["Country"] = country
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
        if companyId != nil{
            dictionary["CompanyId"] = companyId
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
        if gender != nil{
            dictionary["Gender"] = gender
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
       
        businessPhoneExt = aDecoder.decodeObject(forKey: "Telephone1Ext") as? String ?? ""
        maritalStatus = aDecoder.decodeObject(forKey: "MaritalStatus") as? String ?? ""
        ChildrensNames = aDecoder.decodeObject(forKey: "ChildrensNames") as? String ?? ""
        spousePartnerID = aDecoder.decodeObject(forKey: "SpousePartnerId") as? String ?? ""
        powerOfAttronyID = aDecoder.decodeObject(forKey: "PowerofAttorneyId") as? String ?? ""
        executorID = aDecoder.decodeObject(forKey: "ExecutorId") as? String ?? ""
        addressLine1 = aDecoder.decodeObject(forKey: "AddressLine1") as? String ?? ""
        addressLine2 = aDecoder.decodeObject(forKey: "AddressLine2") as? String ?? ""
        addressLine3 = aDecoder.decodeObject(forKey: "AddressLine3") as? String ?? ""
        assistantName = aDecoder.decodeObject(forKey: "AssistantName") as? String ?? ""
        assistantPhone = aDecoder.decodeObject(forKey: "AssistantPhone") as? String ?? ""
        city = aDecoder.decodeObject(forKey: "City") as? String ?? ""
        clientClassId = aDecoder.decodeObject(forKey: "ClientClassId") as? String ?? ""
        companyId = aDecoder.decodeObject(forKey: "CompanyId") as? String ?? ""
        companyName = aDecoder.decodeObject(forKey: "CompanyName") as? String ?? ""
        createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String ?? ""
        createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String ?? ""
        creditLimit = aDecoder.decodeObject(forKey: "CreditLimit") as? NSNumber
        creditOnHold = aDecoder.decodeObject(forKey: "CreditOnHold") as? NSNumber
        department = aDecoder.decodeObject(forKey: "Department") as? String ?? ""
        descriptionField = aDecoder.decodeObject(forKey: "Description") as? String ?? ""
        driversLicenseNumber = aDecoder.decodeObject(forKey: "DriversLicenseNumber") as? String ?? ""
        eMailAddress1 = aDecoder.decodeObject(forKey: "EMailAddress1") as? String ?? ""
        eMailAddress2 = aDecoder.decodeObject(forKey: "EMailAddress2") as? String ?? ""
        eMailAddress3 = aDecoder.decodeObject(forKey: "EMailAddress3") as? String ?? ""
        executorName = aDecoder.decodeObject(forKey: "ExecutorName") as? String ?? ""
        familyNotes = aDecoder.decodeObject(forKey: "FamilyNotes") as? String ?? ""
        fax = aDecoder.decodeObject(forKey: "Fax") as? String ?? ""
        firstName = aDecoder.decodeObject(forKey: "FirstName") as? String ?? ""
        ftpSiteUrl = aDecoder.decodeObject(forKey: "FtpSiteUrl") as? String ?? ""
        fullName = aDecoder.decodeObject(forKey: "FullName") as? String ?? ""
        gender = aDecoder.decodeObject(forKey: "Gender") as? String ?? ""
        governmentIdent = aDecoder.decodeObject(forKey: "GovernmentIdent") as? String ?? ""
        groupInsurance = aDecoder.decodeObject(forKey: "GroupInsurance") as? String ?? ""
        groupPensionPlan = aDecoder.decodeObject(forKey: "GroupPensionPlan") as? String ?? ""
        id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
        income = aDecoder.decodeObject(forKey: "Income") as? NSNumber
        jobTitle = aDecoder.decodeObject(forKey: "JobTitle") as? String ?? ""
        lastName = aDecoder.decodeObject(forKey: "LastName") as? String ?? ""
        middleName = aDecoder.decodeObject(forKey: "MiddleName") as? String ?? ""
        mobilePhone = aDecoder.decodeObject(forKey: "MobilePhone") as? String ?? ""
        modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
        modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? ""
        moneyNotes = aDecoder.decodeObject(forKey: "MoneyNotes") as? String ?? ""
        nickName = aDecoder.decodeObject(forKey: "NickName") as? String ?? ""
        occupationNotes = aDecoder.decodeObject(forKey: "OccupationNotes") as? String ?? ""
        owningOrganizationUserId = aDecoder.decodeObject(forKey: "OwningOrganizationUserId") as? String ?? ""
        pager = aDecoder.decodeObject(forKey: "Pager") as? String ?? ""
        poBox = aDecoder.decodeObject(forKey: "PoBox") as? String ?? ""
        postal = aDecoder.decodeObject(forKey: "Postal") as? String ?? ""
        powerofAttorneyName = aDecoder.decodeObject(forKey: "PowerofAttorneyName") as? String ?? ""
        privateField = aDecoder.decodeObject(forKey: "Private") as? Bool
        recreationNotes = aDecoder.decodeObject(forKey: "RecreationNotes") as? String ?? ""
        revenue = aDecoder.decodeObject(forKey: "Revenue") as? NSNumber
        salutation = aDecoder.decodeObject(forKey: "Salutation") as? String ?? ""
        spousePartnerName = aDecoder.decodeObject(forKey: "SpousePartnerName") as? String ?? ""
        state = aDecoder.decodeObject(forKey: "State") as? String ?? ""
        suffix = aDecoder.decodeObject(forKey: "Suffix") as? String ?? ""
        telephone1 = aDecoder.decodeObject(forKey: "Telephone1") as? String ?? ""
        telephone2 = aDecoder.decodeObject(forKey: "Telephone2") as? String ?? ""
        telephone3 = aDecoder.decodeObject(forKey: "Telephone3") as? String ?? ""
        title = aDecoder.decodeObject(forKey: "Title") as? String ?? ""
        webSiteUrl = aDecoder.decodeObject(forKey: "WebSiteUrl") as? String ?? ""
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        
        if businessPhoneExt != nil{
            aCoder.encode(businessPhoneExt, forKey: "Telephone1Ext")
        }
        if ChildrensNames != nil{
            aCoder.encode(ChildrensNames, forKey: "ChildrensNames")
        }
        if spousePartnerID != nil{
            aCoder.encode(spousePartnerID, forKey: "SpousePartnerId")
        }
        if powerOfAttronyID != nil{
            aCoder.encode(powerOfAttronyID, forKey: "PowerofAttorneyId")
        }
        if executorID != nil{
            aCoder.encode(executorID, forKey: "ExecutorId")
        }
        if addressLine1 != nil{
            aCoder.encode(addressLine1, forKey: "AddressLine1")
        }
        if addressLine2 != nil{
            aCoder.encode(addressLine2, forKey: "AddressLine2")
        }
        if addressLine3 != nil{
            aCoder.encode(addressLine3, forKey: "AddressLine3")
        }
        if assistantName != nil{
            aCoder.encode(assistantName, forKey: "AssistantName")
        }
        if assistantPhone != nil{
            aCoder.encode(assistantPhone, forKey: "AssistantPhone")
        }
        if city != nil{
            aCoder.encode(city, forKey: "City")
        }
        if clientClassId != nil{
            aCoder.encode(clientClassId, forKey: "ClientClassId")
        }
        if companyId != nil{
            aCoder.encode(companyId, forKey: "CompanyId")
        }
        if companyName != nil{
            aCoder.encode(companyName, forKey: "CompanyName")
        }
        if createdBy != nil{
            aCoder.encode(createdBy, forKey: "CreatedBy")
        }
        if createdOn != nil{
            aCoder.encode(createdOn, forKey: "CreatedOn")
        }
        if creditLimit != nil{
            aCoder.encode(creditLimit, forKey: "CreditLimit")
        }
        if creditOnHold != nil{
            aCoder.encode(creditOnHold, forKey: "CreditOnHold")
        }
        if department != nil{
            aCoder.encode(department, forKey: "Department")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "Description")
        }
        if driversLicenseNumber != nil{
            aCoder.encode(driversLicenseNumber, forKey: "DriversLicenseNumber")
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
        if executorName != nil{
            aCoder.encode(executorName, forKey: "ExecutorName")
        }
        if familyNotes != nil{
            aCoder.encode(familyNotes, forKey: "FamilyNotes")
        }
        if fax != nil{
            aCoder.encode(fax, forKey: "Fax")
        }
        if firstName != nil{
            aCoder.encode(firstName, forKey: "FirstName")
        }
        if ftpSiteUrl != nil{
            aCoder.encode(ftpSiteUrl, forKey: "FtpSiteUrl")
        }
        if fullName != nil{
            aCoder.encode(fullName, forKey: "FullName")
        }
        if gender != nil{
            aCoder.encode(gender, forKey: "Gender")
        }
        if governmentIdent != nil{
            aCoder.encode(governmentIdent, forKey: "GovernmentIdent")
        }
        if groupInsurance != nil{
            aCoder.encode(groupInsurance, forKey: "GroupInsurance")
        }
        if groupPensionPlan != nil{
            aCoder.encode(groupPensionPlan, forKey: "GroupPensionPlan")
        }
        if id != nil{
            aCoder.encode(id, forKey: "Id")
        }
        if income != nil{
            aCoder.encode(income, forKey: "Income")
        }
        if jobTitle != nil{
            aCoder.encode(jobTitle, forKey: "JobTitle")
        }
        if lastName != nil{
            aCoder.encode(lastName, forKey: "LastName")
        }
        if middleName != nil{
            aCoder.encode(middleName, forKey: "MiddleName")
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
        if moneyNotes != nil{
            aCoder.encode(moneyNotes, forKey: "MoneyNotes")
        }
        if nickName != nil{
            aCoder.encode(nickName, forKey: "NickName")
        }
        if occupationNotes != nil{
            aCoder.encode(occupationNotes, forKey: "OccupationNotes")
        }
        if owningOrganizationUserId != nil{
            aCoder.encode(owningOrganizationUserId, forKey: "OwningOrganizationUserId")
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
        if powerofAttorneyName != nil{
            aCoder.encode(powerofAttorneyName, forKey: "PowerofAttorneyName")
        }
        if privateField != nil{
            aCoder.encode(privateField, forKey: "Private")
        }
        if recreationNotes != nil{
            aCoder.encode(recreationNotes, forKey: "RecreationNotes")
        }
        if revenue != nil{
            aCoder.encode(revenue, forKey: "Revenue")
        }
        if salutation != nil{
            aCoder.encode(salutation, forKey: "Salutation")
        }
        if spousePartnerName != nil{
            aCoder.encode(spousePartnerName, forKey: "SpousePartnerName")
        }
        if state != nil{
            aCoder.encode(state, forKey: "State")
        }
        if suffix != nil{
            aCoder.encode(suffix, forKey: "Suffix")
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
        if title != nil{
            aCoder.encode(title, forKey: "Title")
        }
        if webSiteUrl != nil{
            aCoder.encode(webSiteUrl, forKey: "WebSiteUrl")
        }
        
    }
    
}
