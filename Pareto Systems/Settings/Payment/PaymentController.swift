//
//  PaymentController.swift
//  Pareto Systems
//
//  Created by Thabresh on 30/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class PaymentController: UIViewController {

    @IBOutlet weak var tblPayment: UITableView!
    var cardNames:NSArray = ["Master Card","Visa"]
    var cardDigits:NSArray = ["*0975","*7830"]
    var cardExpiry:NSArray = ["11/19","06/22"]
    var organizationID:String = ""
    var paymentList:[PaymentCard] = []
    var defaultCardID:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        tblPayment.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    //paymentListURL
    
    override func viewWillAppear(_ animated: Bool) {
        listOfPayments()
    }
    
    func listOfPayments() {
        let json: [String: Any] = ["OrganizationId": organizationID,
                                   "PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: paymentListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:PaymentMapping = PaymentMapping.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    self.getDefaultPaymentCards()
                    self.paymentList = []
                    self.paymentList = logModel.paymentCards
                    OperationQueue.main.addOperation {
                        self.tblPayment.reloadData()
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:logModel.responseMessage)
//                    NavigationHelper().setRootViewController()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    func getDefaultPaymentCards(){
        let json: [String: Any] = ["OrganizationId": organizationID,
                                   "PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: getDefaultPaymentCardURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:GetDefaultPaymentCardsModel = GetDefaultPaymentCardsModel.init(fromDictionary: jsonResponse)
                if logModel.valid {

                    if logModel.paymentCard != nil {
                        self.defaultCardID = logModel.paymentCard.id
                    }
                    OperationQueue.main.addOperation {
                        self.tblPayment.reloadData()
                    }
                }else{
//                    NavigationHelper.showSimpleAlert(message:"Invalid session.")
//                    NavigationHelper().setRootViewController()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedAdd(_ sender: Any) {
        let controller:AddCardsController = self.storyboard?.instantiateViewController(withIdentifier: "AddCardsController") as! AddCardsController
        controller.orgID = organizationID
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PaymentController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if paymentList.count > 0 {
            tableView.backgroundView = nil
            return 1
        } else {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messageLabel.text = "Retrieving data.\nPlease wait."
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "Raleway-Regular", size: 17.0)!
            messageLabel.sizeToFit()
            tableView.backgroundView = messageLabel;
        }
        return 0
    }
    //.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PaymentCell = (tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as? PaymentCell)!
        let eachCard:PaymentCard = paymentList[indexPath.row]
        cell.lblCardName.text = eachCard.brand
        cell.lblDigits.text = "*" + eachCard.last4
        
        var expiryYear:String = String(eachCard.expYear)
        if expiryYear.count > 2 {
            expiryYear = String(expiryYear.prefix(2))
        }
        let expiryMonth:String = String(eachCard.expMonth)
        let conString:String = expiryMonth + "/" + expiryYear
        cell.lblExpiry.text = conString

        if eachCard.id == defaultCardID {
            cell.btnActive.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else{
            cell.btnActive.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
        }
        cell.btnActive.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        cell.btnActive.tag = indexPath.row
        
        return cell
    }
    @objc func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        print(btnsendtag.tag)
        let eachCard:PaymentCard = paymentList[btnsendtag.tag]
        if eachCard.id == defaultCardID {
            NavigationHelper.showSimpleAlert(message: "This card is already default, please choose a different payment card.")
        }else{
            DispatchQueue.main.async(execute: {
                AJAlertController.initialization().showAlert(aStrMessage: "Make default for this card?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                    if title == "Yes" {
                        self.makeDefaultCard(cardID: eachCard.id)
                    }
                })
            })
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let eachCard:PaymentCard = paymentList[indexPath.row]
//        print(eachCard.name)
//
//        let controller:AddCardsController = self.storyboard?.instantiateViewController(withIdentifier: "AddCardsController") as! AddCardsController
////        controller.cardDetails = eachCard
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            let eachCard:PaymentCard = self.paymentList[indexPath.row]
            DispatchQueue.main.async(execute: {
                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                    if title == "Yes" {
                        self.deleteCard(cardID: eachCard.id)
                    }
                })
            })
        })
        return [shareAction]
    }
    func makeDefaultCard(cardID:String) {
        let json: [String: Any] = ["OrganizationId": organizationID,
                                   "PassKey": passKey,
                                   "PaymentCardId":cardID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: setDefaultCardURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                if let getValid = jsonResponse["Valid"] as? Bool {
                    if getValid == true {
                        self.listOfPayments()
                    }else{
                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                        NavigationHelper.showSimpleAlert(message:responseMessage)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Please try in sometime")
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    func deleteCard(cardID:String){
        let json: [String: Any] = ["OrganizationId": organizationID,
                                   "PassKey": passKey,
                                   "PaymentCardId":cardID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: deletePaymentCardURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                if let getValid = jsonResponse["Valid"] as? Bool {
                    if getValid == true {
                        self.listOfPayments()
                    }else{
                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                        NavigationHelper.showSimpleAlert(message:responseMessage)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Please try in sometime")
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
}
extension PaymentController:URLSessionDelegate {
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let authMethod = challenge.protectionSpace.authenticationMethod
        
        guard challenge.previousFailureCount < 1, authMethod == NSURLAuthenticationMethodServerTrust,
            let trust = challenge.protectionSpace.serverTrust else {
                completionHandler(.performDefaultHandling, nil)
                return
        }
        
        completionHandler(.useCredential, URLCredential(trust: trust))
    }
}
