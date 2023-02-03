//
//  NotesListCell.swift
//  Blue Square
//
//  Created by Sayeed Syed on 10/21/19.
//  Copyright © 2019 VividInfotech. All rights reserved.
//

import UIKit

class NotesListCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var commentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var attachlblHeight: NSLayoutConstraint!
    @IBOutlet weak var regardingheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var noteHeightConstarint: NSLayoutConstraint!
    @IBOutlet weak var attachCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentsBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var editWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var commentExpandOutlet: UIButton!
    @IBOutlet weak var noteTxtViewOutlet: UILabel!
    @IBOutlet weak var createOnLbl: UILabel!
    @IBOutlet weak var draftLblOutlet: UILabel!
    @IBOutlet weak var searchBtnOutlet: UIButton!
    @IBOutlet weak var attachBtnOutlet: UIButton!
    @IBOutlet weak var commentbtnOutlet: UIButton!
    @IBOutlet weak var editbtnOutlet: UIButton!
    @IBOutlet weak var noteviewHeightConstraint: NSLayoutConstraint!
    var typeattachlist : [NoteRegardingList] = []
    var regattachlist : [ContactListResult] = []
    var regaccountlist : [GetAccountsListResult] = []
    var regTasklist : [TaskResult] = []
    var regAppointmentlist : [GetAppointmentModelData] = []
    var noteplace : String  = ""
    var comments : [CommnetResults] = []
    var allnames : [String] = []
    @IBOutlet weak var attachCollectionView: UICollectionView!
    @IBOutlet weak var commentTableview: UITableView!
    var cellusersList:[UserlistUser] = []
    @IBOutlet weak var regardingCollectionview: UICollectionView!
    @IBOutlet weak var commentTablHeightConstarint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        attachCollectionView.delegate = self
        attachCollectionView.dataSource = self
        regardingCollectionview.delegate = self
        regardingCollectionview.dataSource = self
        commentTableview.delegate = self
        commentTableview.dataSource = self
        commentTableview.rowHeight = UITableViewAutomaticDimension
        commentTableview.estimatedRowHeight = UITableViewAutomaticDimension
        regardingCollectionview.register(UINib(nibName: "NoteAttachmentCell", bundle: nil), forCellWithReuseIdentifier: "noteattachcell")
        attachCollectionView.register(UINib(nibName: "NoteAttachmentCell", bundle: nil), forCellWithReuseIdentifier: "noteattachcell")
        commentTableview.register(UINib(nibName: "NoteCommentCell", bundle: nil), forCellReuseIdentifier: "NoteCommentCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - UItableview Delegate and datasource methods
    func numberOfSections(in tableView: UITableView) -> Int{
      return comments.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCommentCell", for: indexPath as IndexPath) as! NoteCommentCell
        if(self.comments.count > 0){
            let creatBy = self.comments[indexPath.section].createdBy
            let sdate = (self.comments[indexPath.section].createdOn)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let st_date : Date = dateFormatter.date(from: sdate)!
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let firdate = dateFormatter.string(from: st_date)
            dateFormatter.dateFormat = "hh:mm:ss a"
            let secdate = dateFormatter.string(from: st_date)
            let ddtime = firdate + ", " + secdate
            var creatname : String = ""
            for(_,ele) in self.cellusersList.enumerated(){
                if(creatBy == ele.id)
                {
                    creatname = ele.firstName + " " + ele.lastName
                }
            }
            let fulstr = ddtime+" by "+creatname as NSString
            let aattributedString = NSMutableAttributedString(string: ddtime+" by "+creatname as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12.0)])
            let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12.0)]
            aattributedString.addAttributes(boldFontAttribute, range: fulstr.range(of: "by"))
            cell.dateLabel.attributedText = aattributedString
            cell.commentLblOutlet.text = self.comments[indexPath.section].comment}
        return cell
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
      func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if(section == 0)
        {
            return 0
        }else{
            return 10}
    }
      func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    //MARK: - UIcollectionviewDelegate and datasource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == attachCollectionView)
        {
            return self.typeattachlist.count

        }else
        {
            return allnames.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == attachCollectionView)
        {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteattachcell", for: indexPath as IndexPath) as! NoteAttachmentCell
        cell.noteattachbtnOutlet.setTitle(self.typeattachlist[indexPath.item].name, for: .normal)
            cell.contentView.layer.cornerRadius = 10.0
            cell.contentView.layer.borderColor = UIColor.darkGray.cgColor
            cell.contentView.layer.borderWidth  = 1.0
            cell.contentView.layer.masksToBounds = true
        return cell
        }
        else
        {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteattachcell", for: indexPath as IndexPath) as! NoteAttachmentCell
            cell.noteattachbtnOutlet.setTitle(allnames[indexPath.item], for: .normal)
            cell.contentView.layer.cornerRadius = 10.0
            cell.contentView.layer.borderColor = UIColor.darkGray.cgColor
            cell.contentView.layer.borderWidth  = 1.0
            cell.contentView.layer.masksToBounds = true
              return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 38)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == attachCollectionView)
        {
            if(self.noteplace == "contact")
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: ContactssController.attachdownnotify), object: nil, userInfo: ["noteid" : self.typeattachlist[indexPath.item].noteID!, "attachid" : self.typeattachlist[indexPath.item].id!, "filename" : self.typeattachlist[indexPath.item].name!])
            }
            else if(self.noteplace == "appointment")
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: UpdatenewappointmentVC.attachdownnotify), object: nil, userInfo: ["noteid" : self.typeattachlist[indexPath.item].noteID!, "attachid" : self.typeattachlist[indexPath.item].id!, "filename" : self.typeattachlist[indexPath.item].name!])
            }
            else if(self.noteplace == "task")
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: UpdatenewtaskVC.attachdownnotify), object: nil, userInfo: ["noteid" : self.typeattachlist[indexPath.item].noteID!, "attachid" : self.typeattachlist[indexPath.item].id!, "filename" : self.typeattachlist[indexPath.item].name!])
            }
            else
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:  NewAccountsController.accoundownnotify), object: nil, userInfo: ["noteid" : self.typeattachlist[indexPath.item].noteID!, "attachid" : self.typeattachlist[indexPath.item].id!, "filename" : self.typeattachlist[indexPath.item].name!])
            }
        }
        else
        {
              if(self.noteplace == "contact")
              {
                for(_,ele) in self.regattachlist.enumerated(){
                    if(ele.fullName == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ContactssController.regardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
                for(_,ele) in self.regaccountlist.enumerated(){
                    if(ele.name == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ContactssController.accountregardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
                for(_,ele) in self.regTasklist.enumerated() {
                    if(ele.subject == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ContactssController.taskregardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
                for(_,ele) in self.regAppointmentlist.enumerated(){
                    if(ele.subject == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ContactssController.appointementregardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
             }
              else if (self.noteplace == "appointment")
            {
                for(_,ele) in self.regattachlist.enumerated(){
                    if(ele.fullName == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UpdatenewappointmentVC.regardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
                for(_,ele) in self.regaccountlist.enumerated(){
                    if(ele.name == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UpdatenewappointmentVC.accountregardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
                for(_,ele) in self.regTasklist.enumerated() {
                    if(ele.subject == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UpdatenewappointmentVC.taskregardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
                for(_,ele) in self.regAppointmentlist.enumerated(){
                    if(ele.subject == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UpdatenewappointmentVC.appointementregardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
              }
              else if (self.noteplace == "task")
            {
                for(_,ele) in self.regattachlist.enumerated(){
                    if(ele.fullName == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UpdatenewtaskVC.regardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
                for(_,ele) in self.regaccountlist.enumerated(){
                    if(ele.name == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UpdatenewtaskVC.accountregardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
                for(_,ele) in self.regTasklist.enumerated() {
                    if(ele.subject == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UpdatenewtaskVC.taskregardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
                for(_,ele) in self.regAppointmentlist.enumerated(){
                    if(ele.subject == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UpdatenewtaskVC.appointementregardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
              }
            else
            {
                for(_,ele) in self.regattachlist.enumerated(){
                    if(ele.fullName == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NewAccountsController.conatctnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
                for(_,ele) in self.regaccountlist.enumerated(){
                    if(ele.name == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NewAccountsController.accountnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
                for(_,ele) in self.regTasklist.enumerated() {
                    if(ele.subject == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NewAccountsController.taskregardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
                for(_,ele) in self.regAppointmentlist.enumerated(){
                    if(ele.subject == allnames[indexPath.item])
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NewAccountsController.appointementregardingnotify), object: nil, userInfo: ["item" : ele])
                        break
                    }
                }
            }
          
        }
    }
}
extension NotesListCell:URLSessionDelegate {
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
