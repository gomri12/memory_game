//
//  VCMenu.swift
//  memory game
//
//  Created by omri ios on 4/29/16.
//  Copyright © 2016 omri ios. All rights reserved.
//

import UIKit
import CoreData
import Foundation


class VCMenu: UIViewController,UICollectionViewDelegate {
    
    var userList = [User]()
    
    override func viewDidLoad() {
        
        

    }

    @IBAction func highScoreBTN(sender: AnyObject) {
        self.highScorePopup()
    }
    
    @IBAction func exitBTN(sender: AnyObject) {
        exit(0)
    }
    func getAllPlayers(){
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Users")
        
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            
            for  user in results {
                print(user.valueForKey("username"))
                print(user.valueForKey("score"))
                let name = user.valueForKey("username") as! String
                let score = user.valueForKey("score") as! String
                let ustemp = User(name: name, score: score)
                userList.append(ustemp)
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    
    func highScorePopup(){
        getAllPlayers()
        //TODO: Sort The ARRAY!@$!
        
        let popup = UIAlertController(title: "Top 10 Players", message: "", preferredStyle: .Alert)
        
        for user in userList{
            popup.addAction((UIAlertAction(title: user.name+"   Score:"+user.score, style: UIAlertActionStyle.Default,handler: nil)))
        }
        self.presentViewController(popup, animated: true, completion: nil)
        
    }
}