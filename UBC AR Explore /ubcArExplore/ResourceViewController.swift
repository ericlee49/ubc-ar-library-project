//
//  ResourceViewController.swift
//  UBC-AR-Explore
//
//  Created by Eric Lee on 2017-06-22.
//  Copyright © 2017 Erics App House. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON



/*
 ---------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------
 */
// MARK: Custom button to store resourceLink


class GetResourceButton: UIButton {
    
    var resourceLink: String
    
    override init(frame: CGRect) {
        self.resourceLink = "https://ubc.ca"
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.resourceLink = "https://ubc.ca"
        
        super.init(coder: aDecoder)
    }
    
}



/*
 ---------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------
 */
// MARK: Resource Struct (Model)

struct Resource {
    
    var name: String
    var description: String
    var link: String
    
}
/*
 ---------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------
 */
// MARK: CollectionViewCell

class ResourceCell: UICollectionViewCell {
    
    
    // this will be called when a cell gets dequeued
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "UBC Library Guide 1"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.text = "This is a brief description of the UBC Library Guide 1.  The quick brown fox jumps over the lazy dog."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let visitLinkButton: GetResourceButton = {
        //let button = UIButton(type: .system)
        let button = GetResourceButton(type: .system)
        button.setTitle("Go to Resource", for: UIControlState())
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    let cellDividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    func setUpViews() {
        self.contentView.backgroundColor = UIColor(red: 138/255, green: 198/255, blue: 209/255, alpha: 1)
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        
        addSubview(visitLinkButton)
        visitLinkButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -17).isActive = true
        visitLinkButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        visitLinkButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        visitLinkButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: visitLinkButton.topAnchor, constant: -10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        
        addSubview(cellDividerLine)
        cellDividerLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cellDividerLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cellDividerLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        cellDividerLine.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





/*
 ---------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------
 */

// MARK: Resrouce Collection ViewController


class ResourceViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var resourceArray = [Resource]()
    var targetName: String? = "Name"
    var targetIDForResource = "0"
    let cellID = "cellID"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        // Register from ResourceCell Class:
        collectionView?.register(ResourceCell.self, forCellWithReuseIdentifier: cellID)
        
        self.navigationItem.title = "Resources"
        
        //SETUP LAYOUT:
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //remove spacing between cells
        layout.minimumLineSpacing = 0
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
        
        collectionView!.alwaysBounceVertical = true
        
        fetchResources()
        
        
    }
    

    
    // RESOURCE FETCHING
    
    let tron = TRON(baseURL: "http://138.197.166.13/")
    
    class ResourceHandler: JSONDecodable {
        
        let resources: [Resource]
        
        required init(json: JSON) throws {
            
            var resources = [Resource]()
            for resourceJson in json.array! {
                
                let name = resourceJson["name"].stringValue
                let description = resourceJson["description"].stringValue
                let link = resourceJson["link"].stringValue
                
                let resource = Resource(name: name, description: description, link: link)
                
                resources.append(resource)
            }
            self.resources = resources
        }
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON Error")
        }
    }
    
    
    fileprivate func fetchResources() {

        // Move to a background thread:
        DispatchQueue.global(qos: .userInitiated).async {
            let request: APIRequest<ResourceHandler, JSONError> = self.tron.request("resource")
            // PASSING IN TARGET ID:
            request.parameters = ["target" : self.targetIDForResource]
            request.perform(withSuccess: { (handler) in
                self.resourceArray = handler.resources
                
                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }

            }) { (err) in
                print("Failed to fetch JSON...", err)
                print("REQUEST............", request)
            }

        }

        


        
    }
    
    // Visiting Link After touching Button:
    func visitLinkButtonAction(_ sender: GetResourceButton) {
        
        let url = URL(string: sender.resourceLink)!
        
        // check if iOS 9.0 or later:
        if #available(iOS 9.0, *){
            let svc = MySafariViewContoller(url: url)
            self.present(svc, animated: true, completion: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
        
    }
    
    
    // COLLECTION VIEW Datasource:
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let resource = resourceArray[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellID, for: indexPath) as! ResourceCell
        cell.backgroundColor = .white
        cell.nameLabel.text = resource.name
        cell.descriptionLabel.text = resource.description
        cell.visitLinkButton.resourceLink = resource.link
        
        // Adding Button Action
        cell.visitLinkButton.addTarget(self, action: #selector(visitLinkButtonAction(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resourceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 180)
    }
}

