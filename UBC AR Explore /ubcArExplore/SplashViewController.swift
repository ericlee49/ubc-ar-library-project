//
//  SplashViewController.swift
//  UBC-AR-Explore
//
//  Created by Eric Lee on 2017-07-04.
//  Copyright © 2017 Erics App House. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 138/255, green: 198/255, blue: 209/255, alpha: 1)
        
        self.navigationItem.title = "UBC AR Explore"
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        setUpViews()
        
    }
    
    // Button to begin scanning:
    let beginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Begin Scanning", for: UIControlState())
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 0/255, green: 33/255, blue: 69/255, alpha: 1)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(changeButtonColor), for: .touchDown)
        button.addTarget(self, action: #selector(buttonOriginalColorState), for: .touchUpOutside)
        button.addTarget(self, action: #selector(showCollectionView), for: .touchUpInside)
        
        return button
    }()
    
    // How to Use App Button:
    let howToUseAppButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("How to Use App", for: UIControlState())
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 0/255, green: 33/255, blue: 69/255, alpha: 1)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(changeButtonColor), for: .touchDown)
        button.addTarget(self, action: #selector(buttonOriginalColorState), for: .touchUpOutside)
        button.addTarget(self, action: #selector(showHowToUseAppView), for: .touchUpInside)
        
        return button
    }()
    
    // UBC Watermark image
    let watermarkImage: UIImageView = {
        let imageName = "watermark.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    // Push CollectionView onto navigation controller
    func showCollectionView(sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor(red: 0/255, green: 33/255, blue: 69/255, alpha: 1)
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    // Push HowToUse VC onto navigation controller
    func showHowToUseAppView(sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor(red: 0/255, green: 33/255, blue: 69/255, alpha: 1)
        
        let howToVC = HowToViewController()
        self.navigationController?.pushViewController(howToVC, animated: true)
    }
    
    func buttonOriginalColorState(sender: UIButton){
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor(red: 0/255, green: 33/255, blue: 69/255, alpha: 1)
        
    }
    
    func changeButtonColor(sender: UIButton) {
        sender.setTitleColor(UIColor(red: 0/255, green: 33/255, blue: 69/255, alpha: 1), for: .normal)
        sender.backgroundColor = UIColor.lightGray
    }
    

    
    func setUpViews(){
        self.view.addSubview(beginButton)
        beginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        beginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        beginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        beginButton.widthAnchor.constraint(equalToConstant: 260).isActive = true
        
        self.view.addSubview(howToUseAppButton)
        howToUseAppButton.centerXAnchor.constraint(equalTo: beginButton.centerXAnchor).isActive = true
        howToUseAppButton.topAnchor.constraint(equalTo: beginButton.bottomAnchor, constant: 20).isActive = true
        howToUseAppButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        howToUseAppButton.widthAnchor.constraint(equalToConstant: 260).isActive = true
        
        self.view.addSubview(watermarkImage)
        watermarkImage.bottomAnchor.constraint(equalTo: beginButton.topAnchor, constant: -10).isActive = true
        watermarkImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        watermarkImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        watermarkImage.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    
    
    
}
