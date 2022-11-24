//
//  ViewController.swift
//  Meditation
//
//  Created by user on 15.11.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class Main: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var collectionFeeling: UICollectionView!
    @IBOutlet weak var collectionQuote: UICollectionView!
    
    
    let userDefault = UserDefaults.standard
    
    struct Feeling {
        var title: String
        var image: String
        var position: String
    }
    
    
    var feelingCollection: [Feeling] = []
    
    struct Quote {
        var title: String
        var description: String
        var picture: String
    }
    
    var quoteCollection: [Quote] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserInformation()
        requestFeeling()
        requestQuote()
      
    }
    private func loadUserInformation() {
        let userName = userDefault.string(forKey: "nickName")
        titleLabel.text = "С возвращением, \(userName ?? "user")!"
        
        let avatar = userDefault.string(forKey: "avatar")
        userPicture.layer.cornerRadius = userPicture.frame.size.height / 2
        if let data = try? Data(contentsOf: URL(string: avatar!)!) {
            userPicture.image = UIImage(data: data)
        }
    }
    
    func requestFeeling() {
        AF.request(AppDelegate().baseUrl + "feelings", method: .get).response {
            response in
            switch response.result {
            case .success(let value):
                self.parseFeeling(value!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func parseFeeling(_ data: Data) {
        let json = JSON(data)
        for item in 0..<json["data"].count {
        feelingCollection.append(
            Feeling(
                title: json["data"][item]["title"].stringValue,
                image: json["data"][item]["image"].stringValue,
                position: json["data"][item]["position"].stringValue))
        }
        
        feelingCollection.sort { $0.position < $1.position }
        collectionFeeling.reloadData()
    }
    
    func requestQuote() {
        
        AF.request(AppDelegate().baseUrl + "quotes").response { response in
            switch response.result {
            case .success(let value):
                self.parseQuote(value!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func parseQuote(_ data: Data) {
        let json = JSON(data)
        for item in 0..<json["data"].count {
        quoteCollection.append(
            Quote(title: json["data"][item]["title"].stringValue,
                  description: json["data"][item]["description"].stringValue,
                  picture: json["data"][item]["image"].stringValue))
        }
        collectionQuote.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionQuote {
            return quoteCollection.count
            }
        
        return feelingCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionQuote {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quoteCell", for: indexPath) as! QuoteCell
            
            cell.name.text = quoteCollection[indexPath.row].title
            cell.desc.text = quoteCollection[indexPath.row].description
            if let data = try? Data(contentsOf: URL(string: quoteCollection[indexPath.row].picture)!) {
                cell.backgroundImage.image = UIImage(data: data)
            }
            return cell
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feelingCell", for: indexPath) as! FeelingCell
        cell.picture.layer.cornerRadius = cell.picture.frame.size.height / 3
        if let data = try? Data(contentsOf: URL(string: feelingCollection[indexPath.row].image)!) {
            cell.picture.image = UIImage(data: data)
        }
        cell.subtitle.text = feelingCollection[indexPath.row].title
        
        return cell
    }
}
