//
//  IntroController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 21/08/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class IntroController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var pageControl: CHIPageControlPaprika!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var btnNext: UIButton!
    var arrTitles:NSArray = ["Mainmenu","calendarmenu","Calendardetailmenu","Contactmenu","Accountmenu"]
    var currentPage:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = arrTitles.count
        pageControl.tintColor = UIColor.lightGray
        pageControl.radius = 4

//        btnPrevious.isHidden = true
        
        for index in 0..<arrTitles.count {
            var xAxis:CGFloat = UIScreen.main.bounds.width
            xAxis = xAxis * CGFloat(index)
            let bgView1 = UIImageView()
            bgView1.frame = CGRect(x: xAxis, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            bgView1.image = UIImage.init(named:"bgintro")
            
            let bgView = UIImageView()
            bgView.frame = CGRect(x: xAxis, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            bgView.image = UIImage.init(named: (arrTitles[index] as? String)!)
            bgView.contentMode = .scaleAspectFit
         
//            let lblTitle = UILabel()
//            lblTitle.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height / 2 - 20, width: UIScreen.main.bounds.width, height: 40.0)
//            lblTitle.text = arrTitles[index] as? String
//            lblTitle.textAlignment = .center
//            lblTitle.font = UIFont(name: "Raleway-Bold", size: 30.0)!
//            lblTitle.textColor = UIColor.white
//            bgView.addSubview(lblTitle)
            
            scroll.addSubview(bgView1)
            scroll.addSubview(bgView)
        }
        
        scroll.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(arrTitles.count) , height: UIScreen.main.bounds.height)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedPrevious(_ sender: Any) {
        NavigationHelper().createMenuView()
    }
    @IBAction func tappedNext(_ sender: Any) {
        currentPage = currentPage + 1
        if currentPage == 4 {
            btnNext.setTitle("Finish", for: .normal)
        }
        if currentPage == 5 {
            NavigationHelper().createMenuView()
            return
        }
        scroll.setContentOffset(CGPoint(x: scroll.bounds.size.width * CGFloat(currentPage), y: 0), animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let total = scrollView.contentSize.width - scrollView.bounds.width
        let offset = scrollView.contentOffset.x
        let percent = Double(offset / total)
        
        let progress = percent * Double(arrTitles.count - 1)
        self.pageControl.progress = progress
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = pageControl.currentPage

        if currentPage == 4 {
            btnNext.setTitle("Finish", for: .normal)
        }else{
            btnNext.setTitle("Next", for: .normal)
        }
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
extension UIScrollView {
    func scrollTo(direction: ScrollDirection, animated: Bool = true) {
        self.setContentOffset(direction.contentOffsetWith(scrollView: self), animated: animated)
    }
}
enum ScrollDirection {
    case Top
    case Right
    case Bottom
    case Left
    
    func contentOffsetWith(scrollView: UIScrollView) -> CGPoint {
        var contentOffset = CGPoint.zero
        switch self {
        case .Top:
            contentOffset = CGPoint(x: 0, y: -scrollView.contentInset.top)
        case .Right:
            contentOffset = CGPoint(x: scrollView.contentSize.width - scrollView.bounds.size.width, y: 0)
        case .Bottom:
            contentOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        case .Left:
            contentOffset = CGPoint(x: -scrollView.contentInset.left, y: 0)
        }
        return contentOffset
    }
}
