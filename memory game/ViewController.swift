//
//  ViewController.swift
//  memory game
//
//  Created by omri ios on 3/21/16.
//  Copyright © 2016 omri ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    let faceDown = "?"
    let cards = ["A","B","C",
                 "D","E","F",
                 "G","H","I",
                 "J","K","L",
                 "M","N","O",
                 "P","Q","R",
                 "S","T","U"]
    var firstCardCell = CollectionViewCell()
    var secondCardCell = CollectionViewCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.label.text = faceDown
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        // reset prev attempt
        if (firstCardCell.label.text != "?" && secondCardCell.label.text != "?"){
            firstCardCell.label.text = "?"
            secondCardCell.label.text = "?"
        }
        // first card pick
        if (firstCardCell.label.text=="?" && secondCardCell.label.text == "?"){
            firstCardCell = cell
        }
        // second card pick
        if (firstCardCell.label.text != "?" && secondCardCell.label.text == "?"){
            secondCardCell = cell
        }
        
        cell.label.text = cards[indexPath.section * 3 + indexPath.row]
    }
//ani po aval lo yehol ledaber the boss go t iris near got it! I am watching tutorial so i am on and off on the code writing... ok.. u like to logo? too death-y it needs to bee innocentlal background! change to white yup...
}

