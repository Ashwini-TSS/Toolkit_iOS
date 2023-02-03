//
//  TeammemberslistVC.swift
//  Blue Square
//
//  Created by TECNVATORS SOFTWARE on 20/03/20.
//  Copyright © 2020 VividInfotech. All rights reserved.
//

import UIKit

class TeammemberslistVC: UIViewController,UITableViewDelegate,UITableViewDataSource,URLSessionDelegate,UISearchBarDelegate {
   
    var ArrayEmail : [String] = []
    var ArrayId : [String] = []
    var FilterArrayEmail : [String] = []
    @IBOutlet var Teammemberstblview: UITableView!
    
    var filterkey : String = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Teammemberstblview.tableFooterView = UIView()
        Getteammeberslist()

        // Do any additional setup after loading the view.
    }
    
    
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(filterkey == "1"){
        if(ArrayEmail.count > 0) {
            return ArrayEmail.count
        }}
        else if(filterkey == "2"){
            if(FilterArrayEmail.count > 0) {
                return FilterArrayEmail.count
           }
        }
           return 0
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TeammemberCell
           cell.selectionStyle = UITableViewCell.SelectionStyle.none
           if(filterkey == "1"){
            cell.Lblname.text = ArrayEmail[indexPath.row]
           }
           else {
            cell.Lblname.text = FilterArrayEmail[indexPath.row]
           }
           return cell
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: "TeammembesDetailsVC") as! TeammembesDetailsVC
        if(filterkey == "1"){
        detailvc.selectedId = self.ArrayId[indexPath.row]
        }
        else {
            let email = self.FilterArrayEmail[indexPath.row]
            for(index,ele) in self.ArrayEmail.enumerated(){
                if(ele == email){
                   detailvc.selectedId = self.ArrayId[index]
                }
            }
        }
        self.navigationController?.pushViewController(detailvc, animated: true)
    }
    
     func Getteammeberslist()
      {
            let json: [String: Any] = ["AscendingOrder": true,
                                       "OrderBy" : "FullName",
                                       "IncludeExtendedProperties":true,
                                       "ResultsPerPage":1000,
                                       "PageOffset":1,
                                       "ObjectName":"organization_user",
                                       "PassKey":passKey,
                                       "OrganizationId":currentOrgID]
         
            OperationQueue.main.addOperation {
                SVProgressHUD.show()
            }
            let url = URL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json")!
            var request = URLRequest(url: url)
            request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.addValue("en", forHTTPHeaderField: "Accept-Language")
            request.httpMethod = "POST"
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
                request.httpBody = jsonData
            }
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
            let task = session.dataTask(with: request){ data, response, error in
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
                guard let data = data, error == nil else {
                    return
                }
                do{
                 let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                 print(jsonObj)
                 guard let _:Dictionary = jsonObj as? [String:AnyObject] else{
                 return
                 }
                 let result = try JSON(data: data)
                 print(result)
                 for (index,_) in result["Results"].enumerated(){
                     print(result["Results"][index])
                     let dic = result["Results"][index]["FullName"].stringValue
                     let dicid = result["Results"][index]["Id"].stringValue
                    self.ArrayEmail.append(dic)
                    self.ArrayId.append(dicid)
                 }
                    self.Teammemberstblview.reloadData()
                }
               catch {
                 print(error.localizedDescription)
               }
            }
            task.resume()
    }


func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    FilterArrayEmail  = ArrayEmail
    if searchText.isEmpty == false {
        filterkey = "2"
        FilterArrayEmail = ArrayEmail.filter({ $0.lowercased().contains(searchText.lowercased()) })
    }
    Teammemberstblview.reloadData()
}

}
extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
