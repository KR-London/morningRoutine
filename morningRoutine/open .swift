//
//  timetableCollectionViewController.swift
//  morningRoutine
//
//  Created by Kate Roberts on 26/09/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

let testing = false

class timetableCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var taskMatrix = Array(repeating: Array(repeating: (false, taskStatus.Open), count: 14), count: 13)
    var startingPoint : Date?
    
    override func viewWillAppear(_ animated: Bool) {
        
//        if testing == true{
//              //startingPoint = DispatchTime.now()
//            startingPoint = Date()
//          }
//        else{
//            startingPoint = getDateFromHour(hour: 19)
//        }
//
//
//        let lineView = LineView(frame: CGRect( x: 0, y: view.frame.size.height/13, width: 10, height: 10) )
//
//        //print(taskMatrix)
//        view.addSubview(lineView)
//        updateLine()
//        /// in the real thing I'd need to figure out the current time > status matrix at the point the app is launched
//        if testing == true
//        {
//            Timer.scheduledTimer(timeInterval: 1, target: self, selector: "updateLine", userInfo: nil, repeats: true)
//        }
//        else{
//            Timer.scheduledTimer(timeInterval: 60, target: self, selector: "updateLine", userInfo: nil, repeats: true)
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if testing == true{
              //startingPoint = DispatchTime.now()
            startingPoint = Date()
          }
        else{
            startingPoint = getDateFromHour(hour: 6)
        }


        let lineView = LineView(frame: CGRect( x: 0, y: view.frame.size.height/13, width: 10, height: 10) )

        //print(taskMatrix)
        view.addSubview(lineView)
        updateLine()
        /// in the real thing I'd need to figure out the current time > status matrix at the point the app is launched
        if testing == true
        {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: "updateLine", userInfo: nil, repeats: true)
        }
        else{
            Timer.scheduledTimer(timeInterval: 60, target: self, selector: "updateLine", userInfo: nil, repeats: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadInputViews()
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 13
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let width = (self.view.frame.size.height) / 15//some width
        let height = (self.view.frame.size.width) / 18
               return CGSize(width: width, height: height)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> timetableCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! timetableCollectionViewCell
        cell.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        cell.label.text = " "
        
        if indexPath.row == 0{
            cell.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            //if indexPath.row == 1 {}
            switch indexPath.section {
                case 1: cell.label.text = "6:00"
                case 2: cell.label.text = "6:15"
                case 3: cell.label.text = "6:30"
                case 4: cell.label.text = "6:45"
                case 5: cell.label.text = "7:00"
                case 6: cell.label.text = "7:15"
                case 7: cell.label.text = "7:30"
                case 8: cell.label.text = "7:45"
                case 9: cell.label.text = "8:00"
                case 10: cell.label.text = "8:15"
                case 11: cell.label.text = "8:30"
                case 12: cell.label.text = "8:45"
                default: cell.label.text = "Name"
            }
        }
        if indexPath.row == 2{
                if taskMatrix[indexPath.section][2].1 == taskStatus.Open && taskMatrix[indexPath.section][2].0 == false
                {
                       cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                }
                if taskMatrix[indexPath.section][2].1 == taskStatus.Closed && taskMatrix[indexPath.section][2].0 == false
                {
                        cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                }
            
                if taskMatrix[indexPath.section][2].1 == taskStatus.Open && taskMatrix[indexPath.section][2].0 == true
                {
                        cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                        cell.wobble()
               }
               if taskMatrix[indexPath.section][2].1 == taskStatus.Closed && taskMatrix[indexPath.section][2].0 == true
                {
                       cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }
                       
            
            
                       //if indexPath.row == 1 {}
                       switch indexPath.section {
                           case 1: cell.label.text = "Make Porridge"
                           case 2: cell.label.text = "Feed"
                           case 3: cell.label.text = "Feed"
                           case 4: cell.label.text = "Pack"
                           case 5: cell.label.text = "Dress"
                           case 6: cell.label.text = "Drive Xen"
                           case 7: cell.label.text = "Drive Xen"
                           case 8: cell.label.text = "Support Boys"
                           case 9: cell.label.text = "End Food"
                           case 10: cell.label.text = "Dress girls"
                           case 11: cell.label.text = "Hair&Book"
                           case 12: cell.label.text = "Leave"
                           default: cell.label.text = "Adult"
                            cell.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                       }
                   }
        
        if indexPath.row == 4{
        if taskMatrix[indexPath.section][4].1 == taskStatus.Open
        {
               cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else
        {
                cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        }
               //if indexPath.row == 1 {}
               switch indexPath.section {
                   case 1: cell.label.text = " "
                   case 2: cell.label.text = " "
                   case 3: cell.label.text = "Wake"
                   case 4: cell.label.text = "Pack"
                   case 5: cell.label.text = "Eat"
                   case 6: cell.label.text = "Leave"
                   case 7: cell.label.text = " "
                   case 8: cell.label.text = " "
                   case 9: cell.label.text = " "
                   case 10: cell.label.text = " "
                   case 11: cell.label.text = " "
                   case 12: cell.label.text = " "
                   default: cell.label.text = "Xenia"
                    cell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
               }
           }
        
        if indexPath.row == 5{
            if taskMatrix[indexPath.section][5].1 == taskStatus.Open
            {
                   cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            else
            {
                    cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
                   //if indexPath.row == 1 {}
                   switch indexPath.section {
                       case 1: cell.label.text = " "
                       case 2: cell.label.text = " "
                       case 3: cell.label.text = " "
                       case 4: cell.label.text = " "
                       case 5: cell.label.text = " "
                       case 6: cell.label.text = " "
                       case 7: cell.label.text = " "
                       case 8: cell.label.text = " "
                       case 9: cell.label.text = " "
                       case 10: cell.label.text = " "
                       case 11: cell.label.text = " "
                       case 12: cell.label.text = " "
                       default: cell.label.text = "Xenia"
                        cell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                   }
               }
            
        if indexPath.row == 6{
                if taskMatrix[indexPath.section][6].1 == taskStatus.Open
                {
                       cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                }
                else
                {
                        cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                }
                       //if indexPath.row == 1 {}
                       switch indexPath.section {
                           case 1: cell.label.text = "Wake Up"
                           case 2: cell.label.text = "Eat"
                           case 3: cell.label.text = "Eat"
                           case 4: cell.label.text = "Piano"
                           case 5: cell.label.text = "Piano"
                           case 6: cell.label.text = "Get Ready"
                           case 7: cell.label.text = "Breathe"
                           case 8: cell.label.text = "Leave"
                           case 9: cell.label.text = " "
                           case 10: cell.label.text = " "
                           case 11: cell.label.text = " "
                           case 12: cell.label.text = " "
                           default: cell.label.text = "Peter"
                            cell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                       }
                   }
        
        if indexPath.row == 7{
                     if taskMatrix[indexPath.section][7].1 == taskStatus.Open
                     {
                            cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                     }
                     else
                     {
                             cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                     }
                            //if indexPath.row == 1 {}
                            switch indexPath.section {
                                case 1: cell.label.text = "Make Bed"
                                case 2: cell.label.text = "Teeth"
                                case 3: cell.label.text = "Pack Lunch"
                                case 4: cell.label.text = " "
                                case 5: cell.label.text = "Prayer"
                                case 6: cell.label.text = " "
                                case 7: cell.label.text = " "
                                case 8: cell.label.text = " "
                                case 9: cell.label.text = " "
                                case 10: cell.label.text = " "
                                case 11: cell.label.text = " "
                                case 12: cell.label.text = " "
                                default: cell.label.text = "Peter"
                                 cell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                            }
                        }
        
        if indexPath.row == 8{
            if taskMatrix[indexPath.section][8].1 == taskStatus.Open
            {
                   cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            else
            {
                    cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
                   //if indexPath.row == 1 {}
                   switch indexPath.section {
                       case 1: cell.label.text = "Wake Up"
                       case 2: cell.label.text = "Eat"
                       case 3: cell.label.text = "Eat"
                       case 4: cell.label.text = "Dressed "
                       case 5: cell.label.text = "Get Ready"
                       case 6: cell.label.text = "Piano"
                       case 7: cell.label.text = "Front"
                       case 8: cell.label.text = "Leave"
                       case 9: cell.label.text = " "
                       case 10: cell.label.text = " "
                       case 11: cell.label.text = " "
                       case 12: cell.label.text = " "
                       default: cell.label.text = "Lenny"
                        cell.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                   }
               }
        
        if indexPath.row == 9{
            if taskMatrix[indexPath.section][9].1 == taskStatus.Open
            {
                   cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            else
            {
                    cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
                   //if indexPath.row == 1 {}
                   switch indexPath.section {
                       case 1: cell.label.text = "Make Bed"
                       case 2: cell.label.text = " "
                       case 3: cell.label.text = " "
                       case 4: cell.label.text = "Teeth & Hair"
                       case 5: cell.label.text = " "
                       case 6: cell.label.text = " "
                       case 7: cell.label.text = " "
                       case 8: cell.label.text = " "
                       case 9: cell.label.text = " "
                       case 10: cell.label.text = " "
                       case 11: cell.label.text = " "
                       case 12: cell.label.text = " "
                       default: cell.label.text = "Lenny"
                        cell.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                   }
               }
        
        if indexPath.row == 10{
            if taskMatrix[indexPath.section][10].1 == taskStatus.Open
            {
                   cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            else
            {
                    cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
                   //if indexPath.row == 1 {}
                   switch indexPath.section {
                       case 1: cell.label.text = " "
                       case 2: cell.label.text = " "
                       case 3: cell.label.text = " "
                       case 4: cell.label.text = " "
                       case 5: cell.label.text = " "
                       case 6: cell.label.text = "Wake Up"
                       case 7: cell.label.text = "Eat"
                       case 8: cell.label.text = " Eat"
                       case 9: cell.label.text = " Dress"
                       case 10: cell.label.text = " Reading"
                       case 11: cell.label.text = "Leave"
                       case 12: cell.label.text = " "
                       default: cell.label.text = "Marina"
                        cell.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                   }
               }
        
        
         if indexPath.row == 11{
             if taskMatrix[indexPath.section][10].1 == taskStatus.Open
             {
                    cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
             }
             else
             {
                     cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
             }
                    //if indexPath.row == 1 {}
                    switch indexPath.section {
                        case 1: cell.label.text = " "
                        case 2: cell.label.text = " "
                        case 3: cell.label.text = " "
                        case 4: cell.label.text = " "
                        case 5: cell.label.text = " "
                        case 6: cell.label.text = " "
                        case 7: cell.label.text = " "
                        case 8: cell.label.text = "Tidy Plate"
                        case 9: cell.label.text = " Teeth&Hair"
                        case 10: cell.label.text = "Tie and Jumper"
                        case 11: cell.label.text = "Socks & shoes"
                        case 12: cell.label.text = " "
                        default: cell.label.text = "Marina"
                         cell.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                    }
                }
        
        if indexPath.row == 12{
                 if taskMatrix[indexPath.section][12].1 == taskStatus.Open
                 {
                        cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                 }
                 else
                 {
                         cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                 }
                        //if indexPath.row == 1 {}
                        switch indexPath.section {
                            case 1: cell.label.text = " "
                            case 2: cell.label.text = " "
                            case 3: cell.label.text = " "
                            case 4: cell.label.text = "Wake Up"
                            case 5: cell.label.text = "Eat"
                            case 6: cell.label.text = "Eat"
                            case 7: cell.label.text = "Dress"
                            case 8: cell.label.text = " Read"
                            case 9: cell.label.text = " Teeth "
                            case 10: cell.label.text = " Hair "
                            case 11: cell.label.text = "Leave"
                            case 12: cell.label.text = " "
                            default: cell.label.text = "Cass"
                             cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                        }
                    }
        
        if indexPath.row == 13{
                  if taskMatrix[indexPath.section][13].1 == taskStatus.Open
                  {
                         cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                  }
                  else
                  {
                          cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                  }
                         //if indexPath.row == 1 {}
                         switch indexPath.section {
                             case 1: cell.label.text = " "
                             case 2: cell.label.text = " "
                             case 3: cell.label.text = " "
                             case 4: cell.label.text = " "
                             case 5: cell.label.text = " "
                             case 6: cell.label.text = " "
                             case 7: cell.label.text = " "
                             case 8: cell.label.text = " "
                             case 9: cell.label.text = " "
                             case 10: cell.label.text = " "
                             case 11: cell.label.text = " "
                             case 12: cell.label.text = " "
                             default: cell.label.text = "Cass"
                              cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                         }
                     }
        
        if cell.label.text == " " {
            switch indexPath.row {
            //case 1:
           // case 2:
           // case 3:
                case 4:cell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                           case 5: cell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                           case 6: cell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                case 7: cell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                           case 8: cell.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                           case 9: cell.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                case 10:  cell.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                           case 11:  cell.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                           case 12: cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                case 13: cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            default: cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
        
        if taskMatrix[indexPath.section][indexPath.row].0 == true
        {
            if cell.backgroundColor ==  #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1){
                cell.wobble()
                //xcell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }
            else{
                    //cell.alpha = 0.2
                  cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }
        }
        
        if  taskMatrix[indexPath.section][indexPath.row].0 == true  && cell.backgroundColor ==  #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)  {
          cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        
        var elapsedTime = -Int(  startingPoint!.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate)
        
        if indexPath.section < (elapsedTime/(60*15)+2) && cell.backgroundColor ==  #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        {
            cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
          
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //  addToList.append(objectsArray[indexPath.row])
        let cell = collectionView.cellForItem(at: indexPath) as! timetableCollectionViewCell
        print("selected", cell.label.text!)
        cell.layer.borderWidth = 2.0
        if cell.backgroundColor == #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        {
            if taskMatrix[indexPath.section][indexPath.row].0 == false
            {
                cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
            else
            {
                cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }
            cell.stopWobble()
            taskMatrix[indexPath.section][indexPath.row].1 = taskStatus.Closed
        }
        else{
            if cell.backgroundColor ==  #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            {
                cell.backgroundColor =  #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                
                taskMatrix[indexPath.section][indexPath.row].1 = taskStatus.Open
            }
        }
        
        if cell.label.text == "Leave"
        {
            performSegue(withIdentifier: "leave", sender: self)
        }
        
        if cell.label.text == "Get Ready"
        {
            performSegue(withIdentifier: "list", sender: self)
        }
    }
    
    //Update clock every second
    @objc func updateLine() {
        var elapsedTime = -Int( startingPoint!.timeIntervalSince1970 - Date().timeIntervalSince1970 )
        if testing == true
        {
            if elapsedTime < 12
            {

                let screenHeight = view.frame.size.height
                    view.subviews[1].frame = CGRect( x: 0, y: (screenHeight * CGFloat(elapsedTime + 2) ) / 13, width: 1000, height: 10 )
                

                for itemsIndex in 0 ... 13{
                    taskMatrix[elapsedTime ][itemsIndex].0 = true
                }
                self.collectionView.reloadSections(NSIndexSet(index: elapsedTime ) as IndexSet)
            }
        }
        else{
            if elapsedTime < 3*3600
            {
                let screenHeight = view.frame.size.height
                    elapsedTime = elapsedTime*12/(3*3600)
                    print(elapsedTime)
                    view.subviews[1].frame = CGRect( x: 0, y: (screenHeight * CGFloat(elapsedTime + 3 ) ) / 13, width: 1000, height: 10 )

                for itemsIndex in 0 ... 13{
                    taskMatrix[elapsedTime][itemsIndex].0 = true
                }
                self.collectionView.reloadSections(NSIndexSet(index: elapsedTime - 1 ) as IndexSet)
            }
        }
    }
    
    func getDateFromHour(hour: Int) -> Date {
      let date = Date()
      let calendar = Calendar.current
      let componentsCurrent = calendar.dateComponents([.year, .month, .day], from: date)

      var components = DateComponents()
      components.hour = hour
      components.minute = 0
      components.second = 0
      components.month = componentsCurrent.month
      components.day = componentsCurrent.day
      components.year = componentsCurrent.year
      return calendar.date(from: components)!
    }

}

class LineView : UIView {

    var position = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(10)
            context.beginPath()
            context.move(to: CGPoint(x: 0.0, y: 00.0)) // This would be oldX, oldY
            context.addLine(to: CGPoint(x: 1500.0, y: 0.0)) // This would be newX, newY
            context.strokePath()
        }
    }
}

