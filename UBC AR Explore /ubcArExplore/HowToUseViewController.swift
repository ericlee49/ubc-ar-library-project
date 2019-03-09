//
//  HowToViewController.swift
//  UBC-AR-App2
//
//  Created by Eric Lee on 2017-08-22.
//  Copyright © 2017 Erics App House. All rights reserved.
//

import UIKit

class HowToViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 138/255, green: 198/255, blue: 209/255, alpha: 1)
        self.navigationItem.title = "Getting Started"
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        setUpTextViews()
        
    }
    
    
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = " While exploring the UBC Library Facilities you can use this app to Scan Posters and other Targets. \n Make sure you're connected to a WiFi or Cellular Network \n\n • To begin scanning press the 'Begin Scanning' Button on the main menu \n\n • Use your device’s built in camera to pan over a Target \n\n • When the target is highlighted, you can then click the 'Get Resource(s)' button \n\n • You will then be able to access all relevant resources! Click below for a video demo: "
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    
    // Video Demo Button:
    let demoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("View Video Demo", for: UIControlState())
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(red: 0/255, green: 33/255, blue: 69/255, alpha: 1)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(changeButtonColor), for: .touchDown)
        button.addTarget(self, action: #selector(buttonOriginalColorState), for: .touchUpOutside)
        button.addTarget(self, action: #selector(visitDemoButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    func setUpTextViews(){
        
        view.addSubview(containerView)
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 475).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        
        containerView.addSubview(textLabel)
        
        textLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        textLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -25).isActive = true
        
        containerView.addSubview(demoButton)
        
        demoButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        demoButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20).isActive = true
        demoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        demoButton.widthAnchor.constraint(equalToConstant: 260).isActive = true
    }
    
    
    func buttonOriginalColorState(sender: UIButton){
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor(red: 0/255, green: 33/255, blue: 69/255, alpha: 1)
        
    }
    
    func changeButtonColor(sender: UIButton) {
        sender.setTitleColor(UIColor(red: 0/255, green: 33/255, blue: 69/255, alpha: 1), for: .normal)
        sender.backgroundColor = UIColor.lightGray
    }
    
    // Visiting Link After touching Button:
    func visitDemoButtonAction(sender: UIButton) {
        
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor(red: 0/255, green: 33/255, blue: 69/255, alpha: 1)
        
        let url = URL(string: "https://www.youtube.com/watch?v=pPD0cLdvjyQ")!
        
        // check if iOS 9.0 or later:
        if #available(iOS 9.0, *){
            let svc = MySafariViewContoller(url: url)
            self.present(svc, animated: true, completion: nil)
            //self.navigationController?.pushViewController(svc, animated: true)
        } else {
            UIApplication.shared.openURL(url)
        }
        
        
    }
    
    
}
