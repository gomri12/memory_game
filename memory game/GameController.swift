//
//  GameController.swift
//  memory game
//
//  Created by omri & noy on 3/24/16.
//  Copyright © 2016 omri ios. All rights reserved.
//

import Foundation
import UIKit

class GameController : NSObject {
    
    private var rows = 4
    private var cols = 5
    private var score = 0

    private var cardsMat: [[String]]
    
    internal var firstCell: CollectionViewCell!
    internal var secondCell: CollectionViewCell!
    internal let faceDown = "?"
    
    init(rows:Int, cols:Int)
    {
        
        self.rows = rows
        self.cols = cols
        cardsMat = [[String]](count:rows,repeatedValue:[String](count:cols,repeatedValue:faceDown))
        
        super.init()
        
        initMatrix()
        shuffle()

    }
    
    func initMatrix()
    {
        var times = 1
        var intCharVal = 0x1F603 + arc4random_uniform(UInt32(20))
        var letter:Character = Character(UnicodeScalar(intCharVal))
        
        for i in 0..<rows{
            for j in 0..<cols{
                cardsMat[i][j] = "\(letter)"
                if(times % 2 == 0)
                {
                    intCharVal++
                    letter = Character(UnicodeScalar(intCharVal))
                }
                times++
            }
            
        }
    }
    
    func shuffle()
    {
        for i in 0..<rows{
            for j in 0..<cols{
                let x = Int(arc4random_uniform(UInt32(rows - i))) + i
                let y = Int(arc4random_uniform(UInt32(cols - j))) + j
                //print(x,y)
                swapCards(i, srcJ: j, dstI: x, dstJ: y)
            }
        }
    }
    
    func swapCards(srcI:Int,srcJ:Int,dstI:Int,dstJ:Int){
        let tmp = cardsMat[srcI][srcJ]
        cardsMat[srcI][srcJ] = cardsMat[dstI][dstJ]
        cardsMat[dstI][dstJ] = tmp
    }
    func reset(){
        score = 0
        initMatrix()
        shuffle()
    }
    dynamic func hideCards(timer : NSTimer)
    {
        self.firstCell.label.text = self.faceDown
        self.secondCell.label.text = self.faceDown
        self.firstCell.backgroundColor = UIColor.blackColor()
        self.secondCell.backgroundColor = UIColor.blackColor()
        self.firstCell.mySelected = false
        self.secondCell.mySelected = false
    }
    func checkMatch()->Bool{
        return (self.firstCell.mySelected && self.secondCell.mySelected &&      // first & second cell are SELECTED
               !self.firstCell.showFace && !self.secondCell.showFace &&         // first & second cells are NOT found already
                self.firstCell.label.text == self.secondCell.label.text)        // first & second cells are a MATCH
    }
    func checkFirst(cell:CollectionViewCell)->Bool{
        return (!cell.showFace && !cell.mySelected &&                           // cell has not been found or selected
            
               ((!self.firstCell.mySelected && !self.secondCell.mySelected) ||  // first & second cell are NOT SELECTED
                (self.firstCell.showFace && self.secondCell.showFace))          // OR first & second cell are FOUND
        )
    }
    func checkSecond(cell:CollectionViewCell)->Bool{
        return (!cell.showFace && !cell.mySelected &&                           // cell has not been found or selected
                self.firstCell.mySelected && self.firstCell != cell &&          // first is already SELECTED & NOT the curren cell
                (!self.secondCell.mySelected || self.secondCell.showFace))      // second cell NOT SELECTED OR already FOUND
    }
    func selectCell(cell:CollectionViewCell,indexPath:NSIndexPath){
        cell.mySelected = true
        cell.label.text = cardsMat[indexPath.row][indexPath.section]
        cell.backgroundColor = UIColor.blueColor()
    }
    func cellsFound(){
        self.firstCell.showFace = true
        self.secondCell.showFace = true
        self.firstCell.backgroundColor = UIColor.greenColor()
        self.secondCell.backgroundColor = UIColor.greenColor()
    }
    func move(cell:CollectionViewCell,indexPath:NSIndexPath)->Int{
        
        // first card pick
        if (checkFirst(cell)){
            selectCell(cell,indexPath:indexPath)
            self.firstCell = cell
            print("FIRST = \(cell.label.text)")
        }
        // second card pick
        else if (checkSecond(cell)){
                selectCell(cell,indexPath: indexPath)
                self.secondCell = cell
                print("SECOND = \(cell.label.text)")
                
                if(checkMatch()){
                        cellsFound()
                    score++
                        print("MATCH = \(self.firstCell.label.text) = \(self.secondCell.label.text)")
                }
                else{
                        NSTimer.scheduledTimerWithTimeInterval(1, target: self,selector:  Selector("hideCards:"), userInfo: nil, repeats: false)
                }
        }
        // fast clicker
        else
        {
            if (secondCell == firstCell) {
                selectCell(cell,indexPath: indexPath)
                self.secondCell = cell
                if(checkMatch()){
                    cellsFound()
                    score++
                    print("MATCH = \(self.firstCell.label.text) = \(self.secondCell.label.text)")
                }
                else{
                    NSTimer.scheduledTimerWithTimeInterval(1, target: self,selector:  Selector("hideCards:"), userInfo: nil, repeats: false)
                }
            }
        }
        return score
    }
}