//
//  ViewController.swift
//  notifyvisitors
//
//  Created by ashraf-nv on 12/14/2023.
//  Copyright (c) 2023 ashraf-nv. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    
    @objc func nvButtonClickAction(sender : UIButton) {
        
        switch sender.tag {
        case nvButtonActionType.showInAppBannerOrSurvey.rawValue: do {
            notifyvisitors.show(nil, customRule: nil)
            break;
        }
        case nvButtonActionType.launchNotificationCenter.rawValue: do {
            let centerConfig = NVCenterStyleConfig()
            centerConfig.setFirstTabWithTabLable("promo", tagDisplayName: "Promotional")
            centerConfig.setSecondTabWithTabLable("tansactional", tagDisplayName: "Transactional")
            centerConfig.setThirdTabWithTabLable("others", tagDisplayName: "Others")
          
            notifyvisitors.notificationCenter(withConfiguration: nil)
            break;
        }
        default: do {
            print("invalid button action found")
            break;
        }
        }
    }
    
    let scrollView: UIScrollView = {
    let sc1 = UIScrollView()
    sc1.backgroundColor = .clear
    sc1.bounces = false
    sc1.showsHorizontalScrollIndicator = false
    sc1.showsVerticalScrollIndicator = false
    return sc1
    }()
    
    let scrollContentView: UIView = {
             let scCV = UIView()
        scCV.backgroundColor = .clear
          
        return scCV
        
    }()
    
    let nvSDKVersionInfoLabel: UILabel = {
let l1 = UILabel()
let nvBrandID = Bundle.main.object(forInfoDictionaryKey: "nvBrandID")
    
l1.text = "Goto info.plist file of this sample app and replace values of 2 keys i.e. nvBrnadID and nvSecretKey with your account's credentials (brandID and secrect key) to get that login to your notifyvisitors account and goto Settings >> Store Integration"
        l1.textAlignment = .center
        l1.textColor = .white
        l1.numberOfLines = 0
        l1.font = UIFont(name: "ChalkDuster-Bold", size: 18)
        return l1
        
    }()
    
    
    let showInAppBannerorSurveyBtn: UIButton = {
          let b1 = UIButton(type: .system)
          b1.setTitleColor(.black, for: .normal)
          b1.setTitle("InApp Banner or Survey", for: .normal)
          b1.layer.cornerRadius = 10
        b1.backgroundColor = .white
          return b1
      }()
    
    let notificationCenterBtn: UIButton = {
            let b2 = UIButton(type: .system)
            b2.setTitleColor(.black, for: .normal)
            b2.setTitle("Notification Center", for: .normal)
            b2.layer.cornerRadius = 10
        b2.backgroundColor = .white
            return b2
        }()
    
    override func viewDidLoad() {
        
        if #available(iOS 13.0, *) {
         let navAppearance = UINavigationBarAppearance()
            navAppearance.configureWithDefaultBackground()
            self.navigationController?.navigationBar.standardAppearance = navAppearance
            self.navigationController?.navigationBar.compactAppearance = navAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navAppearance
        }
        
        super.viewDidLoad()
        setupUIScrollView()
        setupSDKVersionInfoLabel()
        setupInAppBannerORSurveyButton()
        setupNotificationCenterButton()
        
        self.scrollContentView.anchors(top: nil, topPad: 0, bottom: notificationCenterBtn.bottomAnchor, bottomPad: -40, left:nil, leftPad: 0, right: nil, rightPad: 0, height: 0, width: 0)
    
        notifyvisitors.sharedInstance().delegate = self
        
    }
    
    
    private func setupUIScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
        //Constrain scroll view
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true;
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true;
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;

        self.scrollView.delegate = self
        self.scrollView.bounces = false
        setupScrollContainerView()
    }
    
    private func setupScrollContainerView() {
        self.scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.scrollContentView)
                
        self.scrollContentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true;
              
        self.scrollContentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true

        self.scrollContentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
             
        self.scrollContentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
         self.scrollContentView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    
    
    private func setupSDKVersionInfoLabel()  {
        self.scrollContentView.addSubview(nvSDKVersionInfoLabel)
        if #available(iOS 11.0, *) {
        nvSDKVersionInfoLabel.anchors(top: self.scrollContentView.safeAreaLayoutGuide.topAnchor, topPad: 20, bottom:nil, bottomPad:0, left: self.scrollContentView.leftAnchor, leftPad:24, right: self.scrollContentView.rightAnchor, rightPad:24, height: 150, width:0)
        } else {
        nvSDKVersionInfoLabel.anchors(top: self.scrollContentView.topAnchor, topPad: 20, bottom:nil, bottomPad:0, left: self.scrollContentView.leftAnchor, leftPad:24, right: self.scrollContentView.rightAnchor, rightPad:24, height: 55, width:0)
        }

        }
    
    
    private func setupInAppBannerORSurveyButton() {
        self.scrollContentView.addSubview(showInAppBannerorSurveyBtn)
        showInAppBannerorSurveyBtn.anchors(top: nvSDKVersionInfoLabel.bottomAnchor, topPad:20, bottom:nil, bottomPad:0, left: self.scrollContentView.leftAnchor, leftPad: 24, right: self.scrollContentView.rightAnchor, rightPad: 24, height: 40, width:0)
        showInAppBannerorSurveyBtn.tag = nvButtonActionType.showInAppBannerOrSurvey.rawValue
        showInAppBannerorSurveyBtn.addTarget(self, action: #selector(self.nvButtonClickAction(sender:)), for: .touchUpInside)
        }
            
         
            

     private func setupNotificationCenterButton() {
        self.scrollContentView.addSubview(notificationCenterBtn)
         notificationCenterBtn.anchors(top: showInAppBannerorSurveyBtn.bottomAnchor, topPad:20, bottom:nil, bottomPad:0, left: self.scrollContentView.leftAnchor, leftPad: 24, right: self.scrollContentView.rightAnchor, rightPad: 24, height: 40, width:0)
         notificationCenterBtn.tag = nvButtonActionType.launchNotificationCenter.rawValue
         notificationCenterBtn.addTarget(self, action:#selector(self.nvButtonClickAction(sender:)), for:.touchUpInside)
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        notifyvisitors.scrollViewDidScroll(scrollView)
    }
}


// MARK: - Notifyvisitors Delegate Methods

extension ViewController: notifyvisitorsDelegate {

    func notifyvisitorsEventsResponseCallback(_ callback: [AnyHashable : Any]?) {
        let callbackDict = NSMutableDictionary(dictionary: callback ?? [:])
        print("notifyvisitorsEventsResponseCallback = \(callbackDict)")
    }
    
}
