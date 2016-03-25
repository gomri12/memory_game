//
//  ViewController.swift
//  memory game
//
//  Created by omri & noy on 3/21/16.
//  Copyright © 2016 omri ios. All rights reserved.
//


import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!
    let rows = 5
    let cols = 4
    let TileMargin = CGFloat(5.0)
    var game: GameController!
    
    @IBAction func restart_btn(sender: AnyObject) {
        resetGame()
    }
    func resetGame(){
        game.reset()
        scoreLabel.text = "0/\(rows * cols / 2)"
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.scrollEnabled=false
        self.collectionView.pagingEnabled=false
        
        game = GameController(rows:cols,cols:rows)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: Relative cells it for me. how do we megishim lol submit  think with github
        //ok you finisheD? I wanted to add some feature to the icons to be a bit different...
        // some thing like random icon eache initmat ok
        return cols
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return rows
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let colsCount = CGFloat(cols)
        let dimentions = collectionView.frame.width / colsCount - (colsCount * TileMargin * 0.8)
        return CGSize(width: dimentions, height: dimentions) 
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(TileMargin, TileMargin, TileMargin, TileMargin)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.label.text = game.faceDown
        cell.mySelected = false
        cell.showFace = false
        
        cell.backgroundColor = UIColor.blackColor()
        // not nil fix...
        if (indexPath.section == 0 && indexPath.row == 0){ game.firstCell = cell }
        if (indexPath.section == 0 && indexPath.row == 1){ game.secondCell = cell }
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        
        let score = game.move(cell,indexPath:indexPath)
        self.scoreLabel.text = "\(score)/\(rows * cols / 2)"
        if (score == rows * cols / 2){
            //won the game
            let alert = UIAlertController(title: "You Won", message: "Great Job Dude!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title:"Yay!",style: .Default,handler: {(action:UIAlertAction!) in self.resetGame()}))
            showViewController(alert, sender: nil)
            
        }
    }
}

