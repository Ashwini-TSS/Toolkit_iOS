//
//  ToolkitPackagesController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 05/10/18.
//  Copyright © 2018 VividInfotech. All rights reserved.
//

import UIKit

class ToolkitPackagesController: UIViewController {

    @IBOutlet weak var tblItems: UITableView!
    var priceIDList:NSMutableArray = []
    var pricesList:NSMutableArray = []
    var purchaseLists:PurchaseListModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Purchase Toolkit"
        getListOfPackages()
        // Do any additional setup after loading the view.
    }
    func getListOfPackages(){
        let json: [String: Any] = ["PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: packagesURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            self.priceIDList = []
            self.pricesList = []
            
            DispatchQueue.main.async {
                print(json)
                self.purchaseLists = PurchaseListModel.init(fromDictionary: jsonResponse)                
                if self.purchaseLists.valid {
                    for index in 0..<self.purchaseLists.pricingSchemeTiers.count {
                        self.priceIDList.add(self.purchaseLists.pricingSchemeTiers[index].pricingSchemeId)
                        self.pricesList.add("\(self.purchaseLists.pricingSchemeTiers[index].pricePerUser!)")
                    }
                }
                self.tblItems.reloadData()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension ToolkitPackagesController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if purchaseLists == nil {
            return 0
        }
        return purchaseLists.verticalPackages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeCell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.lblTitle.text = self.purchaseLists.verticalPackages[indexPath.row].name
    cell.lblDescription.setHtmlText(self.purchaseLists.verticalPackages[indexPath.row].descriptionField)
        
        let url = URL(string: imageLoadURL + self.purchaseLists.verticalPackages[indexPath.row].largeImageUri)
//        Sankar Update
//        cell.productImage.kf.setImage(with: url)
        
        cell.lblPlan.text = self.purchaseLists.verticalPackages[indexPath.row].tagLine
        
        if self.purchaseLists.verticalPackages[indexPath.row].free {
            cell.lblPrice.text = "FREE"
            cell.btnBuy.setTitle("SUBSCRIBE", for: .normal)
        }else{
            cell.btnBuy.setTitle("BUY", for: .normal)
            if priceIDList.contains(self.purchaseLists.verticalPackages[indexPath.row].pricingSchemeId) {
                let getIndex = priceIDList.index(of: self.purchaseLists.verticalPackages[indexPath.row].pricingSchemeId)
                let priceStr:String = pricesList[getIndex] as! String
                cell.lblPrice.text = "$ \(priceStr) USD/MO Per User"
            }
        }
        
        cell.btnBuy.tag = indexPath.row
        cell.btnBuy.addTarget(self, action: #selector(buyAction), for: .touchUpInside)

        
        cell.btnLearnMore.tag = indexPath.row
        cell.btnLearnMore.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        //        if self.purchaseLists.pricingSchemeTiers.contains(self.pr)
        
        //        cell.itemImg.image = UIImage.init(named: recentTabImages[indexPath.row] as! String)
        //        cell.itemTitle.text = (recentItmeTabs[indexPath.row] as! String)
        return cell
    }
    
    @objc func buyAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        var priceString:String = ""
        
        if self.purchaseLists.verticalPackages[sender.tag].free {
            priceString = "FREE"
        }else{
            if priceIDList.contains(self.purchaseLists.verticalPackages[sender.tag].pricingSchemeId) {
                let getIndex = priceIDList.index(of: self.purchaseLists.verticalPackages[sender.tag].pricingSchemeId)
                let priceStr:String = pricesList[getIndex] as! String
                priceString = "$ \(priceStr) /MO Per User"
            }
        }
        
        let controller:ToolkitOrganizationSelectionController = self.storyboard?.instantiateViewController(withIdentifier: "ToolkitOrganizationSelectionController") as! ToolkitOrganizationSelectionController
        controller.planPrice = priceString
        controller.package = self.purchaseLists.verticalPackages[btnsendtag.tag]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func buttonAction(sender: UIButton!) {
//        learnMoreText.setContentOffset(.zero, animated: false)
//        let btnsendtag: UIButton = sender
//        learnMoreText.setHtmlTextView(self.purchaseLists.verticalPackages[btnsendtag.tag].outline)
//        learnmoreBG.isHidden = false
//        tblItems.isHidden = true
        //self.purchaseLists.verticalPackages[indexPath.row].tagLine
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension ToolkitPackagesController:URLSessionDelegate {
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
