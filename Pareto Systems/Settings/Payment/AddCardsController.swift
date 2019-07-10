//
//  AddCardsController.swift
//  TermsClickable
//
//  Created by Test Technologies PVT LTD on 14/08/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit
import Stripe

class AddCardsController: UITableViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var cardNumberField: UITextField!
    @IBOutlet weak var cvcField: UITextField!
    @IBOutlet weak var expMonthField: UITextField!
    @IBOutlet weak var expYearField: UITextField!
    @IBOutlet weak var street1Field: UITextField!
    @IBOutlet weak var street2Field: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var postalField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    var orgID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add New Card"
        cardNumberField.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func tappedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tappedSave(_ sender: Any) {
        print(cardNumberField.text?.count as Any) //19
        print(cvcField.text?.count as Any) //3
        
        if nameField.text?.count == 0 || cardNumberField.text?.count == 0 || cvcField.text?.count == 0 || expMonthField.text?.count == 0 || expYearField.text?.count == 0 || cityField.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message: "Please enter the required fields")
            return
        }else if cardNumberField.text!.count < 19 {
            NavigationHelper.showSimpleAlert(message: "Please enter a valid card number")
            return
        }else if cvcField.text!.count < 3 {
            NavigationHelper.showSimpleAlert(message: "Please enter a valid CVC")
            return
        }
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
//            MBProgressHUD.showAdded(to: self.view, animated: true)

        }
        let expMonth = UInt(expMonthField.text!) //here number is of type *optional UInt*
        let expYear = UInt(expYearField.text!) //here number is of type *optional UInt*


//        let expMonth:Int = Int(expMonthField.text!)!
        let cardParams = STPCardParams()
        cardParams.number = cardNumberField.text!
        cardParams.expMonth = expMonth!
        cardParams.expYear = expYear!
        cardParams.cvc = cvcField.text!
        cardParams.name = nameField.text!
        cardParams.address.line1 = street1Field.text!
        cardParams.address.line2 = street2Field.text!
        cardParams.address.city = cityField.text!
        cardParams.address.state = stateField.text!
        cardParams.address.postalCode = postalField.text!
        cardParams.address.country = countryField.text!
        STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            OperationQueue.main.addOperation {
                SVProgressHUD.dismiss()
//                MBProgressHUD.hide(for: self.view, animated: true)

            }
            guard let token = token, error == nil else {
                // Present error to user...
                print("error:\(error.debugDescription)")
                print("error:\(String(describing: error?.localizedDescription))")
                NavigationHelper.showSimpleAlert(message: (error?.localizedDescription)!)

                return
            }
            print(token)
            self.createCard(token: token)
        }
    }
    
    func createCard(token:STPToken){
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
//            MBProgressHUD.showAdded(to: self.view, animated: true)

        }
        let headers = [
            "Content-Type": "application/json",
            "X-Stripe-Card-Id": "\(token)"
            ]
        let parameters = [
            "OrganizationId": orgID,
            "PassKey": passKey,
            ] as [String : Any]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.data.VCDataEndpoint/createPaymentCard.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = jsonData
        }
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            OperationQueue.main.addOperation {
                SVProgressHUD.dismiss()
//                MBProgressHUD.hide(for: self.view, animated: true)

            }
            guard let data = data, error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                print(jsonObj)
                
                guard let _:Dictionary = jsonObj as? [String:AnyObject] else{
                    return
                }
                let result = try JSON(data: data)
                print(result)
                
                
                let jsonResponse:NSDictionary = (jsonObj as? NSDictionary)!
                print(jsonResponse)
                
                if let getValid = jsonResponse["Valid"] as? Bool {
                    if getValid == true {
                       self.navigationController?.popViewController(animated: true)
                    }else{
                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                        NavigationHelper.showSimpleAlert(message:responseMessage)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Please try in sometime")
                }
            }catch {
                print(error.localizedDescription)
            }
        })
        
        dataTask.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 11
    }
   
        
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddCardsController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }
        
        if textField == cardNumberField {
            if range.location == 19 {
                return false
            }
            textField.text = currentText.grouping(every: 4, with: " ")
            return false
        }
        if textField == cvcField {
            if range.location == 3 {
                return false
            }
            return true
        }
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == expMonthField {
            showPicker(data: ["1","2","3","4","5","6","7","8","9","10","11","12"], pickerTitle: "Expiry Month", textField: textField)
            return false
        }else if textField == expYearField {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY"
            let getYear = Int(formatter.string(from: Date()))
            let next100Year = getYear! + 1000
            
            let completeYears:NSMutableArray = []
            for index in getYear!..<next100Year {
                completeYears.add("\(index)")
            }
            showPicker(data: completeYears, pickerTitle: "Expiry Year", textField: textField)
            return false
        }
        return true
    }
    func showPicker(data:NSArray,pickerTitle:String,textField:UITextField) {
        // Strings Picker
        self.view.endEditing(true)
        DPPickerManager.shared.showPicker(title: pickerTitle, selected: textField.text!, strings: data as! [String]) { (value, index, cancel) in
            if !cancel {
                textField.text = value
            }
        }
    }
}
extension AddCardsController:URLSessionDelegate {
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
extension String {
    func grouping(every groupSize: String.IndexDistance, with separator: Character) -> String {
        let cleanedUpCopy = replacingOccurrences(of: String(separator), with: "")
        return String(cleanedUpCopy.characters.enumerated().map() {
            $0.offset % groupSize == 0 ? [separator, $0.element] : [$0.element]
            }.joined().dropFirst())
    }
}
